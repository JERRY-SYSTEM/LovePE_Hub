REGI #HKCU\SOFTWARE\LovePE_Hub\setting1,setting1
REGI #HKCU\SOFTWARE\LovePE_Hub\setting1=
REGI $HKCU\SOFTWARE\LovePE_Hub\HubDir,HubDir
TEAM DATE dated d|DATE datem min|DATE dates s
IFEX $%setting1%=1,
{
	ENVI ?ifadmin=ISADMIN
	IFEX $%ifadmin%=0,TEAM MESS-icon1  ���Թ���ԱȨ�����д˳���! \n\n ���򼴽��˳��� @���� #OK*5000|KILL LovePE_Hub.exe|EXIT FILE
	DATE hour h
	IFEX $%hour% < 9,REGI HKCU\SOFTWARE\LovePE_Hub\morning=����
	IFEX [ $%hour% >= 9 & $%hour% <12 ],REGI HKCU\SOFTWARE\LovePE_Hub\morning=����
	IFEX $%hour% = 12,REGI HKCU\SOFTWARE\LovePE_Hub\morning=����
	IFEX [ $%hour% > 12 & $%hour% <=18 ],REGI HKCU\SOFTWARE\LovePE_Hub\morning=����
	IFEX $%hour% > 18,REGI HKCU\SOFTWARE\LovePE_Hub\morning=����
	ENVI findsign=0
	IFEX %HubDir%Data\BOOT\11PEX64.WIM,CALC findsign= %findsign% + 1
	IFEX %HubDir%Data\EFI.ISO,CALC findsign= %findsign% + 1
	IFEX $%findsign%=2,! REGI #HKCU\SOFTWARE\LovePE_Hub\nonecessary=4
}
IFEX $%setting1%=2,
{
	REGI HKCU\SOFTWARE\LovePE_Hub\!
}
IFEX $%setting1%=3, 
{
	FILE %HubDir%lpexMall=>%CurDir%
	WRIT-ANSI %CurDir%\wxsUI\LovePE_extension_Mall\dl.lua,$+17,local HubDir = [[%HubDir%]]
	EXEC =%CurDir%\lpexMall.exe -code "QuitWindow(nil,'��չ�г�')"
	EXEC =%CurDir%\lpexMall.exe -ui -jcfg wxsUI\\LovePE_extension_Mall\\main.jcfg
	WRIT-ANSI %CurDir%\wxsUI\LovePE_extension_Mall\dl.lua,-17
}
IFEX $%setting1%=4,
{
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,###############################################
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,����lpexMall.7z
	EXEC* buglog==!%CurDir%\aria2c.exe -x 1 -s 1 -j 1 -d %CurDir% -o lpexMall.7z "https://pe-down.lovepcos.xyz/down/lpexMall.7z"
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,$+0,%buglog%
	IFEX %HubDir%version.lpini,! TEAM MESS-icon1  ���ӷ���������ʧ�ܣ����黻���߰汾ϵͳ���л���ǰ���ٷ���ҳ���ء�\n\n ���ص�ַ��pe-down.lovepcos.xyz/LovePE���ļ���/��չ�г�\n\n ���������ṩ��־��Logs\setting1%dated%%datem%%dates%.log @���� #OK*5000|EXIT FILE
	FILE %HubDir%lpexMall
	EXEC -wait -hide %CurDir%\7z.exe x -y %CurDir%\lpexMall.7z -o%HubDir% *
	REGI #HKCU\SOFTWARE\LovePE_Hub\setting1=3
	EXEC %CurDir%\commond.exe LOAD setting1.dll
}
IFEX $%setting1%=5,
{
	FILE %HubDir%version.lpini->%CurDir%
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,###############################################
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,����version.lpini
	EXEC* buglog==!%CurDir%\aria2c.exe -x 1 -s 1 -j 1 -d %HubDir% -o version.lpini "https://pe-down.lovepcos.xyz/down/version.lpini"
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,$+0,%buglog%
	IFEX %HubDir%version.lpini,! TEAM MESS-icon1  ���ӷ���������ʧ�ܣ����黻���߰汾ϵͳ���л���ǰ�������������߰档\n\n ���ص�ַ��pe.lovepcos.cn/file/down.html\n\n ���������ṩ��־��Logs\setting1%dated%%datem%%dates%.log @���� #OK*5000|FILE %CurDir%\version.lpini->%HubDir%|EXIT FILE
	WRIT-ANSI %CurDir%\version.lpini,1,��ǰ�汾��
	CALL @update
}
EXIT FILE


_SUB update,W405H290,LovePE_Hub���³���,,%CurDir%\pecmd.exe,,,-disaltmv
ITEM -font:15 hub,L250T10W140H50,����LovePE_Hub,CALL @beginhub
ITEM -font:15 11pe,L250T80W140H50,����11PE�ں�,CALL @begin11pe
ITEM -font:15 efi,L250T150W140H50,������������,CALL @beginefi
MEMO-+ -rich inhub,L10T10W110H190,,%CurDir%\version.lpini,3,0xF79729#0xFEF4E9,12
MEMO-+ -rich inurl,L130T10W110H190,,%HubDir%version.lpini,3,0xF79729#0xFEF4E9,12
PBAR percent,L10T210W380H20,0
LABE -center character,L10T235W380H20,��Ƚϵ�ǰ�汾�����°汾�󣬵����Ҫ���µ�����İ�ť
_END

_SUB beginhub
ENVI @percent=5
ENVI @character=���ڹر�LovePE_Hub
MESS-icon1 ���½��Զ��ر�Hub����ȷ���ر�Hub�� @�ر�Hub #YN $Y
IFEX |%YESNO%=NO,TEAM MESS-icon3 �û�ȡ������LovePE_Hub�� @ʧ�� #OK*3000|ENVI @percent=100|ENVI @character=����LovePE_Hubʧ��|EXIT _SUB
KILL %HubDir%LovePE_Hub.exe
FILE %HubDir%LovePE_Hub.exe
IFEX %HubDir%LovePE_Hub.exe,TEAM MESS-icon1 ����ʧ�ܣ��ļ����ڱ�ռ�á� @ʧ�� #OK *3000|ENVI @percent=100|ENVI @character=����LovePE_Hubʧ��|EXIT _SUB
ENVI @percent=20
ENVI @character=���������°�LovePE_Hub
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,###############################################
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,����LovePE_Hub.exe
EXEC* buglog==!%CurDir%\aria2c.exe -x 2 -s 2 -j 1 -d %CurDir% -o LovePE_Hub.exe "https://pe-down.lovepcos.xyz/down/LovePE_Hub.exe"
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,$+0,%buglog%
IFEX %CurDir%\LovePE_Hub.exe,! TEAM MESS-icon1  ����ʧ�ܣ��޷��ӷ�������ȡ�ļ���\n\n ���������ṩ��־��Logs\setting1%dated%%datem%%dates%.log @ʧ�� #OK *3000|ENVI @percent=100|ENVI @character=����LovePE_Hubʧ��|EXIT _SUB
ENVI @percent=70
ENVI @character=���ڸ���LovePE_Hub
FILE %CurDir%\LovePE_Hub.exe->%HubDir%
IFEX %HubDir%LovePE_Hub.exe,! TEAM MESS-icon1 ����ʧ�ܣ��޷�д���ļ��� @ʧ�� #OK *5000|ENVI @percent=100|ENVI @character=����LovePE_Hubʧ��|EXIT _SUB
ENVI @percent=100
ENVI @character=����LovePE_Hub���
MESS-icon3 ���³ɹ��� @�ɹ� #OK *3000
_END
_SUB begin11pe
ENVI @percent=10
ENVI @character=���������°�11PE
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,###############################################
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,����11PEX64.WIM
EXEC* buglog==!%CurDir%\aria2c.exe -x 16 -s 16 -j 1 -d %CurDir% -o 11PEX64.WIM "https://pe-down.lovepcos.xyz/down/11PEX64.WIM"
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,$+0,%buglog%
IFEX %CurDir%\11PEX64.WIM,! TEAM MESS-icon1 ����ʧ�ܣ��޷��ӷ�������ȡ�ļ��� @ʧ�� #OK *3000|ENVI @percent=100|ENVI @character=����11PEʧ��|EXIT _SUB
ENVI @percent=60
ENVI @character=���ڸ���11PE
FILE %HubDir%Data\BOOT\11PEX64.WIM
FILE %CurDir%\11PEX64.WIM->%HubDir%Data\BOOT
IFEX %HubDir%Data\BOOT\11PEX64.WIM,! TEAM MESS-icon1  ����ʧ�ܣ��޷��ӷ�������ȡ�ļ���\n\n ���������ṩ��־��Logs\setting1%dated%%datem%%dates%.log @ʧ�� #OK *5000|ENVI @percent=100|ENVI @character=����11PEʧ��|EXIT _SUB
ENVI @percent=100
ENVI @character=����11PE���
MESS-icon3 ���³ɹ��� @�ɹ� #OK *3000
_END
_SUB beginefi
ENVI @percent=10
ENVI @character=���������°���������
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,###############################################
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,����EFI.ISO
EXEC* buglog==!%CurDir%\aria2c.exe -x 8 -s 8 -j 1 -d %CurDir% -o EFI.ISO "https://pe-down.lovepcos.xyz/down/EFI.ISO"
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,$+0,%buglog%
IFEX %CurDir%\EFI.ISO,! TEAM MESS-icon1  ����ʧ�ܣ��޷��ӷ�������ȡ�ļ���\n\n ���������ṩ��־��Logs\setting1%dated%%datem%%dates%.log @ʧ�� #OK *3000|ENVI @percent=100|ENVI @character=������������ʧ��|EXIT _SUB
ENVI @percent=60
ENVI @character=���ڸ�����������
FILE %HubDir%Data\EFI.ISO
FILE %CurDir%\EFI.ISO->%HubDir%Data\
IFEX %HubDir%Data\EFI.ISO,! TEAM MESS-icon1 ����ʧ�ܣ��޷�д���ļ��� @ʧ�� #OK *5000|ENVI @percent=100|ENVI @character=������������ʧ��|EXIT _SUB
ENVI @percent=100
ENVI @character=���������������
MESS-icon3 ���³ɹ��� @�ɹ� #OK *3000
_END