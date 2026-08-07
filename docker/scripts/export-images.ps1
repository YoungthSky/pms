<# ============================================
PMS Docker Image Export Script (PowerShell)
Run on internet-connected dev machine.
Usage: .\export-images.ps1 [-Version "v1.0.0"]
============================================ #>

param(
    [string]$Version = "v1.0.0"
)

$ErrorActionPreference = "Stop"

# ---------- Ensure Maven is in PATH ----------
if (-not (Get-Command mvn -ErrorAction SilentlyContinue)) {
    $mavenHome = "C:\maven\apache-maven-3.9.6"
    if (Test-Path "$mavenHome\bin\mvn.cmd") {
        $env:PATH = "$env:PATH;$mavenHome\bin"
        Write-Host "[INFO] Maven found at $mavenHome (added to session PATH)" -ForegroundColor DarkGray
    } else {
        throw "Maven not found! Please install Maven or set MAVEN_HOME."
    }
}

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectDir = (Get-Item "$ScriptDir\..\..").FullName
$ExportDir = Join-Path $ProjectDir "docker-export"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "PMS Offline Deploy Package Builder" -ForegroundColor Cyan
Write-Host "Version: $Version" -ForegroundColor Cyan
Write-Host "Output:  $ExportDir" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# ---------- Step 1: Build backend JAR ----------
Write-Host "[Step 1/5] Building backend JAR..." -ForegroundColor Yellow
Set-Location $ProjectDir
& mvn clean package -DskipTests -q
if ($LASTEXITCODE -ne 0) { throw "Maven build failed!" }
Copy-Item "$ProjectDir\pms-admin\target\pms-admin.jar" "$ProjectDir\docker\backend\pms-admin.jar" -Force
Write-Host "  -> JAR build OK" -ForegroundColor Green

# ---------- Step 2: Build frontend ----------
Write-Host "[Step 2/5] Building frontend..." -ForegroundColor Yellow
Set-Location "$ProjectDir\pms-ui-ts"
& npm install --silent
if ($LASTEXITCODE -ne 0) { throw "npm install failed!" }
& npm run build:prod
if ($LASTEXITCODE -ne 0) { throw "Frontend build failed!" }
$nginxDist = "$ProjectDir\docker\nginx\dist"
if (Test-Path $nginxDist) { Remove-Item $nginxDist -Recurse -Force }
Copy-Item "$ProjectDir\pms-ui-ts\dist" $nginxDist -Recurse -Force
Write-Host "  -> Frontend build OK" -ForegroundColor Green

# ---------- Step 3: Pull base images ----------
Write-Host "[Step 3/5] Pulling base images..." -ForegroundColor Yellow
& docker pull mysql:8.0
if ($LASTEXITCODE -ne 0) { throw "Failed to pull mysql:8.0" }
& docker pull redis:7
if ($LASTEXITCODE -ne 0) { throw "Failed to pull redis:7" }
& docker pull eclipse-temurin:17-jre
if ($LASTEXITCODE -ne 0) { throw "Failed to pull eclipse-temurin:17-jre" }
& docker pull nginx:latest
if ($LASTEXITCODE -ne 0) { throw "Failed to pull nginx:latest" }
Write-Host "  -> Base images pulled OK" -ForegroundColor Green

# ---------- Step 4: Build app images ----------
Write-Host "[Step 4/5] Building app images..." -ForegroundColor Yellow
Set-Location $ProjectDir
& docker build -t "pms-backend:${Version}" -f docker/backend/Dockerfile docker/backend/
if ($LASTEXITCODE -ne 0) { throw "Backend image build failed!" }
& docker build -t "pms-frontend:${Version}" -f docker/nginx/Dockerfile docker/nginx/
if ($LASTEXITCODE -ne 0) { throw "Frontend image build failed!" }
Write-Host "  -> App images build OK" -ForegroundColor Green

# ---------- Step 5: Export offline package ----------
Write-Host "[Step 5/5] Exporting offline package..." -ForegroundColor Yellow
if (-not (Test-Path $ExportDir)) { New-Item -ItemType Directory -Path $ExportDir -Force | Out-Null }

Write-Host "  Saving Docker images (may take a few minutes)..."
& docker save mysql:8.0 redis:7 "pms-backend:${Version}" "pms-frontend:${Version}" -o "$ExportDir\pms-images-${Version}.tar"
if ($LASTEXITCODE -ne 0) { throw "Docker save failed!" }

Write-Host "  Copying deploy config files..."
Copy-Item "$ProjectDir\docker-compose.yml" "$ExportDir\" -Force
Copy-Item "$ProjectDir\.env.docker" "$ExportDir\" -Force
# 先删除旧的 docker/ 和 sql/ 目录，防止残留文件污染
if (Test-Path "$ExportDir\docker") { Remove-Item "$ExportDir\docker" -Recurse -Force }
if (Test-Path "$ExportDir\sql")    { Remove-Item "$ExportDir\sql" -Recurse -Force }
Copy-Item "$ProjectDir\docker" "$ExportDir\docker" -Recurse -Force
Copy-Item "$ProjectDir\sql" "$ExportDir\sql" -Recurse -Force
Copy-Item "$ProjectDir\docker\scripts" "$ExportDir\scripts" -Recurse -Force

# Create deploy readme
$deployInfo = @"
============================================
PMS Offline Deploy Package - $Version
Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
============================================

Deploy steps (on internal server):

1. Copy entire docker-export folder to server /opt/pms/

2. cd /opt/pms

3. Load Docker images:
   docker load -i pms-images-$Version.tar

4. Edit config (IMPORTANT - change all passwords!):
   vi .env.docker

5. Start services:
   docker-compose --env-file .env.docker up -d

6. Check status:
   docker-compose --env-file .env.docker ps
   docker-compose --env-file .env.docker logs -f backend

7. Access:
   http://SERVER_IP:80
   Default login: admin / admin123

============================================
Common commands:

# Stop
docker-compose --env-file .env.docker down

# Restart backend
docker restart pms-backend

# View logs
docker logs -f --tail 100 pms-backend

# Backup
bash scripts/backup.sh full

# Restore
bash scripts/restore.sh list
bash scripts/restore.sh db <backup_file>

# Upgrade
bash scripts/upgrade.sh v2.0.0
============================================
"@
$deployInfo | Out-File -FilePath "$ExportDir\DEPLOY.txt" -Encoding ASCII

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "Offline package build COMPLETE!" -ForegroundColor Green
Write-Host ""
Write-Host "Output: $ExportDir"
Write-Host ""
Write-Host "Files:"
Get-ChildItem $ExportDir | ForEach-Object {
    if ($_.PSIsContainer) {
        Write-Host ("  [DIR]  {0}" -f $_.Name)
    } else {
        Write-Host ("  {0,-40} {1:N2} MB" -f $_.Name, ($_.Length / 1MB))
    }
}
$totalSize = (Get-ChildItem $ExportDir -Recurse -File | Measure-Object -Property Length -Sum).Sum
Write-Host ""
Write-Host ("Total size: {0:N2} GB" -f ($totalSize / 1GB))
Write-Host ""
Write-Host "Next: Copy $ExportDir to the internal server" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Green
