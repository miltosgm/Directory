

    local storyboard = require( "storyboard" )
    local scene = storyboard.newScene()
     
   
    -- Called when the scene's view does not exist:
    function scene:createScene( event )
    local group = self.view
    end
     
    -- Called immediately after scene has moved onscreen:
    function scene:enterScene( event )
    local group = self.view
     
    
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