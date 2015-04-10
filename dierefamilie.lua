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

local t1 = {text="Koei",image="fcow.png",sound="s1r1.mp3",speech="s1r1.mp3"} --m,f,c
local t2 = {text="Bees",image="fbull.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t3 = {text="Kalf",image="fcowbaby.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t4 = {text="Hen",image="fchicken.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t5 = {text="Haan",image="frooster.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t6 = {text="Kuiken",image="fchick.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t7 = {text="Ooi",image="fsheepmom.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t8 = {text="Ram",image="fsheepdad.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t9 = {text="Lam",image="fsheepbaby.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t10 = {text="Merrie",image="fhorsemom.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t11 = {text="Hings",image="fhorsedad.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t12 = {text="Vul",image="fhorsebaby.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t13 = {text="Teef",image="fdogmom.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t14 = {text="Reun",image="fdogdad.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t15 = {text="Hondjie",image="fdogbaby.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t16 = {text="Ooi",image="fpigmom.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t17 = {text="Sog",image="fpigdad.png",sound="s1r1.mp3",speech="s1r1.mp3"}
local t18 = {text="Varkie",image="fpigbaby.png",sound="s1r1.mp3",speech="s1r1.mp3"}

local animals = {t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18}
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

local function soundplay(event)
if ( event.phase == "began" ) then

        elseif ( event.phase == "moved" ) then
            print( "moved phase" )

        elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
            media.playSound(animals[current].sound)
        end

    return true
end

local function speechplay(event)
if ( event.phase == "began" ) then

        elseif ( event.phase == "moved" ) then
            print( "moved phase" )

        elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
            media.playSound(animals[current].speech)
        end

    return true
end

local function tohome(event)
if ( event.phase == "began" ) then

        elseif ( event.phase == "moved" ) then
            print( "moved phase" )

        elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
            composer.gotoScene( "scene1", { effect = "fade", time = 300 } )
        end

    return true
end

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
        --shuffleTable(animals)
        
        current = #animals/3 
        local counter = 1
        for i=1, #animals/3 do 
        	images[counter] = display.newImage(animals[counter].image)
        	images[counter].x = display.contentWidth/2 + display.contentWidth*(current-i)
        	images[counter].y = display.contentHeight/2
        	images[counter]:addEventListener( "touch", soundplay )
        	images[counter]:scale(0.05,0.05)
        	sceneGroup:insert(images[counter])
        	
        	texts[counter] = display.newText( animals[counter].text, display.contentWidth/2 + display.contentWidth*(current-i), images[counter].y + images[counter].contentHeight, native.systemFont, 16 )
        	texts[counter].y = texts[counter].y - texts[counter].contentHeight
        	texts[counter].alpha = 0
        	sceneGroup:insert(texts[counter])
        	print(texts[counter].text)
        	
        	images[counter+1] = display.newImage(animals[counter+1].image)
        	images[counter+1].x = (display.contentWidth/2 + display.contentWidth*(current-i))*1.5
        	images[counter+1].y = display.contentHeight/2
        	images[counter+1]:addEventListener( "touch", soundplay )
        	images[counter+1]:scale(0.05,0.05)
        	sceneGroup:insert(images[counter+1])
        	
        	texts[counter+1] = display.newText( animals[counter+1].text, display.contentWidth/2 + display.contentWidth*(current-i), images[counter+1].y + images[counter+1].contentHeight, native.systemFont, 16 )
        	texts[counter+1].y = texts[counter+1].y - texts[counter+1].contentHeight
        	texts[counter+1].alpha = 0
        	sceneGroup:insert(texts[counter+1])
        	print(texts[counter+1].text)
        	
        	images[counter+2] = display.newImage(animals[counter+2].image)
        	images[counter+2].x = (display.contentWidth/2 + display.contentWidth*(current-i))*0.5
        	images[counter+2].y = display.contentHeight/2
        	images[counter+2]:addEventListener( "touch", soundplay )
        	images[counter+2]:scale(0.05,0.05)
        	sceneGroup:insert(images[counter+2]) 
        	
        	texts[counter+2] = display.newText( animals[counter+2].text, display.contentWidth/2 + display.contentWidth*(current-i), images[counter+2].y + images[counter+2].contentHeight, native.systemFont, 16 )
        	texts[counter+2].y = texts[counter+2].y - texts[counter+2].contentHeight
        	texts[counter+2].alpha = 0
        	sceneGroup:insert(texts[counter+2])
        	print(texts[counter+2].text)
        	
        	if (counter < #animals-3) then
        	images[counter].alpha = 0
        	images[counter+1].alpha = 0
        	images[counter+2].alpha = 0
        	end
        	
        	counter = counter+3
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
		voice:addEventListener( "touch", speechplay )
		home:addEventListener( "touch", tohome )
		sound:addEventListener( "touch", soundplay )
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

	transition.to(texts[(current-1)*3+1], {delay = 500, time = 500, alpha = 1, onComplete=media.playSound(animals[current].speech)})
	transition.to(texts[(current-1)*3+2], {delay = 500, time = 500, alpha = 1, onComplete=media.playSound(animals[current].speech)})
	transition.to(texts[(current-1)*3+3], {delay = 500, time = 500, alpha = 1, onComplete=media.playSound(animals[current].speech)})
end 

function SwipeRight()
if current == #images/3 then
return
end

current = current + 1
local counter = 1
for i=1, #images/3 do 
	--transition.to( images[i], { time=500, x=images[i].x+display.contentWidth} )
	transition.to( images[counter], { time=500, x=(display.contentWidth/2 + display.contentWidth*(current-i))*0.5, onComplete=enterAnimal} )
	transition.to( texts[counter], { time=500, x=(display.contentWidth/2 + display.contentWidth*(current-i))*0.5} )
	
	transition.to( images[counter+1], { time=500, x=display.contentWidth/2 + display.contentWidth*(current-i)} )
	transition.to( texts[counter+1], { time=500, x=display.contentWidth/2 + display.contentWidth*(current-i)} )
	
	transition.to( images[counter+2], { time=500, x=(display.contentWidth/2 + display.contentWidth*(current-i))*1.5} )
	transition.to( texts[counter+2], { time=500, x=(display.contentWidth/2 + display.contentWidth*(current-i))*1.5} )
	
	if ((counter+2)/3 ~= current) then
        	images[counter].alpha = 0
        	images[counter+1].alpha = 0
        	images[counter+2].alpha = 0
        	else
        	images[counter].alpha = 1
        	images[counter+1].alpha = 1
        	images[counter+2].alpha = 1
        	end
	
	counter = counter+3
        end
end

function SwipeLeft()
if current == 1 then
return
end

current = current - 1
local counter = 1
for i=1, #images/3 do 
--x=images[i].x = display.contentWidth/2 + display.contentWidth*(current-i-1)
	--transition.to( images[i], { time=500, x=images[i].x-display.contentWidth} )
	transition.to( images[counter], { time=500, x=(display.contentWidth/2 + display.contentWidth*(current-i))*0.5, onComplete=enterAnimal} )
	transition.to( texts[counter], { time=500, x=(display.contentWidth/2 + display.contentWidth*(current-i))*0.5} )
	
	transition.to( images[counter+1], { time=500, x=display.contentWidth/2 + display.contentWidth*(current-i)} )
	transition.to( texts[counter+1], { time=500, x=display.contentWidth/2 + display.contentWidth*(current-i)} )
	
	transition.to( images[counter+2], { time=500, x=(display.contentWidth/2 + display.contentWidth*(current-i))*1.5} )
	transition.to( texts[counter+2], { time=500, x=(display.contentWidth/2 + display.contentWidth*(current-i))*1.5} )
	
	if ((counter+2)/3 ~= current) then
        	images[counter].alpha = 0
        	images[counter+1].alpha = 0
        	images[counter+2].alpha = 0
        	else
        	images[counter].alpha = 1
        	images[counter+1].alpha = 1
        	images[counter+2].alpha = 1
        	end
	
	
	counter = counter+3
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
