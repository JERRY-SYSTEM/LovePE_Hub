local ntbootfile_ext = ""
local bootfile = ""
local getfullpath_func = type(File.GetFullPath)
if getfullpath_func == "function" then
temp = File.GetFullPath(os.getenv("temp"))
else
temp = os.getenv("temp")
end
systemdrive = os.getenv("systemdrive")

-- 提取固定值
local exitcode, stdout = winapi.execute("cmd /c mountvol")
stdout = stdout:gsub("\r\n", "\n")
bios_str = stdout:match("EFI ([^\n]+)\n")

-- 获取系统版本
function get_winver()
    local exitcode, stdout = winapi.execute([[ver]])
    local winver_str = stdout:match("10.0.")
    if winver_str ~= nil then
        winver = "Win10/Win11"
    else
        winver = "win7"
    end
end

-- 检测环境
function ck_bios()
    if bios_str == nil then
        bios_str = "Legacy"
        boot_platform = "bios"
        wimwinload = [[\Windows\system32\boot\winload.exe]]
        vhdwinload = [[\Windows\system32\winload.exe]]
    else
	    bcd_drv = "B:"
        bios_str = "UEFI"
        boot_platform = "uefi"
        wimwinload = [[\Windows\system32\boot\winload.efi]]
        vhdwinload = [[\Windows\system32\winload.efi]]
    end
end
ck_bios()
App_platform = sui:find("boot_platform")
App_platform.text = "当前环境：" .. bios_str

function ntboot_init()
    if File.exists("X:\\ipxefm\\ipxeboot.txt") or systemdrive == "X:" then
        exec("/hide /wait", [[cmd /c mkdir "X:\program files\ms" ]])
        exec("/hide",
             [[cmd /c copy /y X:\ipxefm\app\wimboot\*.* "X:\program files\ms"]])
        get_winver()
        ntboot_addmode = "pe"

        check_offline_os()
        ntboot_runmode = "WinPE环境模式!(离线系统[启动]盘符->" .. bcd_drv ..
                             "] [启动环境->" .. bios_str .. "]"
        APP_Path = os.getenv("WINXSHELL_MODULEPATH")
    else
        get_winver()
        boot_drv = os.getenv("systemdrive")
        bcd_drv = os.getenv("systemdrive")
        ntboot_addmode = "os"
        ntboot_runmode = "正常系统环境!(系统[启动]盘符)->" .. boot_drv ..
                             "] [启动环境->" .. bios_str .. "]"
    end
end

function ntboot_onload()
    -- addwim()
    if has_option("-ntboot") then
        bootfile = get_option("-ntboot")
        ntboot_args(bootfile)
    end
    if has_option("-now") then
        bootnow = "1"
    else
        bootnow = "0"
    end
end
