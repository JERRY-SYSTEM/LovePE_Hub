REGI $HKCU\SOFTWARE\LovePE_Hub\HubDir,HubDir
REGI $HKCU\SOFTWARE\LovePE_Hub\writelean,writelean
IFEX $%writelean%=3,
{
	REGI $HKCU\SOFTWARE\LovePE_Hub\disknum,disknumall
	RSTR disknum=1,%disknumall%
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /unhide:1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /setletter:1 /letter:auto
	MESS-icon3 启动分区取消隐藏成功！ @成功 #OK*5000
	EXIT FILE
}
IFEX $%writelean%=4,
{
	REGI $HKCU\SOFTWARE\LovePE_Hub\disknum,disknumall
	RSTR disknum=1,%disknumall%
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /hide:1
	MESS-icon3 启动分区隐藏成功！ @成功 #OK*5000
	EXIT FILE
}
//寻找USB
IFEX $%writelean%=5,
{
	REGI #HKCU\SOFTWARE\LovePE_Hub\ifin,ifin
	FILE %CurDir%\listdisk.txt
	IFEX $%ifin%=6,
	{
		EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /list /usb /out:%Temp%\finddisk.txt
	}!
	{
		EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /list /out:%Temp%\finddisk.txt
	}
	IFEX %Temp%\finddisk.txt,! 
	{
		REGI $HKCU\SOFTWARE\LovePE_Hub\aomeiable=
		WRIT-ANSI %temp%\finddisk.vbs,+0,Dim drive,moc
		WRIT-ANSI %temp%\finddisk.vbs,+0,set w32d_all = GetObject("Winmgmts:").InstancesOf("Win32_DiskDrive")
		WRIT-ANSI %temp%\finddisk.vbs,+0,for each w32d in w32d_all
		WRIT-ANSI %temp%\finddisk.vbs,+0,modl = w32d.Model
		WRIT-ANSI %temp%\finddisk.vbs,+0,id = w32d.Index
		WRIT-ANSI %temp%\finddisk.vbs,$+0,CreateObject("Wscript.Shell").Run("%CurDir%\commond.exe WRIT-UTF8 %CurDir%\listdisk.txt,+0," & modl & " ※ " & id )
		WRIT-ANSI %temp%\finddisk.vbs,+0,next
		EXEC =!%temp%\finddisk.vbs
		FILE %temp%\finddisk.vbs
		EXIT FILE
	}
	REGI $HKCU\SOFTWARE\LovePE_Hub\aomeiable=6
	WRIT-ANSI %Temp%\finddisk.txt,+0,.....................sign
	ENVI calcnum=0
	REGI #HKCU\SOFTWARE\LovePE_Hub\ifin=
	CALL @sign
}
CALL @writeui

//界面
_SUB writeui,W300H100,请稍等...,,%CurDir%\pecmd.exe,,,-disaltmv
PBAR percent,L10T10W270H30,0
LABE character,L10T45W270H20
TIME if,100,CALL @lean%writelean%
_END

//ISO
_SUB lean2
ENVI @if=-del
ENVI @writeui=LovePE导出ISO中...
IFEX %HubDir%Data\EFI.ISO,!TEAM MESS-icon3 未发现程序目录下的ISO，请下载。 @必要文件缺失 #OK *5000|EXIT FILE
IFEX %HubDir%Data\BOOT\11PEX64.wim,! TEAM MESS-icon1 未找到11PE镜像，请下载！ @必要文件缺失 #OK|EXIT FILE
IFEX %HubDir%Data\LovePE\DIYtool\DIYtool.lpini,! MESS-icon1 未找到LovePE目录，将无法使用自定义功能！ @文件缺失 #OK
BROW sending,&%Desktop%\LovePE.ISO,请选择ISO保存位置,ISO文件|*.ISO
ENVI @character=正在导出ISO到指定目录
ENVI @percent=20
FILE %HubDir%Data\EFI.ISO=>%sending%
IFEX %sending%,!TEAM MESS-icon3 保存位置错误。 @错误 #OK *5000|EXIT FILE
ENVI @character=正在添加11PE镜像
ENVI @percent=50
EXEC =!%CurDir%\UltraISO\UltraISO.exe -silent -in "%sending%" -f %HubDir%Data\BOOT
EXEC =!%CurDir%\UltraISO\UltraISO.exe -silent -in "%sending%" -f %HubDir%Data\LovePE
ENVI @character=完成
ENVI @percent=100
MESS-icon1 ISO文件导出完成！ @成功 #OK *3000
EXIT FILE
_END

//ventoy
_SUB lean1
ENVI @if=-del
ENVI @writeui=LovePE启动盘写入中...
IFEX %HubDir%Data\EFI.ISO,! TEAM MESS-icon1 未找到ISO镜像文件，请前往设置界面下载！ @必要文件缺失 #OK|EXIT FILE
IFEX %HubDir%Data\BOOT\11PEX64.wim,! TEAM MESS-icon1 未找到11PE镜像，请前往设置界面下载！ @必要文件缺失 #OK|EXIT FILE
IFEX %HubDir%Data\LovePE\DIYtool\DIYtool.lpini,! MESS-icon1 未找到LovePE目录，将无法使用自定义功能！ @文件缺失 #OK
REGI $HKCU\SOFTWARE\LovePE_Hub\engine,engine
REGI #HKCU\SOFTWARE\LovePE_Hub\diywall,diywall
REGI #HKCU\SOFTWARE\LovePE_Hub\diywall=
IFEX $%diywall%=6,
{
	REGI $HKCU\SOFTWARE\LovePE_Hub\diywalldirection,diywalldirection
	IFEX %HubDir%Data\LovePE\WALL\LovePEWALLpaper.jpg,FILE %HubDir%Data\LovePE\WALL\LovePEWALLpaper.jpg
	FILE %diywalldirection%=>%HubDir%Data\LovePE\WALL\LovePEWALLpaper.jpg
	REGI $HKCU\SOFTWARE\LovePE_Hub\diywalldirection=
}
IFEX $%engine%=4,
{
	ENVI @character=正在生成镜像
	ENVI @percent=15
	FILE %HubDir%Data\EFI.ISO=>%Temp%
	EXEC =!%CurDir%\UltraISO\UltraISO.exe -silent -in "%temp%\EFI.ISO" -f %HubDir%Data\BOOT
	EXEC =!%CurDir%\UltraISO\UltraISO.exe -silent -in "%temp%\EFI.ISO" -f %HubDir%Data\LovePE
	ENVI @character=正在调用UltraISO写入
	ENVI @percent=60
	REGI $HKCU\Software\EasyBoot Systems\UltraISO\5.0\USBBootPart=2
	REGI $HKCU\Software\EasyBoot Systems\UltraISO\5.0\USBMode=2
	EXEC =%CurDir%\UltraISO\UltraISO.exe -in "%temp%\EFI.ISO" -writeusb
	REGI $HKCU\Software\EasyBoot Systems\UltraISO\5.0\USBBootPart=
	REGI $HKCU\Software\EasyBoot Systems\UltraISO\5.0\USBMode=
	FILE "%temp%\EFI.ISO"
}
IFEX $%engine%=5,
{
	MESS-icon1  Ventoy模式需提前做好Ventoy启动盘。\n\n 如果您已经使用Ventoy做好启动盘，继续执行写入操作，请点'取消'；\n\n 如果您需要下载Ventoy，请点'是'；\n\n 如果您想暂时退出制作，请点'否'。 @确认 #YNC $C
	IFEX |%YESNO%=YES,TEAM EXEC explorer.exe "https://mirrors.nju.edu.cn/github-release/ventoy/Ventoy"|EXIT FILE
	IFEX |%YESNO%=NO,TEAM MESS-icon3 您选择退出制作。 @退出 #OK*5000|EXIT FILE
	BROW venlet,*C:\,请选择U盘分区根目录,,0x200
	ENVI @character=正在写入ISO文件
	ENVI @percent=10
	FILE %HubDir%Data\EFI.ISO=>%venlet%LovePE.ISO
	ENVI @character=正在添加11PE
	ENVI @percent=45
	EXEC =!%CurDir%\UltraISO\UltraISO.exe -silent -in %venlet%LovePE.ISO -f %HubDir%Data\BOOT
	ENVI @character=正在创建自定义功能文件夹
	ENVI @percent=80
	FILE %HubDir%Data\LovePE=>%venlet%
	ENVI @character=完成
	ENVI @percent=100
	MESS-icon3 Ventoy模式写入成功！ @成功 #OK*5000
}
EXIT FILE
_END

_SUB sign
CALC readnum = %calcnum% + 5
READ-ANSI %Temp%\finddisk.txt,%readnum%,readnamed
MSTR disknum=3,1,%readnamed%
MSTR named=22,0,%readnamed%
IFEX |%named%=sign,
{
	IFEX $%readnum%=5,WRIT-UTF8 %CurDir%\listdisk.txt,+0,请插入U盘
	FILE %Temp%\finddisk.txt
	EXIT FILE
}!
{
	WRIT-UTF8 %CurDir%\listdisk.txt,$+0,%named% ※ %disknum%
	CALC calcnum = %calcnum% + 1
	CALL @sign
}
_END