---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Gesture = require("lib_gesture")

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )
local images = {}
local texts = {}
local current = 0

local home = {}
local sound = {}
local voice = {}

Groep = {image = "", text = "", sound = "", speech=""}

function Groep:new (text, image, sound, speech)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.text = text or ""
  self.image = image or ""
  self.sound = sound or "";
  self.speech = speech or ""
  return o
end

local t1 = {text="Skool Visse",image="1.png",sound="Bubbles.mp3",speech="s1r1.mp3"}
local t2 = {text="Kudde Beeste",image="2.png",sound="Cow.mp3",speech="s1r1.mp3"}
local t3 = {text="Swerm Bye",image="3.png",sound="Bee.mp3",speech="s1r1.mp3"}
local t4 = {text="Werpsel Varkies",image="4.png",sound="Pig.mp3",speech="s1r1.mp3"}
local t5 = {text="Trop Skape",image="5.png",sound="Sheep.mp3",speech="s1r1.mp3"}
local t6 = {text="Broeisel Kuikens",image="6.png",sound="Chicks.mp3",speech="s1r1.mp3"}

local animals = {t1,t2,t3,t4,t5,t6}
print(images[1])

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

local function soundplay(event)
if ( event.phase == "began" ) then

        elseif ( event.phase == "moved" ) then
            print( "moved phase" )

        elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
            media.playSound(animals[current].sound)
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
        
        current = #animals
        for i=1, #animals do 
        	images[i] = display.newImage(animals[i].image)
        	images[i].x = display.contentWidth/2 + display.contentWidth*(current-i)
        	images[i].y = display.contentHeight/2
        	images[i]:addEventListener( "touch", soundplay )
        	images[i]:scale(0.1,0.1)
        	sceneGroup:insert(images[i])
        	
        	texts[i] = display.newText( animals[i].text, display.contentWidth/2 + display.contentWidth*(current-i), images[i].y + images[i].contentHeight, native.systemFont, 16 )
        	texts[i].y = texts[i].y - texts[i].contentHeight
        	texts[i].alpha = 0
        	sceneGroup:insert(texts[i])
        	print(texts[i].text)
        end
        
        home = display.newImage("home.png")
        home:scale(0.4,0.4)
        home.y = home.y + home.contentHeight/2
		sound = display.newImage("speaker.png")
		sound:scale(0.4,0.4)
		sound.y = sound.y + sound.contentHeight/2
		sound.x = display.contentWidth - sound.contentWidth
		voice = display.newImage("refresh.png")
		voice:scale(0.4,0.4)
		voice.y = voice.y + voice.contentHeight/2
		voice.x = display.contentWidth
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

local function Update(event)		
	if "began" == event.phase then

	
	elseif "moved" == event.phase then

	
	elseif "ended" == event.phase or "cancelled" == event.phase then
			if Gesture.GestureResult() == "SwipeR" then
			print("right")
			SwipeRight()
			elseif Gesture.GestureResult() == "SwipeL" then
			print("left")
			SwipeLeft()
			end
	end
end

local enterAnimal = function(obj)
for i=1, #images do 
	texts[i].alpha = 0
end

	transition.to(texts[current], {delay = 500, time = 500, alpha = 1, onComplete=media.playSound(animals[current].speech)})
end

function SwipeRight()
if current == #images then
return
end

current = current + 1

for i=1, #images do 
	--transition.to( images[i], { time=500, x=images[i].x+display.contentWidth} )
	transition.to( images[i], { time=500, x=display.contentWidth/2 + display.contentWidth*(current-i), onComplete=enterAnimal} )
	transition.to( texts[i], { time=500, x=display.contentWidth/2 + display.contentWidth*(current-i)} )
        end
end

function SwipeLeft()
if current == 1 then
return
end

current = current - 1

for i=1, #images do 
--x=images[i].x = display.contentWidth/2 + display.contentWidth*(current-i-1)
	--transition.to( images[i], { time=500, x=images[i].x-display.contentWidth} )
	transition.to( images[i], { time=500, x=display.contentWidth/2 + display.contentWidth*(current-i), onComplete=enterAnimal} )
	transition.to( texts[i], { time=500, x=display.contentWidth/2 + display.contentWidth*(current-i)} )
        end
end

Runtime:addEventListener( "touch", Update )

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
