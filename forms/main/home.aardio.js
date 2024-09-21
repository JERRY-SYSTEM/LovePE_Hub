import win.ui;
import win.reg;
import process;
import fonts.Hub;
/*DSG{{*/
var home = win.form(text="home";left=20;top=200;right=920;bottom=770;bgcolor=16777215)
home.add(
hello={cls="picturebox";left=30;top=200;right=200;bottom=370;image=$"~\font\hello.jpg";z=1};
hello_user_morning={cls="static";text=".";left=200;top=100;right=900;bottom=140;align="center";center=1;font=LOGFONT(h=-35;name='HarmonyOS Sans SC Medium';weight=900);notify=1;transparent=1;z=2};
ltsb={cls="static";text="心心相融 Hreat To Heart！";left=550;top=530;right=890;bottom=560;align="center";center=1;font=LOGFONT(h=-24;name='HarmonyOS Sans SC Medium';weight=900);notify=1;transparent=1;z=3};
necessary={cls="plus";text="下载必须文件";left=670;top=300;right=845;bottom=340;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);hide=1;iconStyle={align="left";font=LOGFONT(h=-21;name='Hub')};iconText='  \uF25A';notify=1;textPadding={left=39};z=6};
udisk={cls="static";text='请在左侧选项卡栏中选择您需要的功能 \u256E(\uFFE3\u25BD\uFFE3)\u256D';left=200;top=250;right=900;bottom=290;align="center";center=1;font=LOGFONT(h=-24;name='HarmonyOS Sans SC Medium';weight=900);notify=1;transparent=1;z=4};
welcome={cls="static";text="欢迎使用LovePE";left=455;top=150;right=645;bottom=180;align="center";center=1;font=LOGFONT(h=-24;name='HarmonyOS Sans SC Medium';weight=900);notify=1;transparent=1;z=5}
)
/*}}*/

hubreg.setDwValue("setting1","1")
process(writ + "\forms\main\core\core.exe","load setting1.vbs").wait()

if( hubreg.queryValue("nonecessary") == "4" ){
	home.necessary.hide = 0
	home.udisk.text = "未找到您的LovePE_Hub必要文件，您要下载吗(❁´◡`❁)"
}
home.necessary.oncommand = function(id,event){
	hubreg.setDwValue("setting1","5")
	process(writ + "\forms\main\core\core.exe","load setting1.vbs")
}

var environment = win.reg("HKEY_CURRENT_USER\Volatile Environment")
home.hello_user_morning.text=environment.queryValue("USERNAME") + "，" + hubreg.queryValue("morning") + "好！"

home.necessary.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})

home.show();
win.loopMessage();
return winform;