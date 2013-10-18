-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widgetLibrary.widget" )
-- include Corona's "widget" library
--local widget = require "widget"

--local radlib = require "radlib"
local ui = require("ui")
local appdata = require( "appdata" )

-------------------------------------------


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
    storyboard.removeScene("splash")
    print(  "Menu  TextureMemory: " .. AddCommas( system.getInfo("textureMemoryUsed"), 9 ) .. " bytes" )
    
    -- display a background image
    local background = display.newImage( "background1.png" , display.contentWidth, display.contentHeight)
    --local background = display.newImageRect( "res/bk_default.png", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    
    
    --------------------Menu BUTTONS FUNCTIONS	
    local bt02t = function ( event )
        if event.phase == "release" then
            local options =
            {
                effect = "slideLeft",
                time = 500,
                params =
                {
                    city = appdata.G_cityname,
                    cityindex =   appdata.G_cityindex
                }
            }
            storyboard.gotoScene( "search", options )
            --storyboard.gotoScene( "menu", "fade", 500 )
            --director:changeScene( "search", "moveFromRight" )
            -- director:changeScene({city = appdata.G_cityname , cityindex =   appdata.G_cityindex } , "search", "moveFromRight" )
        end
    end
    
    
      local btPoliceEvent = function(event)
        storyboard.gotoScene("getData")
    
     end
    
    
    
    ----------------------MENU BUTTONS
    
    local bt02 = ui.newButton{
        default = "btnBlueMedium.png",
        over = "btnBlueMediumOver.png",
        onEvent = bt02t,
        id = "bt02"
    }
    bt02:setText("Find") 
    bt02.x = display.viewableContentWidth/2
    bt02.y = 70
    
    
   
    
    
     local btPolice = widget.newButton{
   
       left = 130,
        top = 150,
        defaultFile = "images/images.png",
        onEvent = btPoliceEvent,
        id = "btPolice1",
        label="Police",
        fontSize=15,
       labelColor={
    default = { 255, 255, 255, 90 },
    over = { 120, 53, 128, 255 },
}
   
    }
    
    
   
    
    
   
    ---------------------- Menu Buttons - End
    
    
    -- all display objects must be inserted into group
    group:insert( background )
    group:insert( bt02 )
    group:insert(btPolice)
    
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
    -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
    
    
    collectgarbage("collect")
    collectgarbage("collect")
    collectgarbage("collect")
    print(  "Menu destroy  TextureMemory: " .. AddCommas( system.getInfo("textureMemoryUsed"), 9 ) .. " bytes" )
    
    
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