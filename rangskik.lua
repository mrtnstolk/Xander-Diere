---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

local speech = {"Puik.", "Fantasties.", "Jy is 'n slimkop.", "Mooi so."}
local dialog = {}
local speechtext = {}

local instructionsset = {"Rangskik die diere van groot na klein.","Rangskik die diere van klein na groot"}

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

local images = {}
local shadow = {}

local animals = {1,2,3,4,5}
local markX
local kleinnagroot =  (math.random(1, 10) > 5)

local instruction = instructionsset[(kleinnagroot and 1 or 0)+1]

local levels = {"match", "matchcol", "patrone", "rangskik"}

math.randomseed( os.time() )

local function shuffleTable( t )
    local rand = math.random 
    assert( t, "shuffleTable() expected a table, got nil" )
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end

---------------------------------------------------------------------------------

local nextSceneButton
function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

local function recalibrate()

local animaltemp = {}
local min = {}

for ii=1,#animals,1 do

for x=1,#animals,1 do
	if table.contains(animaltemp,images[x].tag) then
	else
		min = images[x]
		break
	end
end

	for i=1,#animals,1 do
		if images[i].x < min.x then
			if table.contains(animaltemp,images[i].tag) then
			else
			min = images[i]
			end
		end
	end
	animaltemp[ii] = min.tag
	
end

animals = animaltemp

local margin = display.contentWidth*0.10
        local position = display.contentWidth*0.2
        print("----------")
        for i=1,#animals do
        	--We need to move 
        	for y=1,#animals do
        	if (images[y].tag == animals[i]) then
				transition.to( images[y], { time=500, x=margin + position*(i-1) } )
				end
			end
		end
		
		--Check tint
		for i=1,#animals do
			if shadow[i].tag == animals[i] then
				shadow[i]:setFillColor( 0, 0.9, 0 )
				else
				shadow[i]:setFillColor( 0, 0, 0 )
				end
				
		end

end

local function NextLv(event)
 math.randomseed( os.time() )
					local n = math.random(#levels)
 composer.gotoScene( levels[n], { effect = "fade", time = 300 } )
 imgx:removeSelf()
 imgx = nil
 
 dialog:removeSelf()
 dialog = nil
 
 speechtext:removeSelf()
 speechtext = nil
end

local function CheckComplete()
local correct = true
for i=2,#animals,1 do

if kleinnagroot == true then
	if animals[i-1] > animals[i] then
		correct = false
	end
	else
	if animals[i-1] < animals[i] then
		correct = false
	end
	end
end

if correct then
math.randomseed( os.time() )
					local n = math.random(#levels)
					
for i=1,#animals do
shadow[i]:removeSelf()
shadow[i] = nil
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
end
end

local function move( event )
    if event.phase == "began" then
		
        event.target.markX = event.target.x    -- store x location of object
        
        display.getCurrentStage():setFocus( event.target, event.id )
		event.target.isFocus = true

	elseif event.target.isFocus then
	
    	if event.phase == "moved" then
	
        	local x = (event.x - event.xStart) + event.target.markX
        
        	event.target.x = x    -- move object based on calculations above
    	elseif event.phase == "ended" or event.phase == "cancelled"  then
             
              -- here the focus is removed from the last position
                    display.getCurrentStage():setFocus( nil )
                    event.target.isFocus = false
                    recalibrate()
                    CheckComplete()
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
        shuffleTable(animals)
        
        local margin = display.contentWidth*0.10
        local position = display.contentWidth*0.2
        
        local rand = math.random(5)
        
        for i=1,#animals do
        shadow[i] = display.newImage("shadow.png")
        if kleinnagroot == false then
        x = #animals+1 - i
        else
        x = i
        end
        
        shadow[i]:scale(x/15,x/15)
        shadow[i].x = margin + position*(i-1)
        shadow[i].y = display.contentHeight/2 + display.contentHeight/4
        shadow[i].tag = x
        end
        
        for i=1,#animals do
        images[i] = display.newImage(rand .. ".png")
        images[i]:scale(animals[i]/40,animals[i]/40)
        images[i].x = margin + position*(i-1)
        images[i].y = display.contentHeight/2
        images[i].tag = animals[i]
        images[i]:addEventListener( "touch", move )
        end       
        
        for i=1,#animals do
			if shadow[i].tag == animals[i] then
				shadow[i]:setFillColor( 0, 0.9, 0 )
				else
				shadow[i]:setFillColor( 0, 0, 0 )
				end
				
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
        
    for i=1,#images,1 do
    images[i]:removeSelf()
    end
        
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
--[[
Rectangle = {area = 0, length = 0, breadth = 0}

function Rectangle:new (o,length,breadth)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.length = length or 0
  self.breadth = breadth or 0
  self.area = length*breadth;
  return o
end

-- Derived class method printArea
function Rectangle:printArea ()
  print("The area of Rectangle is ",self.area)
end --]]


return scene
