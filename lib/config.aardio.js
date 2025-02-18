﻿//config 配置文件
import fsys.config;
config  = fsys.config( io.appData("/aardio/app/") ); 

//不需要序列化的配置名字前请添加下划线
namespace config {
	__appName = "ZnPE_Hub";
	__appVersion = "0.0.0.01";
	__appDescription = "ZnPE_Hub";
	__website = "https://www.znpe.top/";
}

/**intellisense(config)
__appName = 应用程序名
__appVersion = 应用程序内部版本号
__appDescription = 程序说明
__website = 官方网站
? = 配置文件名,\n读写配置并序列化为一个表对象,\n表的成员值可以是支持序列化的普通变量,支持table对象\n配置文件在首次使用时自动加载,退出程序时自动保存\n!fsys_table.
end intellisense**/