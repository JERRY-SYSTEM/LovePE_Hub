import win.ui;
import process;
import win.reg;
import fsys.res;
import winex;
import fsys.dlg.dir;
import fonts.Hub;
/*DSG{{*/
var write = win.form(text="write";left=20;top=200;right=920;bottom=770;bgcolor=16777215)
write.add(
addhd32={cls="plus";text="添加";left=665;top=300;right=755;bottom=340;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-20;name='Hub')};iconText=' \uE605';notify=1;textPadding={left=39};z=21};
addusb={cls="plus";text="写入";left=145;top=165;right=235;bottom=205;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-20;name='Hub')};iconText=' \uE7A6';notify=1;textPadding={left=39};z=24};
delusb={cls="plus";text="删除";left=255;top=165;right=345;bottom=205;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-20;name='Hub')};iconText=' \uE72A';notify=1;textPadding={left=39};z=23};
disknum={cls="combobox";left=305;top=55;right=585;bottom=80;color=16730624;edge=1;font=LOGFONT(name='HarmonyOS Sans SC Medium';weight=900);items={};mode="dropdown";z=26};
diywall={cls="checkbox";text="自定义PE壁纸";left=330;top=95;right=456;bottom=121;bgcolor=16777215;disabled=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);z=12};
diywalldirection={cls="edit";text="请选择";left=460;top=95;right=538;bottom=120;color=16730624;disabled=1;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;num=1;z=13};
diywalldirectionbegin={cls="button";text="浏览";left=540;top=95;right=585;bottom=120;disabled=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);z=14};
efisize={cls="edit";text="2048";left=740;top=130;right=865;bottom=155;color=16730624;disabled=1;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;num=1;z=18};
efisizelabe={cls="static";text="EFI分区大小(MB)";left=610;top=130;right=740;bottom=155;align="center";center=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=19};
engine={cls="combobox";left=105;top=95;right=305;bottom=120;color=16730624;disabled=1;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);items={};mode="dropdown";z=32};
enginelabe={cls="static";text="写入方式";left=35;top=95;right=105;bottom=121;align="center";center=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=31};
enginen={cls="static";text="提示：如果选择写入方式后此页面没有刷新，请回到主页后重新进入本页面。";left=35;top=209;right=580;bottom=235;align="center";center=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=33};
find={cls="plus";text="刷新可用磁盘";left=725;top=45;right=865;bottom=85;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-15;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-20;name='Hub')};iconText=' \uE649';notify=1;textPadding={left=39};z=25};
fs={cls="combobox";left=725;top=95;right=865;bottom=120;color=16730624;disabled=1;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);items={"NTFS"};mode="dropdown";z=7};
fslabe={cls="static";text="数据区文件系统";left=610;top=95;right=725;bottom=120;align="center";center=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=6};
hd32menu={cls="edit";text="LovePE";left=300;top=310;right=475;bottom=335;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=1};
hd32menulabe={cls="static";text="启动菜单名称";left=195;top=310;right=295;bottom=335;align="center";center=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=17};
hd32mode={cls="static";text="本地模式";left=20;top=300;right=180;bottom=340;align="center";center=1;font=LOGFONT(h=-35;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=2};
hd32wait={cls="edit";text="15";left=593;top=310;right=645;bottom=335;color=16730624;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;num=1;z=15};
hd32waitlabe={cls="static";text="启动等待时间";left=488;top=310;right=588;bottom=335;align="center";center=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=16};
ifin={cls="checkbox";text="仅查找U盘";left=610;top=55;right=720;bottom=80;bgcolor=16777215;checked=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);z=5};
label={cls="edit";text="LovePE";left=400;top=130;right=585;bottom=155;color=16730624;disabled=1;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);multiline=1;z=11};
labellabe={cls="static";text="U盘卷标";left=330;top=130;right=400;bottom=156;align="center";center=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=10};
method={cls="combobox";left=105;top=130;right=305;bottom=155;color=16730624;disabled=1;edge=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);items={"双分区"};mode="dropdown";z=9};
methodlabe={cls="static";text="安装方法";left=35;top=130;right=105;bottom=156;align="center";center=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=8};
mkiso={cls="static";text="生成ISO";left=20;top=455;right=180;bottom=495;align="center";center=1;font=LOGFONT(h=-35;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=4};
redousb={cls="plus";text="  免格升级";left=365;top=165;right=505;bottom=205;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-20;name='Hub')};iconText=' \uE630';notify=1;textPadding={left=39};z=28};
saveiso={cls="plus";text="输出";left=195;top=455;right=285;bottom=495;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-21;name='Hub')};iconText=' \uE627';notify=1;textPadding={left=39};z=20};
static={cls="static";text="目标磁盘";left=235;top=55;right=305;bottom=80;align="center";center=1;font=LOGFONT(h=-16;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=27};
unhide={cls="plus";text="显示EFI分区";left=705;top=165;right=865;bottom=205;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-20;name='Hub')};iconText=' \uE6B3';notify=1;textPadding={left=39};z=29};
uninstallhd32={cls="plus";text="删除";left=775;top=300;right=865;bottom=340;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-20;name='Hub')};iconText=' \uE72A';notify=1;textPadding={left=39};z=22};
ununhide={cls="plus";text="隐藏EFI分区";left=525;top=165;right=685;bottom=205;align="left";bgcolor=-68375;color=16226089;font=LOGFONT(h=-20;name='HarmonyOS Sans SC Medium';weight=900);iconStyle={align="left";font=LOGFONT(h=-20;name='Hub')};iconText=' \uE641';notify=1;textPadding={left=39};z=30};
write2udisk={cls="static";text="写入U盘";left=20;top=45;right=180;bottom=85;align="center";center=1;font=LOGFONT(h=-35;name='HarmonyOS Sans SC Medium';weight=900);transparent=1;z=3}
)
/*}}*/

write.fs.add("FAT32")
write.fs.add("exFAT")
write.disknum.clear()
write.disknum.add("请点击右侧按钮刷新")

//本地加
write.addhd32.oncommand = function(id,event){
	hubreg.setSzValue("hd32","1")
	hubreg.setSzValue("hd32menu",write.hd32menu.text)
	hubreg.setSzValue("hd32wait",write.hd32wait.text)
    process(writ + "\forms\main\core\core.exe","load hd32.vbs")
}

//本地删
write.uninstallhd32.oncommand = function(id,event){
	hubreg.setSzValue("hd32","2")
    process(writ + "\forms\main\core\core.exe","load hd32.vbs")
}

//ISO输出
write.saveiso.oncommand = function(id,event){
	hubreg.setSzValue("writelean","2")
	process(writ + "\forms\main\core\core.exe","load writelean.vbs")
}

//刷新
write.find.oncommand = function(id,event){
	if( write.ifin.checked = 1 ){
		hubreg.setDwValue("ifin",6)
	} else {
		hubreg.setDwValue("ifin",4)
	}
	hubreg.setSzValue("writelean","5")
	process(writ + "\forms\main\core\core.exe","load writelean.vbs").wait()
	write.disknum.clear()
	for listdisk in io.lines(writ + "\FORMS\MAIN\core\listdisk.txt") {
		write.disknum.add( listdisk )
	}
	write.engine.clear()
	if( hubreg.queryValue("aomeiable") = "6" ){
		write.engine.add("1 ※ AOMEI")
		write.engine.add("2 ※ [保留原有数据]AOMEI")
	}else {
		write.unhide.hide = 1
		write.ununhide.hide = 1
	}
	
	write.engine.add("3 ※ DiskPart")
	write.engine.add("4 ※ [只支持U盘]UltraISO")
	write.engine.add("5 ※ Ventoy")
	write.engine.disabled = 0
}


write.engine.oncommand = function(id,event){
	if( write.engine.text == "1 ※ AOMEI" ){
		hubreg.setSzValue("engine","1")
		write.fs.disabled = 0
		enginen = "wr"
	}elseif( write.engine.text == "2 ※ [保留原有数据]AOMEI" ){
		hubreg.setSzValue("engine","2")
		write.fs.disabled = 1
		enginen = "wr"
	}elseif( write.engine.text == "3 ※ DiskPart" ){
		hubreg.setSzValue("engine","3")
		write.fs.disabled = 0
		enginen = "wr"
	}elseif( write.engine.text == "4 ※ [只支持U盘]UltraISO" ){
		hubreg.setSzValue("engine","4")
		enginen = "le"
	}elseif( write.engine.text == "5 ※ Ventoy" ){
		hubreg.setSzValue("engine","5")
		enginen = "le"
	}
	if( enginen == "wr" ){
		write.delusb.hide = 0
		write.redousb.hide = 0
		write.label.disabled = 0
		write.efisize.disabled = 0
	}elseif( enginen == "le" ){
		write.delusb.hide = 1
		write.redousb.hide = 1
		write.fs.disabled = 1
		write.label.disabled = 1
		write.efisize.disabled = 1
	}
	write.diywall.disabled = 0
	write.diywalldirection.disabled = 0
	write.diywalldirectionbegin.disabled = 0
}

//U盘写入
write.addusb.oncommand = function(id,event){
	if(write.diywall.checked = 1){
		hubreg.setDwValue("diywall","6")
		hubreg.setSzValue("diywalldirection",write.diywalldirection.text)
	}else {
		hubreg.setDwValue("diywall","4")
	}
	hubreg.setSzValue("disknum",write.disknum.text)
	if( enginen == "wr" ){
		hubreg.setSzValue("writeusb","1")
		hubreg.setSzValue("fs",write.fs.text)
		hubreg.setSzValue("efisize",write.efisize.text)
		hubreg.setSzValue("label",write.label.text)
		process(writ + "\forms\main\core\core.exe","load writeusb.vbs")
	}elseif( enginen == "le" ){
		hubreg.setSzValue("writelean","1")
		process(writ + "\forms\main\core\core.exe","load writelean.vbs")
	}
}

//U盘删除
write.delusb.oncommand = function(id,event){
	hubreg.setSzValue("disknum",write.disknum.text)
		hubreg.setSzValue("fs",write.fs.text)
		hubreg.setSzValue("label",write.label.text)
	hubreg.setSzValue("writeusb","2")
	process(writ + "\forms\main\core\core.exe","load writeusb.vbs")
}

//升级
write.redousb.oncommand = function(id,event){
	hubreg.setSzValue("disknum",write.disknum.text)
	hubreg.setSzValue("writeusb","3")
	process(writ + "\forms\main\core\core.exe","load writeusb.vbs")
}

//显示EFI
write.unhide.oncommand = function(id,event){
	hubreg.setSzValue("writelean","3")
	process(writ + "\forms\main\core\core.exe","load writelean.vbs")
}

//隐藏EFI
write.ununhide.oncommand = function(id,event){
	hubreg.setSzValue("writelean","4")
	process(writ + "\forms\main\core\core.exe","load writelean.vbs")
}

write.diywall.oncommand = function(id,event){
	if(write.diywall.checked = 1){
		write.diywalldirection.disabled = 0
	}else {
		write.diywalldirection.disabled = 1
	}
}

write.diywalldirectionbegin.oncommand = function(id,event){
	write.diywall.checked = 1
	write.diywalldirection.disabled = 0
	diywallchoice = fsys.dlg.open("JPEG文件|*.jpg|","打开自定义壁纸")
	write.diywalldirection.text = diywallchoice
}

write.saveiso.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
write.addhd32.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
write.uninstallhd32.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
write.addusb.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
write.delusb.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
write.find.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})
write.redousb.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})

write.unhide.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})

write.ununhide.skin({
	background={
		default=0xFFE9F4FE;
		hover=0xFFEDF6FE
	};
	color={
		default=0xFF2997F7;
		hover=0xFF54ACF9
	}
})

write.show();
win.loopMessage();
return write;