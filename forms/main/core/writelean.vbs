REGI $HKCU\SOFTWARE\LovePE_Hub\HubDir,HubDir
REGI $HKCU\SOFTWARE\LovePE_Hub\writelean,writelean
IFEX $%writelean%=3,
{
	REGI $HKCU\SOFTWARE\LovePE_Hub\disknum,disknumall
	RSTR disknum=1,%disknumall%
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /unhide:1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /setletter:1 /letter:auto
	MESS-icon3 ��������ȡ�����سɹ��� @�ɹ� #OK*5000
	EXIT FILE
}
IFEX $%writelean%=4,
{
	REGI $HKCU\SOFTWARE\LovePE_Hub\disknum,disknumall
	RSTR disknum=1,%disknumall%
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /hide:1
	MESS-icon3 �����������سɹ��� @�ɹ� #OK*5000
	EXIT FILE
}
//Ѱ��USB
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
		WRIT-ANSI %temp%\finddisk.vbs,$+0,CreateObject("Wscript.Shell").Run("%CurDir%\commond.exe WRIT-UTF8 %CurDir%\listdisk.txt,+0," & modl & " �� " & id )
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

//����
_SUB writeui,W300H100,���Ե�...,,%CurDir%\pecmd.exe,,,-disaltmv
PBAR percent,L10T10W270H30,0
LABE character,L10T45W270H20
TIME if,100,CALL @lean%writelean%
_END

//ISO
_SUB lean2
ENVI @if=-del
ENVI @writeui=LovePE����ISO��...
IFEX %HubDir%Data\EFI.ISO,!TEAM MESS-icon3 δ���ֳ���Ŀ¼�µ�ISO�������ء� @��Ҫ�ļ�ȱʧ #OK *5000|EXIT FILE
IFEX %HubDir%Data\BOOT\11PEX64.wim,! TEAM MESS-icon1 δ�ҵ�11PE���������أ� @��Ҫ�ļ�ȱʧ #OK|EXIT FILE
IFEX %HubDir%Data\LovePE\DIYtool\DIYtool.lpini,! MESS-icon1 δ�ҵ�LovePEĿ¼�����޷�ʹ���Զ��幦�ܣ� @�ļ�ȱʧ #OK
BROW sending,&%Desktop%\LovePE.ISO,��ѡ��ISO����λ��,ISO�ļ�|*.ISO
ENVI @character=���ڵ���ISO��ָ��Ŀ¼
ENVI @percent=20
FILE %HubDir%Data\EFI.ISO=>%sending%
IFEX %sending%,!TEAM MESS-icon3 ����λ�ô��� @���� #OK *5000|EXIT FILE
ENVI @character=�������11PE����
ENVI @percent=50
EXEC =!%CurDir%\UltraISO\UltraISO.exe -silent -in "%sending%" -f %HubDir%Data\BOOT
EXEC =!%CurDir%\UltraISO\UltraISO.exe -silent -in "%sending%" -f %HubDir%Data\LovePE
ENVI @character=���
ENVI @percent=100
MESS-icon1 ISO�ļ�������ɣ� @�ɹ� #OK *3000
EXIT FILE
_END

//ventoy
_SUB lean1
ENVI @if=-del
ENVI @writeui=LovePE������д����...
IFEX %HubDir%Data\EFI.ISO,! TEAM MESS-icon1 δ�ҵ�ISO�����ļ�����ǰ�����ý������أ� @��Ҫ�ļ�ȱʧ #OK|EXIT FILE
IFEX %HubDir%Data\BOOT\11PEX64.wim,! TEAM MESS-icon1 δ�ҵ�11PE������ǰ�����ý������أ� @��Ҫ�ļ�ȱʧ #OK|EXIT FILE
IFEX %HubDir%Data\LovePE\DIYtool\DIYtool.lpini,! MESS-icon1 δ�ҵ�LovePEĿ¼�����޷�ʹ���Զ��幦�ܣ� @�ļ�ȱʧ #OK
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
	ENVI @character=�������ɾ���
	ENVI @percent=15
	FILE %HubDir%Data\EFI.ISO=>%Temp%
	EXEC =!%CurDir%\UltraISO\UltraISO.exe -silent -in "%temp%\EFI.ISO" -f %HubDir%Data\BOOT
	EXEC =!%CurDir%\UltraISO\UltraISO.exe -silent -in "%temp%\EFI.ISO" -f %HubDir%Data\LovePE
	ENVI @character=���ڵ���UltraISOд��
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
	MESS-icon1  Ventoyģʽ����ǰ����Ventoy�����̡�\n\n ������Ѿ�ʹ��Ventoy���������̣�����ִ��д����������'ȡ��'��\n\n �������Ҫ����Ventoy�����'��'��\n\n ���������ʱ�˳����������'��'�� @ȷ�� #YNC $C
	IFEX |%YESNO%=YES,TEAM EXEC explorer.exe "https://mirrors.nju.edu.cn/github-release/ventoy/Ventoy"|EXIT FILE
	IFEX |%YESNO%=NO,TEAM MESS-icon3 ��ѡ���˳������� @�˳� #OK*5000|EXIT FILE
	BROW venlet,*C:\,��ѡ��U�̷�����Ŀ¼,,0x200
	ENVI @character=����д��ISO�ļ�
	ENVI @percent=10
	FILE %HubDir%Data\EFI.ISO=>%venlet%LovePE.ISO
	ENVI @character=�������11PE
	ENVI @percent=45
	EXEC =!%CurDir%\UltraISO\UltraISO.exe -silent -in %venlet%LovePE.ISO -f %HubDir%Data\BOOT
	ENVI @character=���ڴ����Զ��幦���ļ���
	ENVI @percent=80
	FILE %HubDir%Data\LovePE=>%venlet%
	ENVI @character=���
	ENVI @percent=100
	MESS-icon3 Ventoyģʽд��ɹ��� @�ɹ� #OK*5000
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
	IFEX $%readnum%=5,WRIT-UTF8 %CurDir%\listdisk.txt,+0,�����U��
	FILE %Temp%\finddisk.txt
	EXIT FILE
}!
{
	WRIT-UTF8 %CurDir%\listdisk.txt,$+0,%named% �� %disknum%
	CALC calcnum = %calcnum% + 1
	CALL @sign
}
_END