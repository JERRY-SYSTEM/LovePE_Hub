REGI #HKCU\SOFTWARE\LovePE_Hub\setting1,setting1
REGI #HKCU\SOFTWARE\LovePE_Hub\setting1=
REGI $HKCU\SOFTWARE\LovePE_Hub\HubDir,HubDir
TEAM DATE dated d|DATE datem min|DATE dates s
IFEX $%setting1%=1,
{
	ENVI ?ifadmin=ISADMIN
	IFEX $%ifadmin%=0,TEAM MESS-icon1  请以管理员权限运行此程序! \n\n 程序即将退出。 @错误 #OK*5000|KILL LovePE_Hub.exe|EXIT FILE
	DATE hour h
	IFEX $%hour% < 9,REGI HKCU\SOFTWARE\LovePE_Hub\morning=早上
	IFEX [ $%hour% >= 9 & $%hour% <12 ],REGI HKCU\SOFTWARE\LovePE_Hub\morning=上午
	IFEX $%hour% = 12,REGI HKCU\SOFTWARE\LovePE_Hub\morning=中午
	IFEX [ $%hour% > 12 & $%hour% <=18 ],REGI HKCU\SOFTWARE\LovePE_Hub\morning=下午
	IFEX $%hour% > 18,REGI HKCU\SOFTWARE\LovePE_Hub\morning=晚上
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
	EXEC =%CurDir%\lpexMall.exe -code "QuitWindow(nil,'扩展市场')"
	EXEC =%CurDir%\lpexMall.exe -ui -jcfg wxsUI\\LovePE_extension_Mall\\main.jcfg
	WRIT-ANSI %CurDir%\wxsUI\LovePE_extension_Mall\dl.lua,-17
}
IFEX $%setting1%=4,
{
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,###############################################
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,下载lpexMall.7z
	EXEC* buglog==!%CurDir%\aria2c.exe -x 1 -s 1 -j 1 -d %CurDir% -o lpexMall.7z "https://pe-down.lovepcos.xyz/down/lpexMall.7z"
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,$+0,%buglog%
	IFEX %HubDir%version.lpini,! TEAM MESS-icon1  连接服务器数据失败！建议换更高版本系统运行或者前往官方网页下载。\n\n 下载地址：pe-down.lovepcos.xyz/LovePEの文件库/扩展市场\n\n 并向我们提供日志：Logs\setting1%dated%%datem%%dates%.log @错误 #OK*5000|EXIT FILE
	FILE %HubDir%lpexMall
	EXEC -wait -hide %CurDir%\7z.exe x -y %CurDir%\lpexMall.7z -o%HubDir% *
	REGI #HKCU\SOFTWARE\LovePE_Hub\setting1=3
	EXEC %CurDir%\commond.exe LOAD setting1.dll
}
IFEX $%setting1%=5,
{
	FILE %HubDir%version.lpini->%CurDir%
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,###############################################
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,下载version.lpini
	EXEC* buglog==!%CurDir%\aria2c.exe -x 1 -s 1 -j 1 -d %HubDir% -o version.lpini "https://pe-down.lovepcos.xyz/down/version.lpini"
	WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,$+0,%buglog%
	IFEX %HubDir%version.lpini,! TEAM MESS-icon1  连接服务器数据失败！建议换更高版本系统运行或者前往官网下载离线版。\n\n 下载地址：pe.lovepcos.cn/file/down.html\n\n 并向我们提供日志：Logs\setting1%dated%%datem%%dates%.log @错误 #OK*5000|FILE %CurDir%\version.lpini->%HubDir%|EXIT FILE
	WRIT-ANSI %CurDir%\version.lpini,1,当前版本：
	CALL @update
}
EXIT FILE


_SUB update,W405H290,LovePE_Hub更新程序,,%CurDir%\pecmd.exe,,,-disaltmv
ITEM -font:15 hub,L250T10W140H50,更新LovePE_Hub,CALL @beginhub
ITEM -font:15 11pe,L250T80W140H50,更新11PE内核,CALL @begin11pe
ITEM -font:15 efi,L250T150W140H50,更新引导镜像,CALL @beginefi
MEMO-+ -rich inhub,L10T10W110H190,,%CurDir%\version.lpini,3,0xF79729#0xFEF4E9,12
MEMO-+ -rich inurl,L130T10W110H190,,%HubDir%version.lpini,3,0xF79729#0xFEF4E9,12
PBAR percent,L10T210W380H20,0
LABE -center character,L10T235W380H20,请比较当前版本和最新版本后，点击需要更新的组件的按钮
_END

_SUB beginhub
ENVI @percent=5
ENVI @character=正在关闭LovePE_Hub
MESS-icon1 更新将自动关闭Hub，按确定关闭Hub。 @关闭Hub #YN $Y
IFEX |%YESNO%=NO,TEAM MESS-icon3 用户取消更新LovePE_Hub。 @失败 #OK*3000|ENVI @percent=100|ENVI @character=更新LovePE_Hub失败|EXIT _SUB
KILL %HubDir%LovePE_Hub.exe
FILE %HubDir%LovePE_Hub.exe
IFEX %HubDir%LovePE_Hub.exe,TEAM MESS-icon1 更新失败，文件正在被占用。 @失败 #OK *3000|ENVI @percent=100|ENVI @character=更新LovePE_Hub失败|EXIT _SUB
ENVI @percent=20
ENVI @character=正在下载新版LovePE_Hub
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,###############################################
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,下载LovePE_Hub.exe
EXEC* buglog==!%CurDir%\aria2c.exe -x 2 -s 2 -j 1 -d %CurDir% -o LovePE_Hub.exe "https://pe-down.lovepcos.xyz/down/LovePE_Hub.exe"
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,$+0,%buglog%
IFEX %CurDir%\LovePE_Hub.exe,! TEAM MESS-icon1  更新失败，无法从服务器获取文件。\n\n 请向我们提供日志：Logs\setting1%dated%%datem%%dates%.log @失败 #OK *3000|ENVI @percent=100|ENVI @character=更新LovePE_Hub失败|EXIT _SUB
ENVI @percent=70
ENVI @character=正在更新LovePE_Hub
FILE %CurDir%\LovePE_Hub.exe->%HubDir%
IFEX %HubDir%LovePE_Hub.exe,! TEAM MESS-icon1 更新失败，无法写入文件。 @失败 #OK *5000|ENVI @percent=100|ENVI @character=更新LovePE_Hub失败|EXIT _SUB
ENVI @percent=100
ENVI @character=更新LovePE_Hub完成
MESS-icon3 更新成功！ @成功 #OK *3000
_END
_SUB begin11pe
ENVI @percent=10
ENVI @character=正在下载新版11PE
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,###############################################
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,下载11PEX64.WIM
EXEC* buglog==!%CurDir%\aria2c.exe -x 16 -s 16 -j 1 -d %CurDir% -o 11PEX64.WIM "https://pe-down.lovepcos.xyz/down/11PEX64.WIM"
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,$+0,%buglog%
IFEX %CurDir%\11PEX64.WIM,! TEAM MESS-icon1 更新失败，无法从服务器获取文件。 @失败 #OK *3000|ENVI @percent=100|ENVI @character=更新11PE失败|EXIT _SUB
ENVI @percent=60
ENVI @character=正在更新11PE
FILE %HubDir%Data\BOOT\11PEX64.WIM
FILE %CurDir%\11PEX64.WIM->%HubDir%Data\BOOT
IFEX %HubDir%Data\BOOT\11PEX64.WIM,! TEAM MESS-icon1  更新失败，无法从服务器获取文件。\n\n 请向我们提供日志：Logs\setting1%dated%%datem%%dates%.log @失败 #OK *5000|ENVI @percent=100|ENVI @character=更新11PE失败|EXIT _SUB
ENVI @percent=100
ENVI @character=更新11PE完成
MESS-icon3 更新成功！ @成功 #OK *3000
_END
_SUB beginefi
ENVI @percent=10
ENVI @character=正在下载新版引导镜像
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,###############################################
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,+0,下载EFI.ISO
EXEC* buglog==!%CurDir%\aria2c.exe -x 8 -s 8 -j 1 -d %CurDir% -o EFI.ISO "https://pe-down.lovepcos.xyz/down/EFI.ISO"
WRIT-ANSI %HubDir%Logs\setting1%dated%%datem%%dates%.log,$+0,%buglog%
IFEX %CurDir%\EFI.ISO,! TEAM MESS-icon1  更新失败，无法从服务器获取文件。\n\n 请向我们提供日志：Logs\setting1%dated%%datem%%dates%.log @失败 #OK *3000|ENVI @percent=100|ENVI @character=更新引导镜像失败|EXIT _SUB
ENVI @percent=60
ENVI @character=正在更新引导镜像
FILE %HubDir%Data\EFI.ISO
FILE %CurDir%\EFI.ISO->%HubDir%Data\
IFEX %HubDir%Data\EFI.ISO,! TEAM MESS-icon1 更新失败，无法写入文件。 @失败 #OK *5000|ENVI @percent=100|ENVI @character=更新引导镜像失败|EXIT _SUB
ENVI @percent=100
ENVI @character=更新引导镜像完成
MESS-icon3 更新成功！ @成功 #OK *3000
_END