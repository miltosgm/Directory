-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------



-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )
 function AddCommas( number, maxPos )
        
        local s = tostring( number )
        local len = string.len( s )
        
        if len > maxPos then
            -- Add comma to the string
            local s2 = string.sub( s, -maxPos )             
            local s1 = string.sub( s, 1, len - maxPos )             
            s = (s1 .. "," .. s2)
        end
        
        maxPos = maxPos - 3             -- next comma position
        
        if maxPos > 0 then
            return AddCommas( s, maxPos )
        else
            return s
        end
        
    end
-- include the Corona "storyboard" module
local storyboard = require "storyboard"
local appdata = require( "appdata" )
appdata.G_cityname = ""
appdata.G_cityindex =  1
-- load menu screen
--storyboard.gotoScene( "menu" )


   print(  " TextureMemory: " .. AddCommas( system.getInfo("textureMemoryUsed"), 9 ) .. " bytes" )

storyboard.gotoScene( "splash" )

