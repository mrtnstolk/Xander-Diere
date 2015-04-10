---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

---------------------------------------------------------------------------------

local gameButton
local klankeButton
local familieButton
local versamelnameButton
local NotebookButton
local ns = false

local levels = {"match", "matchcol", "patrone", "rangskik", "matchpat", "familymatch"}

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    ns = false

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
        -- we obtain the object by id from the scene's object hierarchy
        gameButton = self:getObjectByTag("GameBtn")
        klankeButton = self:getObjectByTag("klankeBtn")
        familieButton = self:getObjectByTag("familieBtn")
        versamelnameButton = self:getObjectByTag("versamelnameBtn")
        NotebookButton = self:getObjectByTag("NotebookBtn")
        
        if gameButton then
        	-- touch listener for the button
        	function gameButton:touch ( event )
        		local phase = event.phase
        		if "ended" == phase then
        		if ns == false then
        				ns = true
        			math.randomseed( os.time() )
					local n = math.random(#levels)
        			--composer.gotoScene( levels[n], { effect = "fade", time = 300 } )
        			composer.gotoScene( "patrone", { effect = "fade", time = 300 } )
        			end
        		end
        	end
        	-- add the touch event listener to the button
        	gameButton:addEventListener( "touch", gameButton )
        end
        
        if klankeButton then
        	-- touch listener for the button
        	function klankeButton:touch ( event )
        		local phase = event.phase
        		if "ended" == phase then
        		if ns == false then
        				ns = true
        			composer.gotoScene( "klanke", { effect = "fade", time = 300 } )
        			end
        		end
        	end
        	-- add the touch event listener to the button
        	klankeButton:addEventListener( "touch", klankeButton )
        end
        
        if familieButton then
        	-- touch listener for the button
        	function familieButton:touch ( event )
        		local phase = event.phase
        		if "ended" == phase then
        		if ns == false then
        				ns = true
        			composer.gotoScene( "dierefamilie", { effect = "fade", time = 300 } )
        			end
        		end
        	end
        	-- add the touch event listener to the button
        	familieButton:addEventListener( "touch", familieButton )
        end
        
        if versamelnameButton then
        	-- touch listener for the button
        	function versamelnameButton:touch ( event )
        		local phase = event.phase
        		if "ended" == phase then
        		
        			if ns == false then
        				ns = true
        				composer.gotoScene( "versamelname", { effect = "fade", time = 300 } )
        			end
        		end
        	end
        	-- add the touch event listener to the button
        	versamelnameButton:addEventListener( "touch", versamelnameButton )
        end
        
        if NotebookButton then
        	-- touch listener for the button
        	function NotebookButton:touch ( event )
        		local phase = event.phase
        		if "ended" == phase then
        		if ns == false then
        				ns = true
        			composer.gotoScene( "notebook", { effect = "fade", time = 300 } )
        			end
        		end
        	end
        	-- add the touch event listener to the button
        	NotebookButton:addEventListener( "touch", NotebookButton )
        end
        
        
        
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        -- Called when the scene is now off screen
		--if nextSceneButton then
		--	nextSceneButton:removeEventListener( "touch", nextSceneButton )
		--end
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
