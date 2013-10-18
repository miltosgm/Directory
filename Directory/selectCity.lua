-----------------------------------------------------------------------------------------
--
-- selectCity.lua
--
-----------------------------------------------------------------------------------------

-- global button import only once from the beginning
--require "init_buttons"
--------------------------------------------
local appdata = require( "appdata" )
local widget = require( "widgetLibrary.widget" )
local ui = require( "ui" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local pickerWheel
local background







-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
    
    
    
    print(  "selectcity  TextureMemory: " .. AddCommas( system.getInfo("textureMemoryUsed"), 9 ) .. " bytes" )
    
    
    
---------------DISPLAY BACKGROUND IMAGE
    background = display.newImageRect( "background1.png", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    
    
    
    
    
    local start =  1;
    
    
--------------CREATES THE PICKERWHEEL
    
    local columnData = 
    { 
        { 
            align = "center",
            startIndex = start,
            labels = 
            {"Nicosia", "Limasol", "Larnaka", "Pafos", "Ammochostos"},
        }
    }
    
    
    pickerWheel = widget.newPickerWheel
    {
        top = display.contentHeight - 422,  
        left = 0,
        font = "Helvetica-Bold",
        totalWidth = 200 ,
        theme = "widget_theme_ios",
        columns = columnData
    }
    
-------------FUNCTION OF PICKER WHEEL
    local touched = function ( event )
        if event.phase == "release" then
            local values = pickerWheel:getValues()
           --  storyboard.gotoScene( "search", "slideRight", 500 )
             appdata.G_cityname = values[1].value
             appdata.G_cityIndex = values[1].index
           
               storyboard.gotoScene( "search"  )
           
           -- director:changeScene({city = values[1].value , cityindex = values[1].index  } , "search", "moveFromLeft" )
        end
    end
    
------------END OF PICKER WHEEL



--------CREATE NEW BUTTON

    
    local btOK = ui.newButton{
        default = "btnBlueMedium.png",
        over = "btnBlueMediumOver.png",
        onEvent = touched,
        id = "OK"
        
    }
    
    btOK.x = 160
    btOK.y = 330
    
    btOK:setText("OK")

---------END OF NEW BUTTON



    -- all display objects must be inserted into group
      group:insert( background )
      group:insert( btOK )
      group:insert( pickerWheel )
    print(  "selectcity  TextureMemory: " .. AddCommas( system.getInfo("textureMemoryUsed"), 9 ) .. " bytes" )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
    -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
    
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
    --background:removeSelf()
    --background = nill
    
   -- pickerWheel:removeSelf()
  --  pickerWheel = nill
    
    
    collectgarbage("collect")
    collectgarbage("collect")
    collectgarbage("collect")
    print(  "selectcity splash  TextureMemory: " .. AddCommas( system.getInfo("textureMemoryUsed"), 9 ) .. " bytes" )
    
    -- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
    local group = self.view
    
    
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene
