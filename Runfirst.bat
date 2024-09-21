@echo off
for /r %%f in (*.aardio.js) do (
    ren "%%f" "%%~nf"
)
for /r %%f in (*.vbs) do (
    ren "%%f" "%%~nf.wcs"
)
