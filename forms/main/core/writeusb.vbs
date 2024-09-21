REGI $HKCU\SOFTWARE\LovePE_Hub\HubDir,HubDir
REGI $HKCU\SOFTWARE\LovePE_Hub\disknum,disknumall
RSTR disknum=1,%disknumall%
REGI $HKCU\SOFTWARE\LovePE_Hub\disknum=
REGI $HKCU\SOFTWARE\LovePE_Hub\engine,engine
REGI $HKCU\SOFTWARE\LovePE_Hub\fs,fs
REGI $HKCU\SOFTWARE\LovePE_Hub\fs=
REGI $HKCU\SOFTWARE\LovePE_Hub\label,label
REGI $HKCU\SOFTWARE\LovePE_Hub\label=
IFEX P:\*,! ENVI let1=P
IFEX Q:\*,! ENVI let1=Q
IFEX R:\*,! ENVI let1=R
IFEX S:\*,! ENVI let1=S
IFEX M:\*,! ENVI let1=M
IFEX N:\*,! ENVI let1=N
IFEX O:\*,! ENVI let1=O
IFEX T:\*,! ENVI let1=T
IFEX V:\*,! ENVI let1=V
IFEX W:\*,! ENVI let1=W
IFEX Y:\*,! ENVI let1=Y
REGI $HKCU\SOFTWARE\LovePE_Hub\writeusb,writeusb
REGI $HKCU\SOFTWARE\LovePE_Hub\writeusb=
TEAM DATE dated d|DATE datem min|DATE dates s
TEAM ENVI mdirnamed=%HubDir%Logs\write%dated%%datem%%dates%|MDIR %mdirnamed%
ENVI lognamed=0
CALL @writeusbui


//界面
_SUB writeusbui,W300H100,请稍等...,,%CurDir%\pecmd.exe,,,-disaltmv
PBAR percent,L10T10W270H30,0
LABE character,L10T45W270H20
TIME if,100,CALL @writeusb%writeusb%
_END

//写入
_SUB writeusb1
ENVI @if=-del
ENVI @writeusbui=LovePE启动盘写入中...
IFEX %HubDir%Data\EFI.ISO,! TEAM MESS-icon1 未找到ISO镜像文件，请前往设置界面下载！ @必要文件缺失 #OK|EXIT FILE
IFEX %HubDir%Data\BOOT\11PEX64.wim,! TEAM MESS-icon1 未找到11PE镜像，请前往设置界面下载！ @必要文件缺失 #OK|EXIT FILE
IFEX %HubDir%Data\LovePE\DIYtool\DIYtool.lpini,! MESS-icon1 未找到LovePE目录，将无法使用自定义功能！ @文件缺失 #OK
REGI #HKCU\SOFTWARE\LovePE_Hub\diywall,diywall
REGI $HKCU\SOFTWARE\LovePE_Hub\efisize,efisize
REGI #HKCU\SOFTWARE\LovePE_Hub\diywall=
REGI $HKCU\SOFTWARE\LovePE_Hub\efisize=
//检查EFI大小
IFEX $%efisize%<2048,TEAM MESS-icon1  EFI启动分区大小必须不小于2048MB！ @错误 #OK|EXIT FILE


//清空警告
IFEX $%engine%=2,! 
{
	MESS-icon1  您选择清空全盘数据，请确认您已备份好所有启动盘数据！\n\n 如遇数据丢失，由用户自己承担全部责任！\n\n 选否退出。 @确认 #YN $N
	IFEX |%YESNO%=NO,TEAM MESS-icon3 您选择退出制作。 @退出 #OK*5000|EXIT FILE
	IFEX |%fs%=exFAT,
	{
		MESS-icon1  您选择启动盘数据分区文件系统为exFAT！\n\n exFAT格式启动盘还原时不支持保留数据！\n\n 选否退出。 @确认 #YN $N
		IFEX |%YESNO%=NO,TEAM MESS-icon3 您选择退出制作。 @退出 #OK*5000|EXIT FILE
	}
}


//模式1
IFEX $%engine%=1,
{
	ENVI @percent=5
	ENVI @character=正在清空启动盘数据
	//删除所有分区
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /del:all /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,删除所有分区
	ENVI @percent=20
	ENVI @character=正在创建EFI分区
	//建EFI区
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /cre /pri /size:%efisize% /end /fs:fat32 /act /align /label:LovePEEFI /letter:%let1% /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,建立EFI区
	ENVI @percent=35
	ENVI @character=正在创建数据分区
	//判断是否exfat
	CALC lognamed= %lognamed% + 1
	IFEX |%fs%=exFAT,
	{
		IFEX P:\*,! ENVI let2=P
		IFEX Q:\*,! ENVI let2=Q
		IFEX R:\*,! ENVI let2=R
		IFEX S:\*,! ENVI let2=S
		IFEX M:\*,! ENVI let2=M
		IFEX N:\*,! ENVI let2=N
		IFEX O:\*,! ENVI let2=O
		IFEX T:\*,! ENVI let2=T
		IFEX V:\*,! ENVI let2=V
		IFEX W:\*,! ENVI let2=W
		EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /cre /pri /size:auto /fs:fat16 /align /label:%label% /letter:%let2% /out:%mdirnamed%\%lognamed%.log
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,建立数据区exFAT
		DFMT %let2%:,exFAT
	}!
	{
		EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /cre /pri /size:auto /fs:%fs% /align /label:%label% /letter:auto /out:%mdirnamed%\%lognamed%.log
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,建立数据区
	}
}


//模式2
IFEX $%engine%=2,
{
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /list:%disknum% /out:%Temp%\ifexFAT.txt
	READ-ANSI %Temp%\ifexFAT.txt,5,ifexFATall
	FILE %Temp%\ifexFAT.txt
	MSTR ifexFAT=41,5,%ifexFATall%
	IFEX |%ifexFAT%=exFAT,TEAM MESS-icon1  您的U盘目前为exFAT文件系统，不支持保留数据！\n\n 请确认您已备份好所有数据后，选择清空全盘数据选项！ @确认 #OK|EXIT FILE
	MESS-icon1  您选择不清空全盘数据，请确认启动盘有 %efisize% MB的空间！\n\n 尽管制作会保留启动盘内所有数据，仍建议您备份好所有启动盘数据！\n\n 如遇数据丢失，由用户自己承担全部责任！\n\n 选否退出。 @确认 #YN $N
	IFEX |%YESNO%=NO,TEAM MESS-icon3 您选择退出制作。 @退出 #OK*5000|EXIT FILE
	ENVI @percent=5
	ENVI @character=正在压缩数据区
	//建EFI区
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /resize:0 /reduce-right:%efisize% /align /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,压缩数据区
	ENVI @percent=30
	ENVI @character=正在创建EFI分区
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /cre /pri /size:auto /fs:fat32 /act /align /label:LovePEEFI /letter:%let1% /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,建立EFI区
}


//模式3
IFEX $%engine%=3,
{
	ENVI @percent=5
	ENVI @character=正在清空启动盘数据
	WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT DISK=%disknum%
	WRIT-ANSI %Temp%\diskpart.txt,+0,CLEAN
	WRIT-ANSI %Temp%\diskpart.txt,$+0,CREATE PARTITION PRIMARY SIZE=%efisize%
	WRIT-ANSI %Temp%\diskpart.txt,+0,SELECT PARTITION=1
	WRIT-ANSI %Temp%\diskpart.txt,+0,ACTIVE
	WRIT-ANSI %Temp%\diskpart.txt,+0,FORMAT FS=FAT32 LABEL="LovePEEFI" QUICK NOERR
	WRIT-ANSI %Temp%\diskpart.txt,$+0,ASSIGN LETTER=%let1%
	WRIT-ANSI %Temp%\diskpart.txt,+0,CREATE PARTITION PRIMARY
	ENVI @percent=20
	ENVI @character=正在创建EFI分区
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
	//判断是否exfat
	IFEX |%fs%=exFAT,
	{
		IFEX P:\*,! ENVI let2=P
		IFEX Q:\*,! ENVI let2=Q
		IFEX R:\*,! ENVI let2=R
		IFEX S:\*,! ENVI let2=S
		IFEX M:\*,! ENVI let2=M
		IFEX N:\*,! ENVI let2=N
		IFEX O:\*,! ENVI let2=O
		IFEX T:\*,! ENVI let2=T
		IFEX V:\*,! ENVI let2=V
		IFEX W:\*,! ENVI let2=W
		WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT DISK=%disknum%
		WRIT-ANSI %Temp%\diskpart.txt,+0,SELECT PARTITION=2
		WRIT-ANSI %Temp%\diskpart.txt,$+0,ASSIGN LETTER=%let2%
	}!
	{
		WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT DISK=%disknum%
		WRIT-ANSI %Temp%\diskpart.txt,+0,SELECT PARTITION=2
		WRIT-ANSI %Temp%\diskpart.txt,$+0,FORMAT FS=%fs% LABEL="%label%" QUICK
		WRIT-ANSI %Temp%\diskpart.txt,+0,ASSIGN
	}
	ENVI @percent=35
	ENVI @character=正在创建数据分区
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
	IFEX |%fs%=exFAT,DFMT %let2%:,exFAT
}
ENVI @percent=50
ENVI @character=正在释放PE文件
//写入镜像
EXEC =!%CurDir%\UltraISO\ULTRAISO.EXE -silent -in %HubDir%Data\EFI.ISO -extract %let1%:
IFEX $%diywall%=6,
{
	REGI $HKCU\SOFTWARE\LovePE_Hub\diywalldirection,diywalldirection
	IFEX %HubDir%Data\LovePE\WALL\LovePEWALLpaper.jpg,FILE %HubDir%Data\LovePE\WALL\LovePEWALLpaper.jpg
	FILE %diywalldirection%=>%HubDir%Data\LovePE\WALL\LovePEWALLpaper.jpg
	REGI $HKCU\SOFTWARE\LovePE_Hub\diywalldirection=
}
FILE %HubDir%Data\BOOT\11PEX64.wim=>%let1%:\BOOT
FILE %HubDir%Data\LovePE=>%let1%:\
//加MBR
EXEC =!%CurDir%\bootsect.exe /nt60 %let1%: /mbr
ENVI @character=正在隐藏EFI分区
ENVI @percent=90
IFEX $%engine%=3,
{
	WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT DISK=%disknum%
	WRIT-ANSI %Temp%\diskpart.txt,+0,SELECT PARTITION=1
	WRIT-ANSI %Temp%\diskpart.txt,+0,REMOVE NOERR
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
}!
{
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hide:%let1% /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,隐藏EFI区
}
ENVI @character=完成
ENVI @percent=100
MESS-icon3 启动盘制作成功！按 是 打开QEMU进行测试。 @成功 #YN*5000
IFEX |%YESNO%=YES,EXEC %HubDir%qemu\Qsib.exe
EXIT FILE
_END


//删除
_SUB writeusb2
ENVI @if=-del
ENVI @writeusbui=LovePE启动盘清除中...
//清空警告
IFEX $%engine%=2,! 
{
	MESS-icon1  您选择同时清空启动盘数据区，请确认您已备份好所有数据！\n\n 如遇数据丢失，由用户自己承担全部责任！\n\n 选否退出。 @确认 #YN $N
	IFEX |%YESNO%=NO,TEAM MESS-icon3 您选择退出制作。 @退出 #OK*5000|EXIT FILE
}

//模式1
IFEX $%engine%=1,
{
	ENVI @percent=10
	ENVI @character=正在清空启动盘数据
	//删除所有分区
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /del:all /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,清空启动盘数据
	ENVI @percent=50
	ENVI @character=正在创建数据分区
	//判断是否exfat
	CALC lognamed= %lognamed% + 1
	IFEX |%fs%=exFAT,
	{
		EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /cre /pri /size:auto /fs:fat16 /align /label:%label% /letter:%let1% /out:%mdirnamed%\%lognamed%.log
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,创建数据分区exFAT
		DFMT %let1%:,exFAT
	}!
	{
		EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /cre /pri /size:auto /fs:%fs% /align /label:%label% /letter:auto /out:%mdirnamed%\%lognamed%.log
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,创建数据分区
	}
}


//模式2
IFEX $%engine%=2,
{
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /list:%disknum% /out:%Temp%\ifexFAT.txt
	READ-ANSI %Temp%\ifexFAT.txt,5,ifexFATall
	FILE %Temp%\ifexFAT.txt
	MSTR ifexFAT=41,5,%ifexFATall%
	IFEX |%ifexFAT%=exFAT,TEAM MESS-icon1  您的U盘目前为exFAT文件系统，不支持保留数据！\n\n 请确认您已备份好所有数据后，选择清空全盘数据模式！ @确认 #OK|EXIT FILE
	MESS-icon1  您将要将LovePE从您的启动盘中清除！\n\n 过程中会清除启动分区，\n\n 一般您的数据区不会受到影响！\n\n 但安全起见，仍建议您备份好数据！\n\n 如遇数据丢失，由用户自己承担全部责任！\n\n 选否退出。 @确认 #YN $N
	IFEX |%YESNO%=NO,TEAM MESS-icon3 您选择退出制作。 @退出 #OK*5000|EXIT FILE
	ENVI @character=正在查找启动分区
	ENVI @percent=10
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /unhide:1 /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,取消隐藏EFI区
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /setletter:1 /letter:%let1% /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,加EFI区卷标
	ENVI @character=正在判断启动分区
	ENVI @percent=30
	ENVI findsign=0
	IFEX %let1%:\BOOT\11PEX64.WIM,CALC findsign= %findsign% + 1
	IFEX %let1%:\BOOT\7PEX86.WIM,CALC findsign= %findsign% + 1
	IFEX %let1%:\BOOT\GRUB\MAXDOS.IMG,CALC findsign= %findsign% + 1
	IFEX %let1%:\LovePE\DIYtool\DIYtool.lpini,CALC findsign= %findsign% + 1
	IFEX $%findsign%=4,! 
	{
		MESS-icon1 程序自动检查未通过，出于安全考虑，请手动检查 %let1% 盘是否为启动分区！ @手动检查 #YN
		IFEX |%YESNO%=NO,TEAM MESS-icon3 未找到启动分区，请确认启动盘未被病毒等破坏。 @退出 #OK*5000|EXIT FILE
	}
	ENVI @character=正在删除启动分区
	ENVI @percent=50
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /del:%let1% /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,删除启动分区
	ENVI @character=正在扩展数据分区
	ENVI @percent=80
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /resize:0 /extend:right /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,扩展数据分区
}


//模式3
IFEX $%engine%=3,
{
	ENVI @percent=10
	ENVI @character=正在清空启动盘数据
	WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT DISK=%disknum%
	WRIT-ANSI %Temp%\diskpart.txt,+0,CLEAN
	WRIT-ANSI %Temp%\diskpart.txt,$+0,CREATE PARTITION PRIMARY
	ENVI @percent=40
	ENVI @character=正在创建数据分区
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
	//判断是否exfat
	IFEX |%fs%=exFAT,
	{
		WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT DISK=%disknum%
		WRIT-ANSI %Temp%\diskpart.txt,+0,SELECT PARTITION=1
		WRIT-ANSI %Temp%\diskpart.txt,$+0,ASSIGN LETTER=%let1%
	}!
	{
		WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT DISK=%disknum%
		WRIT-ANSI %Temp%\diskpart.txt,+0,SELECT PARTITION=1
		WRIT-ANSI %Temp%\diskpart.txt,$+0,FORMAT FS=%fs% LABEL="%label%" QUICK
		WRIT-ANSI %Temp%\diskpart.txt,+0,ASSIGN
	}
	ENVI @percent=65
	ENVI @character=正在格式化数据分区
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
	IFEX |%fs%=exFAT,DFMT %let1%:,exFAT
}
ENVI @character=完成
ENVI @percent=100
MESS-icon3 启动盘清除成功！ @成功 #OK*5000
EXIT FILE
_END


//免格升级
_SUB writeusb3
ENVI @if=-del
ENVI @writeusbui=LovePE正在免格升级启动盘...
MESS-icon1  您将要免格升级LovePE启动盘！\n\n 您启动盘的EFI启动分区会被格式化！\n\n 存放数据的分区不会受到影响。\n\n 选否退出。 @确认 #YN $N
IFEX |%YESNO%=NO,TEAM MESS-icon3 您选择退出升级工作。 @退出 #OK*5000|EXIT FILE
ENVI @character=正在查找启动分区
ENVI @percent=5
IFEX $%engine%=3,
{
	WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT DISK=%disknum%
	WRIT-ANSI %Temp%\diskpart.txt,+0,SELECT PARTITION=1
	WRIT-ANSI %Temp%\diskpart.txt,$+0,ASSIGN LETTER=%let1%
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
}! 
{
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /unhide:1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /setletter:1 /letter:%let1%
}
ENVI @character=正在判断启动分区
ENVI @percent=20
ENVI findsign=0
IFEX %let1%:\BOOT\11PEX64.WIM,CALC findsign= %findsign% + 1
IFEX %let1%:\BOOT\7PEX86.WIM,CALC findsign= %findsign% + 1
IFEX %let1%:\BOOT\GRUB\MAXDOS.IMG,CALC findsign= %findsign% + 1
IFEX %let1%:\LovePE\DIYtool\DIYtool.lpini,CALC findsign= %findsign% + 1
IFEX $%findsign%=4,! 
{
	MESS-icon1 程序自动检查未通过，出于安全考虑，请手动检查 %let1% 盘是否为启动分区！ @手动检查 #YN
	IFEX |%YESNO%=NO,TEAM MESS-icon3 未找到启动分区，请确认启动盘未被病毒等破坏。 @退出 #OK*5000|EXIT FILE
}
ENVI @character=正在格式化启动分区
ENVI @percent=35
IFEX %let1%:\LovePE\LovePEWALLpaper.jpg,
{
	IFEX %HubDir%Data\LovePE\WALL\LovePEWALLpaper.jpg, ! FILE %let1%:\LovePE\LovePEWALLpaper.jpg=>%HubDir%Data\LovePE\WALL\LovePEWALLpaper.jpg
}
DFMT %let1%:,FAT32,LovePEEFI
ENVI @character=正在向启动分区写入数据
ENVI @percent=50
EXEC =!%CurDir%\UltraISO\ULTRAISO.EXE -silent -in %HubDir%Data\EFI.ISO -extract %let1%:
FILE %HubDir%Data\BOOT\11PEX64.wim=>%let1%:\BOOT
FILE %HubDir%Data\LovePE=>%let1%:\
//加MBR
EXEC =!%CurDir%\bootsect.exe /nt60 %let1%: /mbr
ENVI @character=正在隐藏EFI分区
ENVI @percent=90
IFEX $%engine%=3,
{
	WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT DISK=%disknum%
	WRIT-ANSI %Temp%\diskpart.txt,+0,SELECT PARTITION=1
	WRIT-ANSI %Temp%\diskpart.txt,$+0,REMOVE NOERR
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
}! 
{
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hide:%let1%
}
ENVI @character=完成
ENVI @percent=100
MESS-icon3 启动盘免格升级成功！ @成功 #OK*5000
EXIT FILE
_END