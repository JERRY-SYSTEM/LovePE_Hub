--下载相关添加
local getfullpath_func = type(File.GetFullPath)
if getfullpath_func == "function" then
temp = File.GetFullPath(os.getenv("temp"))
else
temp = os.getenv("temp")
end
SystemDrive = os.getenv("SystemDrive")
local fixed_speed_out = {}
local logfile = winapi.get_current_pid() .. ".log"
TIMER_ID_QUIT = 1002
TIMER_ID_LOADING = 10088
TIMER_ID_CHECK_INSTALLED = 10089
eta_str = 0
dl_str = 0
app_runpath = APP_Path
downpath = HubDir
set_downpath = HubDir
app_setup_args = "/S"
local path = APP_Path .. "\\" .. "lpexMall_" .. logfile
process_val = 0
function ckadmin()
	if exec("/wait", [[REG QUERY "HKU\S-1-5-19"]]) == 1 then 
        toadmin = winapi.show_message("没有以管理员身份运行!", "请右键管理员身份运行本程序!，\n是否现在就尝试管理员身份重新运行本程序？"
            , "yes-no", "warning")
    end
    if toadmin == "yes" then
        --exec('/hide', [[cmd /c shutdown -a]])
        --winapi.show_message('注意', "执行管理员提升权限操作")
        exec("/admin", [["]] .. APP_Path .. [[\lpexMall.exe" -ui -jcfg wxsUI\LovePE_extension_Mall\main.jcfg]])
        sui:close()
        return
    elseif toadmin == "no" then
        return
    end
end

--other
--下载相关

function ontimer(id)
    if id == TIMER_ID_QUIT then
        sui:close()
    elseif id == TIMER_ID_LOADING then
        loading()
    end
end

--下载开始
function string.gfind(stdout, patten)
    local i, j = 0, 0
    return function()
        i, j = string.find(stdout, patten, j + 1)
        if (i == nil) then -- end find
            return nil
        end
        return string.sub(stdout, i, j)
    end
end

function loading()
    local file = io.open(path, "r")
    local text = file:read("*a")
    file:close()
    local regex = "([^\n]+)[\n]*$" -- 匹配最后一行有效文本 $表示匹配字符串结尾位置
    complete = text:match("Download complete: ([^] %s]+)")
    for all_str in string.gfind(text, "[[][#].-[]]") do
        table.insert(fixed_speed_out, all_str)
    end
    down_str = table.concat(fixed_speed_out, "\n\n")
    --winapi.show_message("最后一个", down_str)
    --文件判断语句备份
    for loading_str in string.gmatch(down_str, regex) do
        dl_str = loading_str:match("DL:([^] %s]+)")
        --eta_str = loading_str:match("ETA:([^]]+)")
        process_val = loading_str:match("[((]([^%%]+)")
        if process_val ~= nil and eta_str ~= nil and process_val < "98" then
            APP_Downini.text = process_val .. "%  ※  " .. dl_str .. "/S"
            --APP_Downini.text = "已经完成:" .. process_val .. "% 速度:" .. dl_str .. "/S 剩余时间:" .. eta_str
            App_ProgressBar.value = process_val
        end
    end
    if complete ~= nil then
        --eta_str = "0S"
        App_ProgressBar.value = 100
        process_val = 100
        suilib.call("KillTimer", 10088)
        APP_Downini.text = "下载完成"
    end
end

function app_init()
    App_ProgressBar = sui:find("App_ProgressBar")
    --如果是pe，调用ntboot


    --不安装的程序如果存在直接运行
    if app_url ~= nil or user_agent ~= nil then
        exec(
            "/hide",
            [[cmd /c aria2c --allow-overwrite=true ]] ..
            aria2c_args ..
            [[ ]] ..
            user_agent .. [[ "]] .. app_url .. [[" -d ]] .. downpath .. [[ -o ]] .. app_setup .. [[>]] .. path
        )
    end
    App_ProgressBar = sui:find("$App[" .. ITEMID .. "]ProgressBar")
    APP_Downini.visible = "1"
    APP_Downini.text = "准备下载"
    App_ProgressBar.visible = "1"
    App_ProgressBar.value = 0
    suilib.call("SetTimer", TIMER_ID_LOADING, 1000)
end

---下载初始化结束

function storedl(app_url, user_agent, app_setup, app_setup_args, app_runpath, aria2c_args)
    app_init()
end

function onlick_app(app_click, appmode)

    ITEMID = AppInfo[app_click].id
    APP_Downini = sui:find("$App[" .. ITEMID .. "]downini")
    adminmode = AppInfo[app_click].adminmode
    if adminmode ~= nil then
        ckadmin()
	 end

    if appmode == "runapp" then
        --如果是商店直链
        runapp = AppInfo[app_click].app_runpath
        APP_Downini.text = "正在运行"
        exec(runapp)
    elseif appmode == "StoreApp_direct_url" then
        --如果是商店解析链
        app_url = AppInfo[app_click].direct_url
        app_runpath = AppInfo[app_click].app_runpath
        app_setup_args = AppInfo[app_click].app_setup_args
        app_setup = AppInfo[app_click].app_setup
        user_agent = AppInfo[app_click].user_agent
        aria2c_args = AppInfo[app_click].aria2c_args
        storedl(app_url, user_agent, app_setup, app_setup_args, app_runpath, aria2c_args)
    elseif app_click ~= nil and appmode == nil then
        msg("无法使用，缺少info.appmode相关项")
    end
end

function dl_onload()
    onclick("$Nav[5]")
end

function dl_onclick(ctrl)

    if ctrl == "set_button" then
        set_downpath = Dialog:BrowseFolder('请选择下载保存位置，默认为LovePE_Hub所在目录。\n当前位置为：' ..
            downpath .. "\n ", 15)
    end
    if set_downpath == "" then
        downpath = HubDir
    else
        downpath = set_downpath
    end
    local app_click = ctrl:match("$App%[(.+)%]")
    if app_click ~= nil then
        appmode = AppInfo[app_click].appmode
        onlick_app(app_click, appmode)
    end
end
