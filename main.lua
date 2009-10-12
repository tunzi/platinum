--Globals
Pixels_Per_Unit = 10
Units_Per_Pixel = 1/Pixels_Per_Unit

-- These functions account for the descrepancy between 'drawing
-- coordinates' (pixels) and 'physical coordinates' (meters/units)c
function draw_X(x) return x*Pixels_Per_Unit end
function draw_Y(y) return love.graphics.getHeight() - y*Pixels_Per_Unit end


-- Global Objects
require("box.lua")
require("player.lua")  -- defines "p", the main player object

-- Main Procs
require("input.lua")
require("collide.lua")

-- Test
require("test.lua")

function load()
--DEBUG
   font = love.graphics.newFont(love.default_font, 12)
   love.graphics.setFont(font)
--   message = "test"

end

function update(dt)


   -- MAIN INPUT LOGIC
   -- This does alter player and world data, careful
   input()

   p:update(dt)

   --p.collidewall()

end


function draw()
   --debug message
   love.graphics.draw(message, 100, 100)

   p:draw()
end 

