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


//����
_SUB writeusbui,W300H100,���Ե�...,,%CurDir%\pecmd.exe,,,-disaltmv
PBAR percent,L10T10W270H30,0
LABE character,L10T45W270H20
TIME if,100,CALL @writeusb%writeusb%
_END

//д��
_SUB writeusb1
ENVI @if=-del
ENVI @writeusbui=LovePE������д����...
IFEX %HubDir%Data\EFI.ISO,! TEAM MESS-icon1 δ�ҵ�ISO�����ļ�����ǰ�����ý������أ� @��Ҫ�ļ�ȱʧ #OK|EXIT FILE
IFEX %HubDir%Data\BOOT\11PEX64.wim,! TEAM MESS-icon1 δ�ҵ�11PE������ǰ�����ý������أ� @��Ҫ�ļ�ȱʧ #OK|EXIT FILE
IFEX %HubDir%Data\LovePE\DIYtool\DIYtool.lpini,! MESS-icon1 δ�ҵ�LovePEĿ¼�����޷�ʹ���Զ��幦�ܣ� @�ļ�ȱʧ #OK
REGI #HKCU\SOFTWARE\LovePE_Hub\diywall,diywall
REGI $HKCU\SOFTWARE\LovePE_Hub\efisize,efisize
REGI #HKCU\SOFTWARE\LovePE_Hub\diywall=
REGI $HKCU\SOFTWARE\LovePE_Hub\efisize=
//���EFI��С
IFEX $%efisize%<2048,TEAM MESS-icon1  EFI����������С���벻С��2048MB�� @���� #OK|EXIT FILE


//��վ���
IFEX $%engine%=2,! 
{
	MESS-icon1  ��ѡ�����ȫ�����ݣ���ȷ�����ѱ��ݺ��������������ݣ�\n\n �������ݶ�ʧ�����û��Լ��е�ȫ�����Σ�\n\n ѡ���˳��� @ȷ�� #YN $N
	IFEX |%YESNO%=NO,TEAM MESS-icon3 ��ѡ���˳������� @�˳� #OK*5000|EXIT FILE
	IFEX |%fs%=exFAT,
	{
		MESS-icon1  ��ѡ�����������ݷ����ļ�ϵͳΪexFAT��\n\n exFAT��ʽ�����̻�ԭʱ��֧�ֱ������ݣ�\n\n ѡ���˳��� @ȷ�� #YN $N
		IFEX |%YESNO%=NO,TEAM MESS-icon3 ��ѡ���˳������� @�˳� #OK*5000|EXIT FILE
	}
}


//ģʽ1
IFEX $%engine%=1,
{
	ENVI @percent=5
	ENVI @character=�����������������
	//ɾ�����з���
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /del:all /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,ɾ�����з���
	ENVI @percent=20
	ENVI @character=���ڴ���EFI����
	//��EFI��
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /cre /pri /size:%efisize% /end /fs:fat32 /act /align /label:LovePEEFI /letter:%let1% /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,����EFI��
	ENVI @percent=35
	ENVI @character=���ڴ������ݷ���
	//�ж��Ƿ�exfat
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
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,����������exFAT
		DFMT %let2%:,exFAT
	}!
	{
		EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /cre /pri /size:auto /fs:%fs% /align /label:%label% /letter:auto /out:%mdirnamed%\%lognamed%.log
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,����������
	}
}


//ģʽ2
IFEX $%engine%=2,
{
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /list:%disknum% /out:%Temp%\ifexFAT.txt
	READ-ANSI %Temp%\ifexFAT.txt,5,ifexFATall
	FILE %Temp%\ifexFAT.txt
	MSTR ifexFAT=41,5,%ifexFATall%
	IFEX |%ifexFAT%=exFAT,TEAM MESS-icon1  ����U��ĿǰΪexFAT�ļ�ϵͳ����֧�ֱ������ݣ�\n\n ��ȷ�����ѱ��ݺ��������ݺ�ѡ�����ȫ������ѡ� @ȷ�� #OK|EXIT FILE
	MESS-icon1  ��ѡ�����ȫ�����ݣ���ȷ���������� %efisize% MB�Ŀռ䣡\n\n ���������ᱣ�����������������ݣ��Խ��������ݺ��������������ݣ�\n\n �������ݶ�ʧ�����û��Լ��е�ȫ�����Σ�\n\n ѡ���˳��� @ȷ�� #YN $N
	IFEX |%YESNO%=NO,TEAM MESS-icon3 ��ѡ���˳������� @�˳� #OK*5000|EXIT FILE
	ENVI @percent=5
	ENVI @character=����ѹ��������
	//��EFI��
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /resize:0 /reduce-right:%efisize% /align /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,ѹ��������
	ENVI @percent=30
	ENVI @character=���ڴ���EFI����
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /cre /pri /size:auto /fs:fat32 /act /align /label:LovePEEFI /letter:%let1% /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,����EFI��
}


//ģʽ3
IFEX $%engine%=3,
{
	ENVI @percent=5
	ENVI @character=�����������������
	WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT DISK=%disknum%
	WRIT-ANSI %Temp%\diskpart.txt,+0,CLEAN
	WRIT-ANSI %Temp%\diskpart.txt,$+0,CREATE PARTITION PRIMARY SIZE=%efisize%
	WRIT-ANSI %Temp%\diskpart.txt,+0,SELECT PARTITION=1
	WRIT-ANSI %Temp%\diskpart.txt,+0,ACTIVE
	WRIT-ANSI %Temp%\diskpart.txt,+0,FORMAT FS=FAT32 LABEL="LovePEEFI" QUICK NOERR
	WRIT-ANSI %Temp%\diskpart.txt,$+0,ASSIGN LETTER=%let1%
	WRIT-ANSI %Temp%\diskpart.txt,+0,CREATE PARTITION PRIMARY
	ENVI @percent=20
	ENVI @character=���ڴ���EFI����
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
	//�ж��Ƿ�exfat
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
	ENVI @character=���ڴ������ݷ���
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
	IFEX |%fs%=exFAT,DFMT %let2%:,exFAT
}
ENVI @percent=50
ENVI @character=�����ͷ�PE�ļ�
//д�뾵��
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
//��MBR
EXEC =!%CurDir%\bootsect.exe /nt60 %let1%: /mbr
ENVI @character=��������EFI����
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
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,����EFI��
}
ENVI @character=���
ENVI @percent=100
MESS-icon3 �����������ɹ����� �� ��QEMU���в��ԡ� @�ɹ� #YN*5000
IFEX |%YESNO%=YES,EXEC %HubDir%qemu\Qsib.exe
EXIT FILE
_END


//ɾ��
_SUB writeusb2
ENVI @if=-del
ENVI @writeusbui=LovePE�����������...
//��վ���
IFEX $%engine%=2,! 
{
	MESS-icon1  ��ѡ��ͬʱ�������������������ȷ�����ѱ��ݺ��������ݣ�\n\n �������ݶ�ʧ�����û��Լ��е�ȫ�����Σ�\n\n ѡ���˳��� @ȷ�� #YN $N
	IFEX |%YESNO%=NO,TEAM MESS-icon3 ��ѡ���˳������� @�˳� #OK*5000|EXIT FILE
}

//ģʽ1
IFEX $%engine%=1,
{
	ENVI @percent=10
	ENVI @character=�����������������
	//ɾ�����з���
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /del:all /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,�������������
	ENVI @percent=50
	ENVI @character=���ڴ������ݷ���
	//�ж��Ƿ�exfat
	CALC lognamed= %lognamed% + 1
	IFEX |%fs%=exFAT,
	{
		EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /cre /pri /size:auto /fs:fat16 /align /label:%label% /letter:%let1% /out:%mdirnamed%\%lognamed%.log
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,�������ݷ���exFAT
		DFMT %let1%:,exFAT
	}!
	{
		EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /cre /pri /size:auto /fs:%fs% /align /label:%label% /letter:auto /out:%mdirnamed%\%lognamed%.log
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
		WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,�������ݷ���
	}
}


//ģʽ2
IFEX $%engine%=2,
{
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /list:%disknum% /out:%Temp%\ifexFAT.txt
	READ-ANSI %Temp%\ifexFAT.txt,5,ifexFATall
	FILE %Temp%\ifexFAT.txt
	MSTR ifexFAT=41,5,%ifexFATall%
	IFEX |%ifexFAT%=exFAT,TEAM MESS-icon1  ����U��ĿǰΪexFAT�ļ�ϵͳ����֧�ֱ������ݣ�\n\n ��ȷ�����ѱ��ݺ��������ݺ�ѡ�����ȫ������ģʽ�� @ȷ�� #OK|EXIT FILE
	MESS-icon1  ����Ҫ��LovePE�������������������\n\n �����л��������������\n\n һ�����������������ܵ�Ӱ�죡\n\n ����ȫ������Խ��������ݺ����ݣ�\n\n �������ݶ�ʧ�����û��Լ��е�ȫ�����Σ�\n\n ѡ���˳��� @ȷ�� #YN $N
	IFEX |%YESNO%=NO,TEAM MESS-icon3 ��ѡ���˳������� @�˳� #OK*5000|EXIT FILE
	ENVI @character=���ڲ�����������
	ENVI @percent=10
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /unhide:1 /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,ȡ������EFI��
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /setletter:1 /letter:%let1% /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,��EFI�����
	ENVI @character=�����ж���������
	ENVI @percent=30
	ENVI findsign=0
	IFEX %let1%:\BOOT\11PEX64.WIM,CALC findsign= %findsign% + 1
	IFEX %let1%:\BOOT\7PEX86.WIM,CALC findsign= %findsign% + 1
	IFEX %let1%:\BOOT\GRUB\MAXDOS.IMG,CALC findsign= %findsign% + 1
	IFEX %let1%:\LovePE\DIYtool\DIYtool.lpini,CALC findsign= %findsign% + 1
	IFEX $%findsign%=4,! 
	{
		MESS-icon1 �����Զ����δͨ�������ڰ�ȫ���ǣ����ֶ���� %let1% ���Ƿ�Ϊ���������� @�ֶ���� #YN
		IFEX |%YESNO%=NO,TEAM MESS-icon3 δ�ҵ�������������ȷ��������δ���������ƻ��� @�˳� #OK*5000|EXIT FILE
	}
	ENVI @character=����ɾ����������
	ENVI @percent=50
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /del:%let1% /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,ɾ����������
	ENVI @character=������չ���ݷ���
	ENVI @percent=80
	CALC lognamed= %lognamed% + 1
	EXEC =!cmd.exe /c "%CurDir%\PartAssist\PartAssist.exe" /hd:%disknum% /resize:0 /extend:right /out:%mdirnamed%\%lognamed%.log
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,###############################################
	WRIT-ANSI %mdirnamed%\%lognamed%.log,+0,��չ���ݷ���
}


//ģʽ3
IFEX $%engine%=3,
{
	ENVI @percent=10
	ENVI @character=�����������������
	WRIT-ANSI %Temp%\diskpart.txt,$+0,SELECT DISK=%disknum%
	WRIT-ANSI %Temp%\diskpart.txt,+0,CLEAN
	WRIT-ANSI %Temp%\diskpart.txt,$+0,CREATE PARTITION PRIMARY
	ENVI @percent=40
	ENVI @character=���ڴ������ݷ���
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
	//�ж��Ƿ�exfat
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
	ENVI @character=���ڸ�ʽ�����ݷ���
	EXEC =!DISKPART /s "%Temp%\diskpart.txt"
	FILE "%Temp%\diskpart.txt"
	IFEX |%fs%=exFAT,DFMT %let1%:,exFAT
}
ENVI @character=���
ENVI @percent=100
MESS-icon3 ����������ɹ��� @�ɹ� #OK*5000
EXIT FILE
_END


//�������
_SUB writeusb3
ENVI @if=-del
ENVI @writeusbui=LovePE�����������������...
MESS-icon1  ����Ҫ�������LovePE�����̣�\n\n �������̵�EFI���������ᱻ��ʽ����\n\n ������ݵķ��������ܵ�Ӱ�졣\n\n ѡ���˳��� @ȷ�� #YN $N
IFEX |%YESNO%=NO,TEAM MESS-icon3 ��ѡ���˳����������� @�˳� #OK*5000|EXIT FILE
ENVI @character=���ڲ�����������
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
ENVI @character=�����ж���������
ENVI @percent=20
ENVI findsign=0
IFEX %let1%:\BOOT\11PEX64.WIM,CALC findsign= %findsign% + 1
IFEX %let1%:\BOOT\7PEX86.WIM,CALC findsign= %findsign% + 1
IFEX %let1%:\BOOT\GRUB\MAXDOS.IMG,CALC findsign= %findsign% + 1
IFEX %let1%:\LovePE\DIYtool\DIYtool.lpini,CALC findsign= %findsign% + 1
IFEX $%findsign%=4,! 
{
	MESS-icon1 �����Զ����δͨ�������ڰ�ȫ���ǣ����ֶ���� %let1% ���Ƿ�Ϊ���������� @�ֶ���� #YN
	IFEX |%YESNO%=NO,TEAM MESS-icon3 δ�ҵ�������������ȷ��������δ���������ƻ��� @�˳� #OK*5000|EXIT FILE
}
ENVI @character=���ڸ�ʽ����������
ENVI @percent=35
IFEX %let1%:\LovePE\LovePEWALLpaper.jpg,
{
	IFEX %HubDir%Data\LovePE\WALL\LovePEWALLpaper.jpg, ! FILE %let1%:\LovePE\LovePEWALLpaper.jpg=>%HubDir%Data\LovePE\WALL\LovePEWALLpaper.jpg
}
DFMT %let1%:,FAT32,LovePEEFI
ENVI @character=��������������д������
ENVI @percent=50
EXEC =!%CurDir%\UltraISO\ULTRAISO.EXE -silent -in %HubDir%Data\EFI.ISO -extract %let1%:
FILE %HubDir%Data\BOOT\11PEX64.wim=>%let1%:\BOOT
FILE %HubDir%Data\LovePE=>%let1%:\
//��MBR
EXEC =!%CurDir%\bootsect.exe /nt60 %let1%: /mbr
ENVI @character=��������EFI����
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
ENVI @character=���
ENVI @percent=100
MESS-icon3 ��������������ɹ��� @�ɹ� #OK*5000
EXIT FILE
_END