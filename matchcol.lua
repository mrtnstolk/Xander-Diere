---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local speech = {"Puik.", "Fantasties.", "Jy is 'n slimkop.", "Mooi so."}
local dialog = {}
local speechtext = {}

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

---------------------------------------------------------------------------------

local nextSceneButton

local t1 = {image="Icon.png",group=1}
local rects = {}

local cols = {"brown.png", "pink.png", "yellow.png", "blue.png", "white.png"}
--local c1 = display.newRect( 10, 10, 199, 199 )
--c1.group = 1
local images = {}

local levels = {"match", "matchcol", "patrone", "rangskik"}

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function addRect(x,y,w,h,text,group)
rects[#rects+1] = display.newRect(x,y,w,h)
rects[#rects].group = group
rects[#rects].text = display.newText(text,x,y, native.systemFont, 16 )
rects[#rects].text:setFillColor( 1, 0, 0 )
end

local function NextLv(event)
imgx:removeSelf()
imgx = nil

dialog:removeSelf()
 dialog = nil
 
 speechtext:removeSelf()
 speechtext = nil
 
 math.randomseed( os.time() )
					local n = math.random(#levels)
 composer.gotoScene( levels[n], { effect = "fade", time = 300 } )
end

local function hasCollided( obj1, obj2 )
   if ( obj1 == nil ) then  --make sure the first object exists
      return false
   end
   if ( obj2 == nil ) then  --make sure the other object exists
      return false
   end

   local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
   local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
   local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
   local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

   return (left or right) and (up or down)
end

local function move( event )
    if event.phase == "began" then
		
        event.target.markX = event.target.x    -- store x location of object
        event.target.markY = event.target.y
        
        display.getCurrentStage():setFocus( event.target, event.id )
		event.target.isFocus = true

	elseif event.target.isFocus then
	
    	if event.phase == "moved" then
	
        	local x = (event.x - event.xStart) + event.target.markX
        	local y = (event.y - event.yStart) + event.target.markY
        
        	event.target.x = x    -- move object based on calculations above
        	event.target.y = y
    	elseif event.phase == "ended" or event.phase == "cancelled"  then
             
              -- here the focus is removed from the last position
                    display.getCurrentStage():setFocus( nil )
                    event.target.isFocus = false
                    for i=1,#cols,1 do
                    	if hasCollided(event.target,rects[i]) then
                    		if event.target.tag == rects[i].group then
                    			event.target.alpha = 0
                    			local tag = event.target.tag
                    			print(tag)
                    			event.target:removeSelf()
                    			
                    			rects[i].alpha = 0
                    			rects[i].text.alpha = 0
                    			--rects[i]:removeSelf()
                    			rects[i].text:removeSelf()
                    			print(rects[i].group)
                    			if rects[i].group == tag then
                    				images[i] = nil
                    			end
                    			
                    			local dont = false
                    			
                    			for ii=1,#cols,1 do
                    			--print(images[ii].tag)
                    				if images[ii] ~= nil then
                    					dont = true
                    				end
                    			
                    			
                    			end
                    			
                    			if dont == false then
                    			
                    			for ii=1,#cols,1 do
                    			rects[ii]:removeSelf()
                    			rects[ii] = nil
                    			end
                    			
                    			imgx = display.newImage("X1.png")
imgx:scale(0.2,0.2)
imgx.x = display.contentWidth/2
imgx.y = display.contentHeight-imgx.contentHeight/2

dialog = display.newImage("speech.png")
dialog:scale(-0.2,0.1)
dialog.x = display.contentWidth/2 - dialog.contentWidth/2 - imgx.contentWidth/2
dialog.y = display.contentHeight-imgx.contentHeight/2

math.randomseed( os.time() )
local rand = math.random (#speech)

speechtext = display.newText(speech[rand], dialog.x, dialog.y, native.systemFont, 16 )
speechtext.align = "center"
speechtext.x = dialog.x - dialog.contentWidth/10 
speechtext:setFillColor(0,0,0)
                    			
                    			timer.performWithDelay(1000,NextLv)
                    				break
                    			end
                    			
                    		end
                    	end
                    end
    	end
    end
    
    return true
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        addRect(100,100,50,50,"pink","pink.png")
        addRect(300,300,50,50,"brown","brown.png")
        addRect(200,200,50,50,"yellow","yellow.png")
        addRect(100,300,50,50,"blue","blue.png")
        addRect(200,100,50,50,"white","white.png")
        
        local margin = display.contentWidth*0.10
        local position = display.contentWidth*0.2
        
        for i=1,#cols,1 do
        images[i] = display.newImage(cols[i])
        images[i]:scale(0.05,0.05)
        images[i].x = margin + position*(i-1)
        images[i].y = display.contentHeight-display.contentHeight/6
        images[i].tag = cols[i]
        images[i]:addEventListener( "touch", move )
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
		if nextSceneButton then
			nextSceneButton:removeEventListener( "touch", nextSceneButton )
		end
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
