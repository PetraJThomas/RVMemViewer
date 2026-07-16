@echo off
REM setup.bat - fetch third-party dependencies after a fresh clone.
REM Analogous to `npm install`. Pins Dear ImGui to a known-good commit.
setlocal

set "ROOT=%~dp0"
set "IMGUI_DIR=%ROOT%third_party\imgui"
set "IMGUI_URL=https://github.com/ocornut/imgui.git"
REM Pinned Dear ImGui release tag. Bump deliberately.
set "IMGUI_TAG=v1.92.8"

where git >nul 2>nul
if errorlevel 1 (
    echo ERROR: git not found on PATH. Install Git and retry.
    exit /b 1
)

if exist "%IMGUI_DIR%\imgui.cpp" (
    echo Dear ImGui already installed at third_party\imgui
    echo   ^(delete that folder and re-run setup.bat to reinstall^)
    goto :done
)

echo Installing Dear ImGui %IMGUI_TAG% ...
git clone -q --depth 1 --branch %IMGUI_TAG% "%IMGUI_URL%" "%IMGUI_DIR%" || goto :fail

if not exist "%IMGUI_DIR%\imgui.cpp" goto :fail
echo Done.

:done
echo.
echo Dependencies ready. Build with:  build.bat
exit /b 0

:fail
echo.
echo ERROR: failed to fetch Dear ImGui. Check your network / git and retry.
exit /b 1
