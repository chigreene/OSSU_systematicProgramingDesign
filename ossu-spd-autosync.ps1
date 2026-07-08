# ossu-spd-autosync.ps1
# Daily auto-sync script for the OSSU Systematic Program Design repo.
# Logic:
#   1. If already pushed today (per marker file), do nothing.
#   2. Otherwise, pull-rebase, stage all changes, commit, and push.
#   3. Log every outcome to sync_log.txt.
#   4. On rebase conflict, abort and log loudly rather than guessing.

$RepoPath   = "C:\Users\Gr33N3 Beast\Desktop\Desktop Subfolder\OSSU\Systematic Program Design"
$MarkerFile = Join-Path $RepoPath ".last_push_date.txt"
$LogFile    = Join-Path $RepoPath "sync_log.txt"

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogFile -Value "[$timestamp] $Message"
}

Set-Location $RepoPath
$today = Get-Date -Format "yyyy-MM-dd"

# --- Step 1: Have we already pushed today? ---
if (Test-Path $MarkerFile) {
    $lastPush = (Get-Content $MarkerFile -Raw).Trim()
    if ($lastPush -eq $today) {
        Write-Log "No action - already pushed today ($today)."
        exit 0
    }
}

# --- Step 2: Fetch remote state ---
git fetch origin 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Log "ERROR - 'git fetch' failed. Check network/SSH agent."
    exit 1
}

# --- Step 3: Rebase local commits on top of remote (safe merge) ---
git pull --rebase --autostash origin main 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    git rebase --abort 2>&1 | Out-Null
    Write-Log "CONFLICT - rebase failed and was aborted. Manual attention needed."
    exit 1
}

# --- Step 4: Stage everything (new, modified, deleted) ---
git add -A

$staged = git diff --cached --name-only
if (-not $staged) {
    Write-Log "Nothing to commit - no local changes since last sync."
    Set-Content -Path $MarkerFile -Value $today
    exit 0
}

$fileCount = ($staged | Measure-Object -Line).Lines

# --- Step 5: Commit ---
$commitMsg = "Auto-sync: $today ($fileCount files changed)"
git commit -m $commitMsg 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Log "ERROR - 'git commit' failed unexpectedly."
    exit 1
}

# --- Step 6: Push ---
git push origin main 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Log "ERROR - 'git push' failed after commit. Manual attention needed (local commit exists, not on remote)."
    exit 1
}

# --- Step 7: Success - update marker and log ---
Set-Content -Path $MarkerFile -Value $today
Write-Log "SUCCESS - $commitMsg"
