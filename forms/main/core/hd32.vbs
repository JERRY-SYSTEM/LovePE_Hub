REGI $HKCU\SOFTWARE\LovePE_Hub\HubDir,HubDir
REGI $HKCU\SOFTWARE\LovePE_Hub\hd32menu,menu
REGI $HKCU\SOFTWARE\LovePE_Hub\hd32wait,wait
REGI $HKCU\SOFTWARE\LovePE_Hub\hd32menu=
REGI $HKCU\SOFTWARE\LovePE_Hub\hd32wait=
REGI $HKCU\SOFTWARE\LovePE_Hub\hd32,hd32
REGI #HKCU\SOFTWARE\LovePE_Hub\hd32=
CALL @hd32pbar

_SUB hd32pbar,W300H100,请稍等...,,%CurDir%\pecmd.exe,,,-disaltmv
PBAR percent,L10T10W270H30,0
LABE character,L10T45W270H20
TIME if,100,CALL @hd32%hd32%
_END

_SUB hd321
ENVI @if=-del
ENVI @hd32pbar=LovePE本地模式添加中...
ENVI @percent=10
ENVI @character=正在复制文件到对应目录
MDIR %SystemDrive%\LovePEboot
FILE "%HubDir%Data\BOOT\11PEX64.WIM"=>%SystemDrive%\LovePEboot\LovePE.wim
FILE %HubDir%Data\LovePE=>%SystemDrive%\
EXEC =!%CurDir%\UltraISO.exe -silent -unattend -in %HubDir%Data\EFI.ISO -get "/BOOT/BOOT.SDI" -extract %SystemDrive%\LovePEboot
SITE %SystemDrive%\LovePEboot\BOOT.SDI,+S+H
SITE %SystemDrive%\LovePEboot\LovePE.WIM,+S+H
SITE %SystemDrive%\LovePEboot,+S+H
ENVI @percent=50
ENVI @character=正在添加引导
WRIT-ANSI %Temp%\addhd32.bat,$+0,set menu=%menu%
WRIT-ANSI %Temp%\addhd32.bat,+0,set bcdwim={2b27e930-f7ab-11df-aeb8-c641fe7f0057}
WRIT-ANSI %Temp%\addhd32.bat,+0,set bcdsdi={2b27e930-f7ab-11df-aeb8-c641fe7f0050}
PART LIST DRV %SystemDrive%,ifgptlist
MSTR ifgpt=42,3,%ifgptlist%
IFEX |%ifgptlist%=GPT,
{
	WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdwim% path \Windows\system32\boot\winload.efi
}!
{
	WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdwim% path \windows\system32\boot\winload.exe
}
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /create %bcdsdi% /d "%menu%" /device
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdsdi% ramdisksdidevice partition=%SystemDrive%
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdsdi% ramdisksdipath "\LovePEboot\BOOT.SDI"
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /create %bcdwim% /d "%menu%" /application osloader
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdwim% device ramdisk="[%SystemDrive%]\LovePEboot\LovePE.wim",%bcdsdi%
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdwim% osdevice ramdisk="[%SystemDrive%]\LovePEboot\LovePE.wim",%bcdsdi%
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdwim% description "%menu%"
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdwim% locale zh-CN
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdwim% inherit {bootloadersettings}
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdwim% systemroot \windows
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdwim% detecthal Yes
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdwim% winpe Yes
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /set %bcdwim% ems no
WRIT-ANSI %Temp%\addhd32.bat,+0,bcdedit /displayorder %bcdwim% /addlast
WRIT-ANSI %Temp%\addhd32.bat,$+0,bcdedit /timeout %wait%
WRIT-ANSI %Temp%\addhd32.bat,+0,exit
EXEC =!%Temp%\addhd32.bat
FILE %Temp%\addhd32.bat
ENVI @percent=100
ENVI @character=完成
MESS-icon3 \n  本地模式添加启动项成功。 @成功 #OK *3000
EXIT FILE
_END

_SUB hd322
ENVI @if=-del
ENVI @hd32pbar=LovePE本地模式删除中...
ENVI @percent=10
ENVI @character=正在删除引导
WRIT-ANSI %Temp%\uninstallhd32.bat,+0,bcdedit /delete {2b27e930-f7ab-11df-aeb8-c641fe7f0057}
WRIT-ANSI %Temp%\uninstallhd32.bat,+0,bcdedit /delete {2b27e930-f7ab-11df-aeb8-c641fe7f0050}
EXEC =!%Temp%\uninstallhd32.bat
FILE %Temp%\addhd32.bat
ENVI @percent=50
ENVI @character=正在删除文件
SITE %SystemDrive%\LovePEboot\BOOT.SDI,-S-H
SITE %SystemDrive%\LovePEboot\LovePE.WIM,-S-H
FILE %SystemDrive%\LovePEboot\LovePE.WIM
FILE %SystemDrive%\LovePEboot\BOOT.SDI
FILE %SystemDrive%\LovePEboot
ENVI @percent=100
ENVI @character=完成
MESS-icon3 \n  本地模式删除启动项成功。 @成功 #OK *3000
EXIT FILE
_END

_SUB hd323
ENVI @if=-del
ENVI @hd32pbar=LovePEVHD本地模式添加中...
ENVI @percent=10
ENVI @character=正在复制文件到对应目录
MDIR %SystemDrive%\LovePEboot
IFEX "%HubDir%vhdpe\11PEX64.VHD",FILE "%HubDir%vhdpe\11PEX64.VHD"=>%SystemDrive%\LovePEboot! TEAM MESS-icon1 \n 未在目录 %HubDir%vhdpe 下发现VHDPE镜像，请先生成。 @未发现镜像 #OK *5000|EXIT FILE
IFEX "%HubDir%vhdpe\11PEX64Dad.VHD",TEAM FILE "%HubDir%vhdpe\11PEX64Dad.VHD"=>%SystemDrive%\LovePEboot|FILE "%HubDir%vhdpe\11PEX64Son.VHD"=>%SystemDrive%\LovePEboot
SITE %SystemDrive%\LovePEboot\*.vhd,+S+H
SITE %SystemDrive%\LovePEboot,+S+H
FILE %HubDir%Data\LovePE=>%SystemDrive%\
ENVI @percent=50
ENVI @character=正在添加引导
WRIT-ANSI %Temp%\vhd_addhd32.bat,$+0,set menu=%menu%
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,set bcdvhd={2b27e930-f7ab-11df-aeb8-c641fe7f0056}
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /create %bcdvhd% /d "%menu%" /application osloader
PART LIST DRV %SystemDrive%,ifgptlist
MSTR ifgpt=42,3,%ifgptlist%
IFEX |%ifgptlist%=GPT,
{
	WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /set %bcdvhd% path \Windows\system32\boot\winload.efi
}!
{
	WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /set %bcdvhd% path \windows\system32\boot\winload.exe
}
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /set %bcdvhd% device vhd="[%SystemDrive%]\LovePEboot\11PEX64.vhd"
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /set %bcdvhd% osdevice vhd="[%SystemDrive%]\LovePEboot\11PEX64.vhd"
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /set %bcdvhd% description "%menu%"
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /set %bcdvhd% locale zh-CN
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /set %bcdvhd% systemroot \windows
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /set %bcdvhd% detecthal Yes
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /set %bcdvhd% winpe Yes
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /set %bcdvhd% ems no
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /displayorder %bcdvhd% /addlast
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,bcdedit /timeout %wait%
WRIT-ANSI %Temp%\vhd_addhd32.bat,+0,exit
EXEC =!%Temp%\vhd_addhd32.bat
FILE %Temp%\vhd_addhd32.bat
ENVI @percent=100
ENVI @character=完成
MESS-icon3 \n  VHDPE添加启动项成功。 @成功 #OK *3000
EXIT FILE
_END

_SUB hd324
ENVI @if=-del
ENVI @hd32pbar=LovePEVHD本地模式删除中...
ENVI @percent=10
ENVI @character=正在删除引导
WRIT-ANSI %Temp%\vhd_uninstallhd32.bat,+0,bcdedit /delete {2b27e930-f7ab-11df-aeb8-c641fe7f0056}
EXEC =!%Temp%\vhd_uninstallhd32.bat
FILE %Temp%\vhd_addhd32.bat
ENVI @percent=50
ENVI @character=正在删除文件
SITE %SystemDrive%\LovePEboot\*.vhd,-S-H
FILE %SystemDrive%\LovePEboot\*.vhd
FILE %SystemDrive%\LovePEboot
ENVI @percent=100
ENVI @character=完成
MESS-icon3 \n  VHDPE删除启动项成功。 @成功 #OK *3000
EXIT FILE
_END