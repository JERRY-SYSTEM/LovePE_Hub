import win.ui;
import win.ui.simpleWindow;
import win.region.round;
import win.ui.tabs;
import win.reg;
import process;
import fsys;
import fsys.res;
import io;
/*DSG{{*/
mainForm = win.form(text="LovePE_Hub";left=100;top=100;right=1100;bottom=700;bgcolor=16777215;border="none";max=false;min=false;mode="popup";title=false)
mainForm.add(
barClose={cls="plus";left=972;top=3;right=997;bottom=28;foreground="\forms\main\png\barClose.png";notify=1;z=9};
barMin={cls="plus";left=950;top=8;right=965;bottom=23;foreRepeat="expand";foreground="\forms\main\png\barMin.png";notify=1;repeat="stretch";z=10};
custom={cls="custom";left=100;top=30;right=1000;bottom=600;bgcolor=16777215;db=1;dl=1;dr=1;dt=1;z=4};
extension={cls="plus";text="扩展插件";left=0;top=225;right=100;bottom=300;bkBottom=3;bkLeft=7;bkRight=8;border={color=-65536};color=16777215;dl=1;dt=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=700);foreground="\forms\main\png\extension.png";notify=1;repeat="scale";textPadding={bottom=10};valign="bottom";x=0.5;y=0.2;z=7};
home={cls="plus";text="主页";left=0;top=0;right=100;bottom=75;bkBottom=3;bkLeft=7;bkRight=8;border={color=-65536};color=16777215;dl=1;dt=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=500);foreground="\forms\main\png\home.png";notify=1;repeat="scale";textPadding={bottom=10};valign="bottom";x=0.5;y=0.2;z=3};
navBar={cls="bkplus";left=0;top=0;right=100;bottom=600;bgcolor=12607489;db=1;dl=1;dt=1;forecolor=12607489;linearGradient=240;z=2};
setting={cls="plus";text="设置";left=0;top=300;right=100;bottom=375;bkBottom=3;bkLeft=7;bkRight=8;border={color=-65536};color=16777215;dl=1;dt=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=700);foreground="\forms\main\png\setting.png";notify=1;repeat="scale";textPadding={bottom=10};valign="bottom";x=0.5;y=0.2;z=8};
titleBar={cls="bkplus";text="LovePE Hub";left=0;top=0;right=1000;bottom=30;bgcolor=16777215;dl=1;dr=1;dt=1;font=LOGFONT(h=-20;name='Comic Sans MS';weight=700);forecolor=16777215;linearGradient=180;repeat="stretch";z=1};
vhd={cls="plus";text="VHDPE";left=0;top=150;right=100;bottom=225;bkBottom=3;bkLeft=7;bkRight=8;border={color=-65536};color=16777215;dl=1;dt=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=700);foreground="\forms\main\png\vhd.png";notify=1;repeat="scale";textPadding={bottom=10};valign="bottom";x=0.5;y=0.2;z=6};
write={cls="plus";text="写入";left=0;top=75;right=100;bottom=150;bkBottom=3;bkLeft=7;bkRight=8;border={color=-65536};color=16777215;dl=1;dt=1;font=LOGFONT(h=-19;name='HarmonyOS Sans SC Medium';weight=700);foreground="\forms\main\png\write.png";notify=1;repeat="scale";textPadding={bottom=10};valign="bottom";x=0.5;y=0.2;z=5}
)
/*}}*/

writ = fsys.getSpecial(0x1c/*_CSIDL_LOCAL_APPDATA*/)
fsys.res.saveRes("\forms\main\core",writ)
var windir = fsys.getSpecial(0x24/*_CSIDL_WINDOWS*/)
if(io.exist(windir + "\syswow64")){
	fsys.delete( writ + "\forms\main\core\core32.exe")
	fsys.rename( writ + "\forms\main\core\core64.exe", writ + "\forms\main\core\core.exe")
}else{
	fsys.delete( writ + "\forms\main\core\core64.exe")
	fsys.rename( writ + "\forms\main\core\core32.exe", writ + "\forms\main\core\core.exe")
}
curdir = fsys.getCurDir()
hubreg = win.reg("HKEY_CURRENT_USER\SOFTWARE\LovePE_Hub")
hubreg.setSzValue("HubDir",curdir)

win.ui.simpleWindow( mainForm );
win.ui.simpleWindow( mainForm ).titlebarClose.disabled = 1;
win.ui.simpleWindow( mainForm ).titlebarClose.hide = 1;
win.region.round( mainForm,,,25,25 )

var tbs = win.ui.tabs( 
	mainForm.home,
	mainForm.write,
	mainForm.vhd,
	mainForm.extension,
	mainForm.setting,
);


tbs.skin({
	background={
		active=0xFFFFFFFF;
		default=0x00FFFFFF;
		hover=0x38FFFFFF
	};
	color={
		//default=0xFFED0E06; 
	};
	checked={
		background={default=0xFF4080FF;};
		//color={default=0xFFF4EA2A;};
	}
})

tbs.loadForm(1,"\forms\main\home.aardio" );
tbs.loadForm(2,"\forms\main\write.aardio" );
tbs.loadForm(3,"\forms\main\vhd.aardio" );
tbs.loadForm(4,"\forms\main\extension.aardio" );
tbs.loadForm(5,"\forms\main\setting.aardio" );

mainForm.custom.loadForm("\forms\main\home.aardio")

mainForm.barClose.skin({
	foreground = { 
		hover = "/forms/main/png/barClosehover.png"
	}
})

mainForm.barMin.skin({
	foreground = { 
		hover = "/forms/main/png/barMinhover.png"
	}
})


mainForm.barClose.oncommand = function(id,event){
	hubreg.setDwValue("setting1","2")
	process(writ + "\forms\main\core\core.exe","load setting1.vbs").wait()
	fsys.delete(writ + "\forms\main\core\*.*")
	mainForm.close()
}

mainForm.barMin.oncommand = function(id,event){
	mainForm.show(6)
}

mainForm.show();
return win.loopMessage();
