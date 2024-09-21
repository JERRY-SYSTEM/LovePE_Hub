import win.ui;
import win.reg;
import process;
import fonts.Hub;
/*DSG{{*/
var setting = win.form(text="setting";left=20;top=200;right=920;bottom=770;bgcolor=16777215)
setting.add(
beginupdate={cls="plus";text="开始下载/更新";left=90;top=25;right=270;bottom=65;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-21;name='Hub')};iconText='  \uF25A';notify=1;textPadding={left=39};z=1};
info_first={cls="static";text="LovePE_Hub";left=700;top=455;right=885;bottom=475;center=1;color=11645361;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=3};
info_fourth={cls="static";text="buildtime：2023.01.26";left=700;top=515;right=885;bottom=535;center=1;color=11645361;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=6};
info_second={cls="static";text="By Lovepcos x LovePE";left=700;top=475;right=885;bottom=495;center=1;color=11645361;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=4};
info_third={cls="static";text="version：4.0";left=700;top=495;right=885;bottom=515;center=1;color=11645361;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=5};
plus={cls="plus";text="官网：pe.lovepcos.cn";left=691;top=538;right=872;bottom=558;align="left";color=16226089;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);notify=1;textPadding={left=5};z=7};
updatelabe={cls="static";text="更新";left=20;top=25;right=80;bottom=65;align="center";center=1;font=LOGFONT(h=-24;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=2}
)
/*}}*/

curdir = hubreg.queryValue("HubDir")

setting.plus.oncommand = function(id,event){
	process("explorer.exe","https://pe.lovepcos.cn")
}

setting.beginupdate.oncommand = function(id,event){
	hubreg.setDwValue("setting1","5")
	process(writ + "\forms\main\core\core.exe","load setting1.vbs")
}


setting.beginupdate.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
setting.plus.skin({
	color={
		active=0xFFE9D6F9;
		default=0xFF2997F7;
		hover=0xFF80C2FF
	}
})


setting.show();
win.loopMessage();
return setting;