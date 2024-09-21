APP_Path = app:info('path')
UI_Path = sui:info('uipath')
dofile(UI_Path .. 'utils.lua')
dofile(UI_Path .. 'nav.lua')
dofile(UI_Path .. 'page.lua')
dofile(UI_Path .. 'dl.lua')
dofile(UI_Path .. 'openfile.lua')
dofile(UI_Path .. 'ntboot.lua')
function onload()
  UI_Inited = 0
  Nav:Init()
  dl_onload()
  openfile_onload()
  ntboot_onload()
  UI_Inited = 1
end



function onclick(ctrl)
   app:print('onclick:' .. ctrl)
   dl_onclick(ctrl)
   if Nav:OnTabClick(ctrl) then return end
end



