_SUB vhdmaker,W300H100,VHDPE生成中...,,%CurDir%\pecmd.exe,,,-disaltmv
PBAR percent,L10T10W270H30,0
LABE character,L10T45W270H20
TIME if,100,CALL @begin
_END


_SUB begin
ENVI @if=-del
REGI $HKCU\SOFTWARE\LovePE_Hub\HubDir,HubDir
REGI $HKCU\SOFTWARE\LovePE_Hub\vhd_big,big
IFEX $%big%<2048,TEAM MESS-icon1 \n  VHD大小至少为2048M @VHD太小 #OK *5000|EXIT FILE
BROW savedirection,*%HubDir%,请选择保存目录,0x800
ENVI @percent=10
ENVI @character=准备工作
REGI #HKCU\SOFTWARE\LovePE_Hub\vhd_expandable,expandable
REGI #HKCU\SOFTWARE\LovePE_Hub\vhd_dad,dad
REGI $HKCU\SOFTWARE\LovePE_Hub\vhd_choicefile,choicefile
REGI $HKCU\SOFTWARE\LovePE_Hub\vhd_choicewim,choicewim
IFEX $%expandable%=6,ENVI expandableable=expandable
IFEX $%expandable%=4,ENVI expandableable=fixed
IFEX $%dad%=6,ENVI dadnamed=11PEX64Dad
IFEX $%dad%=4,ENVI dadnamed=11PEX64
WRIT-ANSI %Temp%\diskpart.txt,$+0,CREATE VDISK FILE="%savedirection%\%dadnamed%.VHD" maximum=%big% type=%expandableable%
WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT VDISK FILE="%savedirection%\%dadnamed%.VHD"
WRIT-ANSI %Temp%\diskpart.txt,+0,ATTACH VDISK
WRIT-ANSI %Temp%\diskpart.txt,+0,CREATE PARTITION PRIMARY
IFEX P:\*,! ENVI psy=P
IFEX Q:\*,! ENVI psy=Q
IFEX Y:\*,! ENVI psy=Y
IFEX S:\*,! ENVI psy=S
IFEX R:\*,! ENVI psy=R
WRIT-ANSI %Temp%\diskpart.txt,$+0,ASSIGN LETTER=%psy%
WRIT-ANSI %Temp%\diskpart.txt,+0,FORMAT FS=NTFS LABEL="LovePE" QUICK
ENVI @percent=20
ENVI @character=正在创建VHD
EXEC =!DISKPART /s "%Temp%\diskpart.txt"
FILE "%Temp%\diskpart.txt"
ENVI @percent=40
ENVI @character=正在写入镜像
EXEC =!%CurDir%\wimlib-imagex.exe apply "%choicefile%" %choicewim% %psy%:\
ENVI @percent=80
ENVI @character=正在配置VHDPE
FILE %psy%:\Windows\System32\Boot\winload.exe=>%psy%:\Windows\System32
FILE %psy%:\Windows\System32\Boot\winload.efi=>%psy%:\Windows\System32
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,WRIT-ANSI %WinDir%\batrunonce.txt,+0,sign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,WRIT-ANSI %WinDir%\regrunonce.txt,+0,sign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,WRIT-ANSI %WinDir%\wczrunonce.txt,+0,sign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,ENVI calcnum=1
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,CALL @batsign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,_SUB batsign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,READ-ANSI %WinDir%\batrunonce.txt,%calcnum%,readbat
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,IFEX |%readbat%=sign,
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,{
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	WRIT-ANSI %WinDir%\batrunonce.txt,-0
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	ENVI calcnum=1
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	CALL @regsign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,}!
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,{
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	EXEC =%CurDrv%%readbat%
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	CALC calcnum = %calcnum% + 1
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	CALL @batsign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,}
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,_END
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,_SUB regsign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,READ-ANSI %WinDir%\regrunonce.txt,%calcnum%,readreg
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,IFEX |%readreg%=sign,
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,{
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	WRIT-ANSI %WinDir%\regrunonce.txt,-0
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	ENVI calcnum=1
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	CALL @wczsign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,}!
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,{
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	EXEC =!EXEC Regedit.exe /s %CurDrv%%readreg%
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	CALC calcnum = %calcnum% + 1
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	CALL @regsign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,}
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,_END
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,_SUB wczsign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,READ-ANSI %WinDir%\wczrunonce.txt,%calcnum%,readwcz
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,IFEX |%readwcz%=sign,
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,{
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	WRIT-ANSI %WinDir%\wczrunonce.txt,-0
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	EXIT FILE
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,}!
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,{
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	EXEC =!PECMD.EXE LOAD %CurDrv%%readwcz%
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	CALC calcnum = %calcnum% + 1
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,	CALL @sign
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,}
WRIT-ANSI %CurDir%\LovePEvhd.txt,+0,_END
CMPS -bin %CurDir%\LovePEvhd.txt %psy%:\Windows\LovePEvhd.dll
FILE %CurDir%\LovePEvhd.txt
ENVI @percent=90
IFEX $%dad%=6,
{
	ENVI @character=正在拆分VHD
	WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT VDISK FILE="%savedirection%\%dadnamed%.VHD"
	WRIT-ANSI %Temp%\diskpart.txt,+0,DETACH VDISK
	WRIT-ANSI %Temp%\diskpart.txt,$+0,CREATE VDISK FILE="%savedirection%\11PEX64.VHD" PARENT="%savedirection%\%dadnamed%.VHD"
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
	FILE "%savedirection%\11PEX64.VHD"=>"%savedirection%\11PEX64Son.VHD"
	WRIT-ANSI "%savedirection%\VHDPE文件说明.txt",+0,11PEX64Dad.vhd 为内核所在VHD
	WRIT-ANSI "%savedirection%\VHDPE文件说明.txt",+0,11PEX64Son.vhd 为拆分后的VHD
	WRIT-ANSI "%savedirection%\VHDPE文件说明.txt",+0,11PEX64.vhd 为启动VHD
	WRIT-ANSI "%savedirection%\VHDPE文件说明.txt",+0,当VHDPE出现问题或垃圾过多时，可删除11PEX64.vhd，并把11PEX64Son.vhd复制一份改名为11PEX64.vhd即可还原初始状态(保存的文件会丢失)。
}
ENVI @percent=100
ENVI @character=完成
MESS-icon3 \n  VHDPE制作成功，保存在目录 %savedirection% 下。 @成功 #OK *3000
EXIT FILE
_END

CALL @vhdmaker