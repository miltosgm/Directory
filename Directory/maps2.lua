

local appdata = require( "appdata" )
local widget = require( "widgetLibrary.widget" )
local ui = require("ui")

    local storyboard = require( "storyboard" )
    local scene = storyboard.newScene()
     
   
    -- Called when the scene's view does not exist:
    function scene:createScene( event )
    local group = self.view
    
    end
     
    -- Called immediately after scene has moved onscreen:
    function scene:enterScene( event )
    local group = self.view
     
     local background = display.newImage( "background1.png" , display.contentWidth, display.contentHeight)
  
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
     
     
    local locationNumber = 1 -- a counter to display on location labels
     
    
    

     local name = display.newText( "Name:" .. appdata.variable1, 20, 350, "Helvetica", 13 )
     
     name:setTextColor(255, 255, 255 )
        
     
        
        local address = display.newText("Address:" .. appdata.variable2, 20, 370, "Helvetica", 11 )
       
        address:setTextColor(204, 204, 0 )
        
        local number = display.newText( "Phone:" .. appdata.variable3, 20, 390, "Helvetica", 11 )
       
        number:setTextColor(0, 255, 0 )
        
     
    ---------------------------
     

     
     
     
     local myMap = native.newMapView( 20, 20, 300, 220 )
      
if myMap then
	-- Display a normal map with vector drawings of the streets.
	-- Other mapType options are "satellite" and "hybrid".
        
        
        myMap.mapType = "normal"
        currentLocation = myMap:getUserLocation()
        currentLatitude = currentLocation.latitude
	currentLongitude = currentLocation.longitude
        
       
        
	-- The MapView is just another Corona display object and can be moved, resized, etc.
	myMap.x = display.contentWidth / 2
	myMap.y = 180

	-- Initialize map to a real location, since default location (0,0) is not very interesting
        myMap:setCenter( currentLatitude, currentLongitude)
       
end
   
   

local mapLocationHandler = function( event )
	if event.isError then
		-- Location name not found.
		native.showAlert( "Error", event.errorMessage, { "OK" } )
	else
		-- Move map so this location is at the center
		-- (The final parameter toggles map animation, which may not be visible if moving a large distance)
		myMap:setCenter( event.latitude, event.longitude, true )

		-- Add a pin to the map at the new location
		markerTitle = "Location " .. locationNumber
		locationNumber = locationNumber + 1
		myMap:addMarker( event.latitude, event.longitude, { title=markerTitle, subtitle=appdata.variable2 } )
               
        end
end



    local handleButtonEventMap = function( event )
	-- This finds the location of the submitted string.
	-- Valid strings include addresses, intersections, and landmarks like "Golden Gate Bridge", "Eiffel Tower" or "Buckingham Palace".
	-- The result is returned in a "mapLocation" event, handled above).
        
        
        if myMap then
                 
		myMap:requestLocation( appdata.variable2, mapLocationHandler )
                
	end
end 





  local handleButtonEventSMS = function( event )

local options =
{
to = { appdata.variable3 },
body = ""
}
native.showPopup("sms", options)

end


 

local function onComplete( event )
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then
                -- Do nothing; dialog will simply dismiss
        elseif 2 == i then
                -- Open URL if "OK" (the 2nd button) was clicked
                system.openURL( "tel:".. appdata.variable3)
        end
    end
end



local handleButtonEventPhone = function(event)
    local alert = native.showAlert( "Call Forwarding", "You're making a call.", { "Cancel","OK" }, onComplete )
    
end



 


     --BACK BUTTON
     
     
local function backBtnRelease( event )
     
        
       myMap.alpha = 0
     
      
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
    
    
  





     
     
          local myButtonMap = widget.newButton
{

left=50,
top=420,

defaultFile = "map_icon.png",
id="button_map",
label=" ",
onRelease = handleButtonEventMap,


}
    
    
  local myButtonPhone = widget.newButton
{

left=120,
top=420,

defaultFile = "phone_icon.png",
id="button_phone",
label=" ",
onRelease = handleButtonEventPhone,


}  
     
     
     
     
     
      local myButtonSMS = widget.newButton
{

left=190,
top=420,

defaultFile = "sms_icon.png",
id="button_sms",
label=" ",
onRelease = handleButtonEventSMS,


}  
     

   
     
     
     
  
    group:insert( background )
    group:insert( navBar )
    group:insert( navHeader )
    group:insert( backBtn )
    group:insert(myButtonMap)
     group:insert(myButtonPhone)
     group:insert(myButtonSMS)
     group:insert(myMap)
      group:insert(name)
      group:insert(address)
      group:insert(number)
    
     
    
    end
     
    -- Called when scene is about to move offscreen:
    function scene:exitScene( event )
    local group = self.view
    
   
    
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