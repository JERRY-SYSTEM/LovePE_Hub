_SUB LovePEextensionmaking
ENVI @if=-del
IFEX |%writerif%=������,ENVI @LovePEextensionmakepbar=[�߼�ģʽ]LovePE��չ������...
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_introduction,introductionini
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_chiocefile,choicefile
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_sortini,sortini
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_sending,sending
ENVI @percent=10
ENVI @character=������������Ϣ
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<LovePE extension info>
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<name>
WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%namedini%
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<version>
WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%versionini%
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<introduction>
WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%introductionini%
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<writer>
WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%writerini%
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<sort>
WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%sortini%
WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenwczable,greenwczable
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_icoable,icoable
IFEX $%icoable%=6,
{
	REGI $HKCU\SOFTWARE\LovePE_Hub\extension_icoini,icoini
	FILE %icoini%=>%CurDir%\lpex\ico.ico
	WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<ico>
	WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,in
	WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
}!
{
	WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<ico>
	WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,null
	WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
}
//����ǹٷ�ֱ��
IFEX |%versionini%=down,
{
	REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenbatchoice,greenbat
	WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<savename>
	WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%greenbat%
	WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
	WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<downlink>
	WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%choicefile%
	WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
	IFEX $%greenwczable%=6,
	{
		REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenwczchoice,greenwcz
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<args>
		WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%greenwcz%
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
	}!
	{
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<args>
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,null
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
	}
}
//���������
IFEX |%versionini%=DriverStore,
{
	REGI $HKCU\SOFTWARE\LovePE_Hub\extension_lpexp,lpexp
	WRIT-ANSI %CurDir%\pw.ini,$+0,REGI $HKCU\SOFTWARE\LovePE\lpexp=%lpexp%
	CMPS -bin %CurDir%\pw.ini %CurDir%\pw.dll
	FILE %CurDir%\pw.ini
	ENVI @percent=30
	ENVI @character=���ڸ����ļ�������
	FILE %choicefile%\*=>%CurDir%\%namedini%
	ENVI @percent=50
	ENVI @character=������������
	FILE %CurDir%\extension.extension
	EXEC =!%CurDir%\7z.exe a -m0=LZMA2 -mx9 -p%lpexp% %CurDir%\extension.extension %CurDir%\%namedini%\*
	FILE %CurDir%\%namedini%
	FILE %CurDir%\pw.dll->%CurDir%\lpex\pw.dll
	FILE %CurDir%\extension.extension->%CurDir%\lpex\extension.extension
}
//�������ͨ���
IFEX [ |%versionini%=down | |%versionini%=DriverStore ],! 
{
	STRL folder=%choicefile%
	CALC folderlong=%folder% + 2
	REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenbatable,greenbatable
	IFEX $%greenbatable%=6,
	{
		REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenbatchoice,greenbatchoice
		MSTR greenbat=%folderlong%,0,%greenbatchoice%
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<execute>
		WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%greenbat%
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
	}!
	{
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<execute>
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,null
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
	}
	IFEX $%greenwczable%=6,
	{
		REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenwczchoice,greenwczchoice
		MSTR greenwcz=%folderlong%,0,%greenwczchoice%
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<pecmdscript>
		WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%greenwcz%
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
	}!
	{
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<pecmdscript>
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,null
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
	}
	REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenregable,greenregable
	IFEX $%greenregable%=6,
	{
		REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenregchoice,greenregchoice
		MSTR greenreg=%folderlong%,0,%greenregchoice%
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<reg>
		WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%greenreg%
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
	}!
	{
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<reg>
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,null
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,
	}
	REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenlinkable,greenlinkable
	IFEX $%greenlinkable%=6,
	{
		REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenlinknamed,greenlinknamed
		REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenlinkexe,greenlinkexechioce
		MSTR greenlinkexe=%folderlong%,0,%greenlinkexechioce%
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<link>
		WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%greenlinknamed%
		WRIT-ANSI %CurDir%\extensioninfo.lpini,$+0,%greenlinkexe%
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,	
	}!
	{
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,<link>
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,null
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,null
		WRIT-ANSI %CurDir%\extensioninfo.lpini,+0,	
	}
	REGI $HKCU\SOFTWARE\LovePE_Hub\extension_lpexp,lpexp
	WRIT-ANSI %CurDir%\pw.ini,$+0,REGI $HKCU\SOFTWARE\LovePE\lpexp=%lpexp%
	CMPS -bin %CurDir%\pw.ini %CurDir%\pw.dll
	FILE %CurDir%\pw.ini
	ENVI @percent=30
	ENVI @character=���ڸ����ļ�������
	FILE %choicefile%\*=>%CurDir%\%namedini%
	ENVI @percent=50
	ENVI @character=����ѹ�������ļ�
	FILE %CurDir%\extension.extension
	EXEC =!%CurDir%\7z.exe a -mx9 -p%lpexp% %CurDir%\extension.extension %CurDir%\%namedini%
	FILE %CurDir%\%namedini%
	FILE %CurDir%\pw.dll->%CurDir%\lpex\pw.dll
	FILE %CurDir%\extension.extension->%CurDir%\lpex\extension.extension
}
ENVI @percent=70
ENVI @character=������������Ϣ
FILE %CurDir%\extensioninfo.lpini->%CurDir%\lpex\extensioninfo.lpini
EXEC =!%CurDir%\7z.exe a -mx9 %CurDir%\extension.lpex %CurDir%\lpex\*
FILE %CurDir%\lpex
ENVI @percent=95
ENVI @character=���ڵ�����չ���
FILE %CurDir%\extension.lpex->%sending%
ENVI @percent=100
ENVI @character=��չ����������
MESS-icon3 ��չ��� %namedini% ������ɣ� @������� #OK
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_named=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_version=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_introduction=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_writer=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_chiocefile=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_lpexp=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_sortini=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_sending=
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_icoable=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_icoini=
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_icoable=
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenbatable=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenbatchoice=
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenbatable=
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenregable=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenregchoice=
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenregable=
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenwczable=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenwczchoice=
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenwczable=
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenlinkable=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenlinknamed=
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_greenlinkexe=
REGI #HKCU\SOFTWARE\LovePE_Hub\extension_greenlinkable=
EXIT FILE
_END

REGI $HKCU\SOFTWARE\LovePE_Hub\extension_named,namedini
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_version,versionini
REGI $HKCU\SOFTWARE\LovePE_Hub\extension_writer,writerini
LSTR writerif=3,%writerini%
IFEX |%writerif%=������,
{
	MSTR writerini=4,0,%writerini%
}!
{
	WRIT-ANSI %CurDir%\namedstrl.txt,$+0,%namedini%
	SIZE namedstrl=%CurDir%\namedstrl.txt
	FILE %CurDir%\namedstrl.txt
	IFEX $%namedstrl%>16,TEAM MESS-icon1 ��չ������Ʊ��벻����7���ֻ�14��Ӣ��(2��Ӣ���൱��һ������)�� @���� #OK|EXIT FILE
	WRIT-ANSI %CurDir%\versionstrl.txt,$+0,%versionini%
	SIZE versionstrl=%CurDir%\versionstrl.txt
	FILE %CurDir%\versionstrl.txt
	IFEX $%versionstrl%>14,TEAM MESS-icon1 ��չ����汾�ű��벻����12��Ӣ�Ļ������ַ��� @���� #OK|EXIT FILE
	WRIT-ANSI %CurDir%\writerstrl.txt,$+0,%writerini%
	SIZE writerstrl=%CurDir%\writerstrl.txt
	FILE %CurDir%\writerstrl.txt
	IFEX $%writerstrl%>16,TEAM MESS-icon1 ��չ����������Ʊ��벻����7���ֻ�14��Ӣ��(2��Ӣ���൱��һ������)�� @���� #OK|EXIT FILE
}
CALL @LovePEextensionmakepbar

_SUB LovePEextensionmakepbar,W300H100,LovePE��չ������...,,%CurDir%\pecmd.exe,,,-disaltmv
PBAR percent,L10T10W270H30,0
LABE character,L10T45W270H20
TIME if,100,CALL @LovePEextensionmaking
_END
