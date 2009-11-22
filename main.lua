--Globals

-- These functions account for the descrepancy between 'drawing
-- coordinates' (pixels) and 'physical coordinates' (meters/units)c
function draw_X(x) 
   return (x-V[1])*love.graphics.getWidth()/w.width 
end
function draw_Y(y) 
   return (1 - (y-V[2])/w.height) * love.graphics.getHeight()
end


-- Global Objects
require("player.lua")  -- defines "p", the main player object
require("world.lua")
require("stage1.lua")
w:populate(world_data)

-- Viewport vector (put into seperate "screen.lua" ?)
V = {0,0}

-- Main Procs
require("input.lua")
require("collide.lua")

-- Test
require("test.lua")

function load()
   
   -- Load Resources
   img_walk = love.graphics.newImage("resources/zerowalk.png")
   img_stand = love.graphics.newImage("resources/zerostand.png")
   V[1] = p.x - w.width/2

--   anims.walk = love.graphics.newAnimation(img_walk, 36, 43, 0.1)

--DEBUG
   font = love.graphics.newFont(love.default_font, 12)
   love.graphics.setFont(font)
--   message = "test"

end

function update(dt)


   -- MAIN INPUT LOGIC
   -- This does alter player and world data, careful
   input()
   
--   debug_point(p:T(), p:R())
   p:update(dt)
--   message = "("..p.x..", "..p.y..")"

   
end


function draw()
   --debug message
   love.graphics.draw(message, 100, 100)

   p:draw()
   w:draw()
end 

