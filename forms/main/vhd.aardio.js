import win.ui;
import win.reg;
import process;
import fsys.res;
import fsys.dlg;
import fonts.Hub;
/*DSG{{*/
var vhd = win.form(text="vhd";left=20;top=200;right=920;bottom=770;bgcolor=16777215)
vhd.add(
beginning={cls="plus";text="生成";left=795;top=150;right=885;bottom=190;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-21;name='Hub')};iconText=' \uE657';notify=1;textPadding={left=39};z=14};
big={cls="edit";text="5120";left=260;top=110;right=460;bottom=135;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;num=1;z=7};
biglabe={cls="static";text="请选择VHD大小(单位MB)：";left=15;top=110;right=260;bottom=135;align="center";center=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=6};
choicefile={cls="edit";left=165;top=70;right=460;bottom=95;acceptfiles=1;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=1};
choicewim={cls="edit";text="1";left=845;top=70;right=885;bottom=95;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;num=1;z=4};
dad={cls="checkbox";text="拆分(推荐)";left=573;top=110;right=673;bottom=135;bgcolor=16777215;checked=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);z=9};
diypevhd={cls="plus";text="自定义WIM";left=610;top=65;right=735;bottom=100;bgcolor=-68375;color=16226089;font=LOGFONT(h=-14;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-21;name='Hub')};iconText=' \uE609';notify=1;textPadding={left=39};z=18};
expandable={cls="checkbox";text="动态扩展";left=468;top=110;right=568;bottom=135;bgcolor=16777215;checked=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);z=8};
filelabe={cls="static";text="请选择WIM文件：";left=15;top=70;right=175;bottom=95;align="center";center=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=3};
ing={cls="static";text="开发中......";left=300;top=460;right=600;bottom=500;align="center";center=1;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=19};
lpvhd={cls="plus";text="生成LovePE版";left=465;top=65;right=605;bottom=100;bgcolor=-68375;color=16226089;font=LOGFONT(h=-14;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-21;name='Hub')};iconText=' \uE9A9';notify=1;textPadding={left=39};z=17};
sethd32menulabe={cls="static";text="请输入启动菜单名称：";left=15;top=290;right=215;bottom=315;align="center";center=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=13};
vhd_addhd32={cls="plus";text="添加";left=685;top=330;right=775;bottom=370;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-21;name='Hub')};iconText=' \uE605';notify=1;textPadding={left=39};z=16};
vhd_hd32mode={cls="static";text="VHDPE本地模式";left=300;top=235;right=600;bottom=275;align="center";center=1;font=LOGFONT(h=-35;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=11};
vhd_hd32wait={cls="edit";text="15";left=720;top=290;right=885;bottom=315;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;num=1;z=20};
vhd_hd32waitlabe={cls="static";text="启动等待时间";left=615;top=290;right=715;bottom=315;align="center";center=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=21};
vhd_more={cls="static";text="VHDPE更多功能";left=300;top=415;right=600;bottom=455;align="center";center=1;font=LOGFONT(h=-35;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=12};
vhd_sethd32menu={cls="edit";text="请输入启动菜单名称";left=205;top=290;right=575;bottom=315;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=10};
vhd_uninstallhd32={cls="plus";text="删除";left=795;top=330;right=885;bottom=370;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-21;name='Hub')};iconText=' \uE72A';notify=1;textPadding={left=39};z=15};
vhdpemakerlabe={cls="static";text="VHDPE一键生成";left=300;top=18;right=600;bottom=58;align="center";center=1;font=LOGFONT(h=-35;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=2};
wimlabe={cls="static";text="WIM分卷：";left=745;top=70;right=845;bottom=95;align="center";center=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=5}
)
/*}}*/

vhd.choicefile.text = curdir + "Data\BOOT\11PEX64.WIM"

vhd.beginning.oncommand = function(id,event){
	if( vhd.expandable.checked = 1){
		hubreg.setDwValue("vhd_expandable","6")
	}else{
	    hubreg.setDwValue("vhd_expandable","4")
	}
	if( vhd.dad.checked = 1){
		hubreg.setDwValue("vhd_dad","6")
	}else{
		hubreg.setDwValue("vhd_dad","4")
	}
	vhd_choicefile = vhd.choicefile.text
	hubreg.setSzValue("vhd_choicefile",vhd_choicefile)
	vhd_choicewim = vhd.choicewim.text
	hubreg.setSzValue("vhd_choicewim",vhd_choicewim)
	vhd_big = vhd.big.text
	hubreg.setSzValue("vhd_big",vhd_big)
	process(writ + "\forms\main\core\core.exe","load vhdmaker.vbs")
}

vhd.vhd_addhd32.oncommand = function(id,event){
	hubreg.setSzValue("hd32","3")
	hubreg.setSzValue("hd32menu",vhd.vhd_sethd32menu.text)
	hubreg.setSzValue("hd32wait",vhd.vhd_hd32wait.text)
    process(writ + "\forms\main\core\core.exe","load hd32.vbs")
}

vhd.vhd_uninstallhd32.oncommand = function(id,event){
	hubreg.setSzValue("hd32","4")
    process(writ + "\forms\main\core\core.exe","load hd32.vbs")
}

vhd.lpvhd.oncommand = function(id,event){
	vhd.choicefile.text = curdir + "Data\BOOT\11PEX64.WIM"
}

vhd.diypevhd.oncommand = function(id,event){
	choicefsys = fsys.dlg.open("PE镜像|*.wim|",请选择PE镜像,curdir,,,"11PEX64.WIM")
	vhd.choicefile.text = choicefsys
}

vhd.lpvhd.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
vhd.diypevhd.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
vhd.beginning.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
vhd.vhd_addhd32.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
vhd.vhd_uninstallhd32.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})


vhd.show();
win.loopMessage();
return vhd;