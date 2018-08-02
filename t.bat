SETLOCAL ENABLEDELAYEDEXPANSION

set a="!temp.txt:e=a!"

echo %a%

IF "tamp.txt!"=="!temp.txt:e=a!" (
    ECHO found
) ELSE (
    ECHO neeot found
)