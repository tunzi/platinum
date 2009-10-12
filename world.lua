-- This needs to define a world object of some kind, 
-- Preferrably it is a list of vectors, this is to be completed
-- The list of vectors would then be traversed to attach a collision type
-- for platforms/walls/slopes

-- 

-- World Object List

w = {

   lines = {
   -- A horizontal line
   {0, 0, 10, 0},
   -- A vertical line
   {10, 0, 10, 10}, 
},


   draw = function(s) 
	     for i,line in ipairs(s.lines) do
		love.graphics.line(draw_X(line[1]) ,draw_Y(line[2]),
				   draw_X(line[3]) ,draw_Y(line[4]))
	     end
	  end,
}

-- These filter the w.lines into the 3 primary collision types
function get_walls()
end

function get_platforms()
end

function get_slopes()
end

w.walls = get_walls()
w.platforms = get_platforms()
w.slopes = get_slopes()