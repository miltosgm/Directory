-----------------------------------------------------------------------------------------
--
-- settings.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local appdata = require( "appdata" )
local ui = require("ui")
-- include Corona's "widget" library
 -- local widget = require "widgetLibrary.widget"

--------------------------------------------
local citySelect
local surnameTxt
local nameTxt
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
    
   
    
      print(  "search TextureMemory: " .. AddCommas( system.getInfo("textureMemoryUsed"), 9 ) .. " bytes" )
    
    -- display a background image
    local background = display.newImageRect( "background1.png", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    
    function backBtnRelease( event )
        --director:changeScene( "search", "moveFromLeft" )
        storyboard.gotoScene( "menu", "slideRight", 500 )
    end
    
    
    local navBar = ui.newButton{
        default = "TitleBar_Black.png"
	--onRelease = scrollToTop
    }
    navBar.x = display.contentWidth*.5
    navBar.y = math.floor(display.screenOriginY + navBar.height*0.5)
    
    local navHeader = display.newText("Directory", 0, 0, native.systemFontBold, 16)
    navHeader:setTextColor(255, 255, 255)
    navHeader.x = display.contentWidth*.5
    navHeader.y = navBar.y
    local backBtn = ui.newButton{ 
        default = "backButton.png", 
        over = "backButton_over.png", 
        onRelease = backBtnRelease
    }
    backBtn.x =  math.floor(backBtn.width/2)  
    backBtn.y = navBar.y 
    
    
    local btSelectCity = function ( event )
        if event.phase == "release" then
            --director:openPopUp( "selectCity", popClosed )
          --  director:changeScene( "selectCity", "moveFromRight" )
             -- storyboard.gotoScene( "selectCity", "slideLeft", 500 )
             storyboard.gotoScene( "selectCity" )
             
        end
    end
    
    
    
    
    local city = display.newText( "City :", 38, 75, "Helvetica", 16 )
    
    city:setTextColor( 155,255,255 )
    
    citySelect = ui.newButton{
        default = "searchbtn.png",
        over = "searchbtnOver.png",
        onEvent = btSelectCity,
        id = "citySelect"
        
    }
    
    citySelect.x =  205
    citySelect.y = 75
    
   
    
    
    
    -- name
    local nameLbl = display.newText( "Name :", 38, 110, "Helvetica", 16 )
    --nameTxt = native.newTextField( 115, 100, 180, 30 )
    nameLbl:setTextColor( 155,255,255 )
    
    -- surname
    local surnameLbl = display.newText( "Surname :", 38, 145, "Helvetica", 16 )
    -- surnameTxt = native.newTextField( 115, 135, 180, 30 )
    surnameLbl:setTextColor( 155,255,255 )
    
     
    
    local btCallt = function ( event )
        if event.phase == "release" then
            -- director:changeScene( "getData", "moveFromRight" )
            --  local alert = native.showAlert( "Corona", "Dream. Build. Ship.", { "OK", "Learn More" }, onComplete )
            storyboard.gotoScene( "getData", "slideLeft", 500 )
            -- system.openURL("tel:99482949")
        end
    end
    
    
    
    local btOK = ui.newButton{
        default = "btnBlueMedium.png",
        over = "btnBlueMediumOver.png",
        id = "OK",
        onEvent = btCallt,
        
    }
    
    btOK.x =  160
    btOK.y = 330
    
    btOK:setText("OK")
    
    
    
    -- all display objects must be inserted into group
    group:insert( background )
    group:insert( navBar )
    group:insert( navHeader )
    group:insert( backBtn )
    
    group:insert( city )
    group:insert( citySelect )
    
    group:insert( nameLbl )
  
    
    group:insert( surnameLbl )
  
    
    group:insert( btOK )
    
    print(  " TextureMemory: " .. AddCommas( system.getInfo("textureMemoryUsed"), 9 ) .. " bytes" )
    
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
    
    
    ------onName function hides the keyboard.
     local function onName( event )
    -- Hide keyboard when the user clicks "Return" in this field
    if ( "submitted" == event.phase ) then
        native.setKeyboardFocus( nil )
    end
end
    
    -------onSurname function hides the keyboard.
      local function onSurname( event )
    -- Hide keyboard when the user clicks "Return" in this field
    if ( "submitted" == event.phase ) then
        native.setKeyboardFocus( nil )
    end
end  
    
    ---------appdata is global
     citySelect:setText(  appdata.G_cityname )
     nameTxt = native.newTextField( 115, 100, 180, 30, onName )
     surnameTxt = native.newTextField( 115, 135, 180, 30, onSurname )
     
    
     
     
      group:insert( nameTxt )
      group:insert( surnameTxt )
    
    -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
    ---REMOVES nameTxt,surnameTxt from screen
       nameTxt:removeSelf()
       surnameTxt:removeSelf()
    
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