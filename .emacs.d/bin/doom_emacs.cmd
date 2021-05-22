@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
start runemacs -Q %args% -l ..\init.el -f "doom-run-all-startup-hooks-h"
POPD >NUL
ECHO ON