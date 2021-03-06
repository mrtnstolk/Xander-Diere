---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------
local speech = {"Puik.", "Fantasties.", "Jy is 'n slimkop.", "Mooi so."}
local dialog = {}
local speechtext = {}

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

local images = {}
local top = {}
local bottom = {}
local line = {}

local animals = {1,2,3,4,5,6,7}
local markX
local pattern = {}
local n1 = {}
local n2 = {}
local n3 = {}

local levels = {"match", "matchcol", "patrone", "rangskik", "matchpat", "familymatch"}

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

local function choosePattern()
n1 = math.random(5)

repeat
n2 = math.random(5) 
until n1 ~= n2


n3 = math.random(5)

p1 = {n1, n1, n1, n1, n1}
p2 = {n1, n1, n2, n1, n1}
p3 = {n1, n2, n1, n2, n1}
p4 = {n1, n2, n3, n1, n2}
p5 = {n1, n2, n2, n1, n2}
p6 = {n1, n1, n2, n2, n1}
pp = {p1,p2,p3,p4,p5,p6}

pattern = pp[math.random(6)]

--pattern[4] = pattern[1]
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

local function CheckComplete()
local needed = pattern[5]

print(images[needed].x)

	local margin = display.contentWidth*0.10
        local position = display.contentWidth*0.2

if images[needed].x > margin + position*(3-1)*5/3 - margin and
 images[needed].x < margin + position*(3-1)*5/3 + margin and
 images[needed].y > display.contentHeight*2/3-display.contentHeight/6 - margin and
 images[needed].y < display.contentHeight*2/3-display.contentHeight/6 + margin then
 
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
else

for i=1,#images do
print("asdasdasd")
images[i].x = images[i].prevx
images[i].y = images[i].prevy
end
 end
--images[needed].x = margin + position*(3-1)*5/3
  --      images[needed].y = display.contentHeight*2/3-display.contentHeight/6

--if images[needed].y < 100 and images[needed].y > 0 and images[needed].x < 100 and images[needed].x > 0 then
--print("works")
--end
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
    
    choosePattern()
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc        
        local margin = display.contentWidth*0.10
        local position = display.contentWidth*0.2
        
        for i=1,#pattern do
        top[i] = display.newImage(pattern[i] .. ".png")
        top[i].alpha = 0
        top[i]:scale(0.04,0.04)
        top[i].x = margin + position*(i-1)*5/3/2
        top[i].y = display.contentHeight/3-display.contentHeight/6
        top[i].tag = animals[pattern[i]]
        end    
        
        rect = display.newRect(display.contentWidth/2,display.contentHeight/6,display.contentWidth*2,display.contentHeight/3)
        rect:setFillColor( 0.5 )
        
        for i=1,#pattern-1 do
        bottom[i] = display.newImage(pattern[i] .. ".png")
        bottom[i]:scale(0.04,0.04)
        bottom[i].x = margin + position*(i-1)*5/3/2
        bottom[i].y = display.contentHeight*2/3-display.contentHeight/6
        bottom[i].tag = animals[pattern[i]]
        end     
        
        for i=1,#animals,1 do
        images[i] = display.newImage(i .. ".png")
        images[i]:scale(0.04,0.04)
        images[i].x = margin/40 + position*(i-1)
        images[i].y = images[i].contentHeight/2*1.33 --display.contentHeight - display.contentHeight/6
        images[i].tag = animals[i]
        images[i].prevx = images[i].x
        images[i].prevy = images[i].y
        images[i]:addEventListener( "touch", move )
        end
        
        
        --line = display.newLine( -display.contentWidth, display.contentHeight-display.contentHeight/3, display.contentWidth*2, display.contentHeight-display.contentHeight/3 )
        --line.strokeWidth = 4
        --line.stroke.effect = "generator.marchingAnts"
        --line:setStrokeColor(0.81,0,0.435)
        
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
        
        for i=1,#pattern do
        top[i]:removeSelf()
        end    
        
        for i=1,#pattern-1 do
        bottom[i]:removeSelf()
        end  
        
        --line:removeSelf()
        rect:removeSelf()
        
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
