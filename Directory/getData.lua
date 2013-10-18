-----------------------------------------------------------------------------------------
--
-- play.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local appdata = require( "appdata" )
local ui=require("ui")
local json=require("json")
local widget = require( "widgetLibrary.widget" )


-- include Corona's "widget" library
--local widget = require "widget"

--------------------------------------------



-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight
local myList

local topBoundary = display.screenOriginY + 40
local bottomBoundary = display.screenOriginY + 0	
local data,authorName,authorList
local authorTable={}

  local userTable={}


-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
    
    local list
    local data 
  
    
    -- display a background image
    local background = display.newImageRect( "background1.png", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    
    function backBtnRelease( event )
        --director:changeScene( "search", "moveFromLeft" )
        storyboard.gotoScene( "search", "slideRight", 500 )
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
    
    -------------------------------------------START LOADING
    
    
    
    
    local function rowListener( event )
        local row = event.row
        local background = event.background
        local phase = event.phase
        
        if phase == "press" then
            print( "Pressed row: " .. row.index )
            background:setFillColor( 196, 255, 156, 255 )
            
        elseif phase == "release" or phase == "tap" then
            print( "Tapped and/or Released row: " .. row.index )
            --background:setFillColor( 196, 255, 156, 255 )
            row.reRender = true
            
            --showDetails(row.index)
            -- go to new scene
            
        elseif phase == "swipeLeft" then
            print( "Swiped Left row: " .. row.index )
            --userTable[row.index].showDel = true
            --row.reRender = true
            
    	elseif phase == "swipeRight" then
            print( "Swiped Right row: " .. row.index )
            --userTable[row.index].showDel = false
            --display.remove( row.delButton )
            
        end
        
        
    end -- rowListener
    
    
    local function onRowRender( event )
        local row = event.row
        local rowGroup = event.view
        local idx = row.index or 0
        local color = 0
        
        local name = display.newText( row, userTable[row.index].Name, 0, 0, "Helvetica", 14 )
        name.x = row.x - ( row.contentWidth * 0.5 ) + ( name.contentWidth * 0.5 ) + 8
        name.y = 12
        name:setTextColor(255, 255, 255 )
        
       -- rowGroup.insert(name)
        
        local address = display.newText( row, userTable[row.index].Address, 0, 0, "Helvetica", 12 )
        address.x = row.x - ( row.contentWidth * 0.5 ) + ( address.contentWidth * 0.5 ) + 10
        address.y = 14 + name.height 
        address:setTextColor(204, 204, 0 )
        
        local number = display.newText( row, userTable[row.index].Number, 0, 0, "Helvetica", 12 )
        number.x = row.x - ( row.contentWidth * 0.5 ) + ( number.contentWidth * 0.5 ) + 10
        number.y = 34 + address.height 
        number:setTextColor(0, 255, 0 )
        
        
        
        print("Render ->" .. userTable[row.index].Name)
        
        
    end -- onRowRender
    
    
    local function onRowTouch( event )
        local phase = event.phase
        
        if "release" == phase then
            print( "Touched row:", event.target.index )
           
          
              appdata.variable1 = userTable[event.target.index].Name
        appdata.variable2 = userTable[event.target.index].Address
         appdata.variable3 = userTable[event.target.index].Number
        
       storyboard.gotoScene("maps2") 
          
        end
        
             
           
    end
    
    
    
    
    local function tableViewListener( event )
        local phase = event.phase
        local row = event.target
        
        print( event.phase )
    end
    
    
    
    function networkListener( event )
        if ( event.isError ) then
            native.setActivityIndicator(false)
            print( "Network error!")
            
            
            
            local errText=display.newText("Error in connecting Network!",30,200,nil,18)
            
            
            
            local errText1=display.newText("Please Try again.",80,220,nil,18)
        else
            if ( event.phase == "progress" ) then
                if event.bytesEstimated <= 0 then
                    print( "Download progress: " .. event.bytesTransferred )
                else
                    print( "Download progress: " .. event.bytesTransferred .. " of estimated: " .. event.bytesEstimated )
                end
            elseif ( event.phase == "ended" ) then
                
                native.setActivityIndicator(false)
                print ( "RESPONSE: " .. event.response )
                data=json.decode(event.response)
                for i=1,#data do
                    local user ={Name = data[i].Name ,Address = data[i].Address, Number = data[i].Number}
                    --authorName=data[i].Name
                    print(user.Name)
                    table.insert(userTable,user)
                end
                
                
                list = widget.newTableView
                    {  backgroundColor ={51, 0, 153},
                    left = 7,
                    top = 20+display.statusBarHeight,
                    width = 304, 
                    height = 458,
                    maskFile = "mask304x458.png",
                    listener = tableViewListener,
                    onRowRender = onRowRender,
                    onRowTouch = onRowTouch,
                }
                
                
                group:insert(list)
                
                local isCategory = false
                local rowHeight = 80
                local rowColor = 
                { 
                    default = { 51, 0, 153 },
                }
                local lineColor = { 220, 220, 220 }
                for x = 1, #userTable do
                    list:insertRow {
                        isCategory = isCategory,
                        rowHeight = rowHeight,
                        rowColor = rowColor,
                        lineColor = lineColor,
                    }
                end	
                
            end
        end  
    end
    
    
    local params = {}
    
    -- This tells network.request() that we want the 'began' and 'progress' events...
    params.progress = "download" 
    network.request( "https://www.goldentelemedia.com/televoting/services/directorydata.aspx", "GET", networkListener , params )
    native.setActivityIndicator(true)
    
    
    
    -------------------------------------------END LOADING
    
    
    
    -- all display objects must be inserted into group
    group:insert( background )
    group:insert( navBar )
    group:insert( navHeader )
    group:insert( backBtn )
    -- 
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
    
    -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
    
    
    
    
    
    
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
    
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