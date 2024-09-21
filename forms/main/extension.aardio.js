import win.ui;
import fsys.dlg.dir;
import win.reg;
import process;
import fonts.Hub;
/*DSG{{*/
var extension = win.form(text="aardio form";left=20;top=200;right=920;bottom=770;bgcolor=16777215)
extension.add(
choice={cls="button";text="浏览";left=605;top=235;right=650;bottom=260;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);hide=1;z=11};
choicefile={cls="edit";text="请先在左侧选择类型";left=95;top=235;right=600;bottom=260;acceptfiles=1;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=10};
choicelabe={cls="combobox";left=20;top=235;right=90;bottom=261;color=16730624;edge=1;font=LOGFONT(h=-14;name='HarmonyOS Sans SC Medium';weight=900);items={};mode="dropdownlist";vscroll=1;z=43};
first={cls="groupbox";text="第一步：基本信息";left=10;top=75;right=660;bottom=200;bgcolor=2812660;color=16777215;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);z=26};
fourth={cls="groupbox";text="第四步：扩展打包";left=10;top=370;right=660;bottom=480;bgcolor=2812660;color=16777215;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);z=31};
greenbat={cls="checkbox";left=20;top=295;right=105;bottom=320;bgcolor=16777215;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);hide=1;z=13};
greenbatchoice={cls="edit";left=105;top=295;right=280;bottom=320;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);hide=1;multiline=1;z=12};
greenbatchoicebegin={cls="button";text="浏览";left=285;top=295;right=330;bottom=320;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);hide=1;z=15};
greenlink={cls="checkbox";text="快捷方式";left=335;top=330;right=435;bottom=355;bgcolor=16777215;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);hide=1;z=21};
greenlinkexe={cls="edit";text="须在扩展所在文件夹中";left=505;top=330;right=600;bottom=355;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);hide=1;multiline=1;z=23};
greenlinkexebegin={cls="button";text="浏览";left=605;top=330;right=650;bottom=355;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);hide=1;z=24};
greenlinknamed={cls="edit";text="名称";left=435;top=330;right=500;bottom=355;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);hide=1;multiline=1;z=22};
greenreg={cls="checkbox";text="注册表";left=335;top=295;right=425;bottom=320;bgcolor=16777215;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);hide=1;z=14};
greenregchoice={cls="edit";text="须在扩展所在文件夹中";left=425;top=295;right=600;bottom=320;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);hide=1;multiline=1;z=16};
greenregchoicebegin={cls="button";text="浏览";left=605;top=295;right=650;bottom=320;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);hide=1;z=17};
greenwcz={cls="checkbox";left=20;top=330;right=120;bottom=355;bgcolor=16777215;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);hide=1;z=18};
greenwczchoice={cls="edit";left=120;top=330;right=280;bottom=355;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);hide=1;multiline=1;z=19};
greenwczchoicebegin={cls="button";text="浏览";left=285;top=330;right=330;bottom=355;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);hide=1;z=20};
ico={cls="checkbox";text="图标";left=335;top=170;right=425;bottom=195;bgcolor=16777215;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);z=39};
icochioce={cls="button";text="浏览";left=605;top=170;right=650;bottom=195;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);z=38};
icoini={cls="edit";text="打开一个ICO图标";left=425;top=170;right=600;bottom=195;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=37};
introduction={cls="static";text="扩展介绍:";left=15;top=135;right=105;bottom=160;align="center";center=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=7};
introductionini={cls="edit";text="不可有空格！";left=105;top=135;right=330;bottom=160;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=6};
lpexMall={cls="plus";text="   扩展市场";left=710;top=90;right=880;bottom=130;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-21;name='Hub')};iconText='  \uE648';notify=1;textPadding={left=39};z=41};
lpexmalllabe={cls="static";text="扩展市场";left=710;top=30;right=880;bottom=70;align="center";center=1;font=LOGFONT(h=-35;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=40};
lpexp={cls="edit";text="LovePE";left=170;top=395;right=650;bottom=420;acceptfiles=1;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=29};
lpexplabe={cls="static";text="请自定义密钥，密钥会加密储存，修改扩展包必须输入此密钥，默认为LovePE。";left=20;top=420;right=650;bottom=445;align="center";center=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=32};
lpexps={cls="static";text="请输入加密密钥:";left=20;top=395;right=165;bottom=420;align="center";center=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=30};
named={cls="static";text="扩展名称:";left=15;top=100;right=105;bottom=125;align="center";center=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=3};
namedini={cls="edit";text="不可有空格！";left=105;top=100;right=330;bottom=125;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=1};
second={cls="groupbox";text="第二步：添加文件";left=10;top=210;right=660;bottom=265;bgcolor=2812660;color=16777215;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);z=27};
sending={cls="edit";text="请选择";left=170;top=445;right=600;bottom=470;acceptfiles=1;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=33};
sendingbegin={cls="button";text="浏览";left=605;top=445;right=650;bottom=470;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);z=35};
sendinglabe={cls="static";text="请选择保存位置:";left=20;top=445;right=165;bottom=470;align="center";center=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=34};
sort={cls="static";text="扩展分类:";left=15;top=170;right=105;bottom=195;align="center";center=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=36};
sortini={cls="combobox";left=105;top=170;right=330;bottom=195;color=16730624;edge=1;font=LOGFONT(h=-14;name='HarmonyOS Sans SC Medium';weight=900);items={};mode="dropdownlist";vscroll=1;z=25};
startmake={cls="plus";text="开始制作";left=260;top=490;right=410;bottom=545;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-24;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-21;name='Hub')};iconText='  \uE657';notify=1;textPadding={left=39};z=42};
static={cls="static";text="LovePE扩展(插件)制作器";left=20;top=30;right=655;bottom=70;align="center";center=1;font=LOGFONT(h=-35;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=2};
third={cls="groupbox";text="第三步：安装程序";left=10;top=270;right=660;bottom=365;bgcolor=2812660;color=16777215;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);z=28};
version={cls="static";left=335;top=100;right=425;bottom=125;align="center";center=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=5};
versionini={cls="edit";text="不可有空格！";left=425;top=100;right=650;bottom=125;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=4};
writer={cls="static";text="扩展作者:";left=335;top=135;right=425;bottom=160;align="center";center=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=9};
writerini={cls="edit";text="不可有空格！";left=425;top=135;right=650;bottom=160;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=8}
)
/*}}*/

//下拉框条目
extension.sortini.clear()
extension.sortini.add("安全防护")
extension.sortini.add("备份还原")
extension.sortini.add("办公编辑")
extension.sortini.add("磁盘工具")
extension.sortini.add("即时通讯")
extension.sortini.add("编程开发")
extension.sortini.add("网络相关")
extension.sortini.add("影音图片")
extension.sortini.add("硬件检测")
extension.sortini.add("输入工具")
extension.sortini.add("远程协助")
extension.sortini.add("运行环境")
extension.sortini.add("实用工具")
extension.sortini.add("文件管理")
extension.choicelabe.clear()
extension.choicelabe.add("程序文件")
extension.choicelabe.add("官方直链")
extension.choicelabe.add("驱动程序")

extension.choicelabe.oncommand = function(id,event){
	extension.choicefile.disabled = 0
	if(extension.choicelabe.text = "程序文件"){
		extension.choice.hide = 0
		extension.greenbat.hide = 0
		extension.greenbatchoice.hide = 0
		extension.greenwcz.hide = 0
		extension.greenwczchoice.hide = 0
		extension.choicefile.text = "请点击浏览按钮添加程序文件"
		extension.greenbat.text = "程序"
		extension.greenbatchoice.text = "须在扩展所在文件夹中"
		extension.greenwcz.text = "PECMD"
		extension.greenwczchoice.text = "须在扩展所在文件夹中"
		extension.version.text = "扩展版本:"
		extension.versionini.hide = 0
		extension.greenbat.checked = 0
		extension.greenbat.disabled = 0
		extension.greenwcz.checked = 0
		extension.greenreg.hide = 0
		extension.greenlink.hide = 0
		extension.greenbatchoicebegin.hide = 0
		extension.greenregchoicebegin.hide = 0
		extension.greenwczchoicebegin.hide = 0
		extension.greenlinkexebegin.hide = 0
		extension.greenregchoice.hide = 0
		extension.greenlinkexe.hide = 0
		extension.greenlinknamed.hide = 0
	}else{
		extension.version.text = "无需填写:"
		extension.versionini.hide = 1
		extension.greenbat.checked = 1
		extension.greenbat.disabled = 1
		extension.greenwcz.checked = 0
		extension.greenreg.hide = 1
		extension.greenlink.hide = 1
		extension.greenbatchoicebegin.hide = 1
		extension.greenregchoicebegin.hide = 1
		extension.greenwczchoicebegin.hide = 1
		extension.greenlinkexebegin.hide = 1
		extension.greenregchoice.hide = 1
		extension.greenlinkexe.hide = 1
		extension.greenlinknamed.hide = 1
		if(extension.choicelabe.text = "官方直链"){
			extension.choice.hide = 1
			extension.greenbat.hide = 0
			extension.greenbatchoice.hide = 0
			extension.greenwcz.hide = 0
			extension.greenwczchoice.hide = 0
			extension.choice.hide = 1
			extension.choicefile.text = "请直接输入以http(s)开头的下载直链"
			extension.greenbat.text = "文件名"
			extension.greenbatchoice.text = "(必选,带后缀)下载到本地的文件名"
			extension.greenwcz.text = "运行参数"
			extension.greenwczchoice.text = "自动静默安装参数(可选)"
		}elseif(extension.choicelabe.text = "驱动程序"){
			extension.greenbat.hide = 1
			extension.greenbatchoice.hide = 1
			extension.greenwcz.hide = 1
			extension.greenwczchoice.hide = 1
			extension.choice.hide = 0
			extension.choicefile.text = "请打开Dism++导出的驱动程序文件夹所在文件夹"
			extension.greenbat.hide = 1
			extension.greenbatchoice.hide = 1
			extension.greenwcz.hide = 1
			extension.greenwczchoice.hide = 1
		}
		
	}
}

//文件打开提示框
extension.choice.oncommand = function(id,event){
	choice_file = fsys.dlg.dir(,,"添加文件","添加文件")
	extension.choicefile.text = choice_file
}

extension.greenbatchoicebegin.oncommand = function(id,event){
	extension.greenbat.checked = 1
	greenbatchoice = fsys.dlg.open("EXE程序|*.exe|BAT脚本|*.bat|CMD脚本|*.cmd|","打开安装程序",chioce_file)
	extension.greenbatchoice.text = greenbatchoice
}

extension.greenregchoicebegin.oncommand = function(id,event){
	extension.greenreg.checked = 1
	greenregchoice = fsys.dlg.open("REG注册表文件|*.reg|","打开注册表文件",chioce_file)
	extension.greenregchoice.text = greenregchoice
}

extension.greenwczchoicebegin.oncommand = function(id,event){
	extension.greenwcz.checked = 1
	greenwczchoice = fsys.dlg.open("WSZ脚本|*.wsz|WCZ脚本|*.wcz|ini脚本|*.ini|","打开PECMD脚本",chioce_file)
	extension.greenwczchoice.text = greenwczchoice
}

extension.greenlinkexebegin.oncommand = function(id,event){
	extension.greenlink.checked = 1
	greenlinkexe = fsys.dlg.open("所有文件|*.*|EXE程序|*.exe|","打开快捷方式目标",chioce_file)
	extension.greenlinkexe.text = greenlinkexe
}

extension.sendingbegin.oncommand = function(id,event){
	sendingdirection = fsys.dlg.saveOp("LovePE扩展扩展|*.lpex|","保存扩展",,,extension.namedini.text + "_" + extension.sortini.text + "_" + extension.versionini.text + "_" + extension.writerini.text + "_" + extension.introductionini.text)
    extension.sending.text = sendingdirection
}

extension.icochioce.oncommand = function(id,event){
	extension.ico.checked = 1
	icodirection = fsys.dlg.open("ICO图标|*.ico|","请打开图标")
	extension.icoini.text = icodirection
}

//开始制作按钮按下
extension.startmake.oncommand = function(id,event){
	hubreg.setSzValue("extension_named",extension.namedini.text)
	hubreg.setSzValue("extension_introduction",extension.introductionini.text)
	hubreg.setSzValue("extension_writer",extension.writerini.text)
	hubreg.setSzValue("extension_chiocefile",extension.choicefile.text)
	hubreg.setSzValue("extension_lpexp",extension.lpexp.text)
	hubreg.setSzValue("extension_sortini",extension.sortini.text)
	hubreg.setSzValue("extension_sending",extension.sending.text)
	if( extension.ico.checked = 1){
		hubreg.setDwValue("extension_icoable","6")
	    hubreg.setSzValue("extension_icoini",extension.icoini.text)
	}else {
	    hubreg.setDwValue("extension_icoable","4")
	}
	
	if(extension.choicelabe.text = "驱动程序"){
		hubreg.setSzValue("extension_version","DriverStore")
	}else{
		if( extension.greenbat.checked = 1){
			hubreg.setDwValue("extension_greenbatable","6")
			hubreg.setSzValue("extension_greenbatchoice",extension.greenbatchoice.text)
		}else {
		    hubreg.setDwValue("extension_greenbatable","4")
		}
		if( extension.greenwcz.checked = 1){
			hubreg.setDwValue("extension_greenwczable","6")
			hubreg.setSzValue("extension_greenwczchoice",extension.greenwczchoice.text)
		}else {
		    hubreg.setDwValue("extension_greenwczable","4")
		}
		if(extension.choicelabe.text = "程序文件"){
			hubreg.setSzValue("extension_version",extension.versionini.text)
			if( extension.greenreg.checked = 1){
				hubreg.setDwValue("extension_greenregable","6")
				hubreg.setSzValue("extension_greenregchoice",extension.greenregchoice.text)
			}else {
			    hubreg.setDwValue("extension_greenregable","4")
			}
			if( extension.greenlink.checked = 1){
				hubreg.setDwValue("extension_greenlinkable","6")
				hubreg.setSzValue("extension_greenlinknamed",extension.greenlinknamed.text)
				hubreg.setSzValue("extension_greenlinkexe",extension.greenlinkexe.text)
			}else {
			    hubreg.setDwValue("extension_greenlinkable","4")
			}
		}elseif(extension.choicelabe.text = "官方直链"){
			hubreg.setSzValue("extension_version","down")
		}
	}
	process(writ + "\forms\main\core\core.exe","load extensionmaker.vbs")
}

extension.lpexMall.oncommand = function(id,event){
	hubreg.setDwValue("setting1","3")
	process(writ + "\forms\main\core\core.exe","load setting1.vbs")
}


extension.lpexMall.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
extension.startmake.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})

extension.show();
win.loopMessage();
return extension;