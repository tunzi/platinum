-- This needs to define a world object of some kind, 
-- Preferrably it is a list of vectors, this is to be completed
-- The list of vectors would then be traversed to attach a collision type
-- for platforms/walls/slopes

-- 

-- World Object List

w = {

   lines = {
   -- A horizontal line
   {10.0, 5.0, 20.0, 5.0},
   -- A vertical line
   {10.0, 5.0, 10.0, 20.0}, 
   {10.0, 20.0, 20.0, 20.0},
   {20.0, 5.0, 20.0, 20.0},

   -- A sloped line
   {20.0, 20.0, 22.0, 22.0},
   -- continued...
   {22.0, 22.0, 30.0, 23.0},
   {30.0, 23.0, 35.0, 20.0},
   {35.0, 20.0, 50.0, 20.0},
},

g = -100, -- gravity

   draw = function(s) 
	     for i,line in ipairs(s.lines) do
		love.graphics.line(draw_X(line[1]) ,draw_Y(line[2]),
				   draw_X(line[3]) ,draw_Y(line[4]))
	     end
	  end,
}

-- These filter the w.lines into the 3 primary collision types
-- THESE NEED TO ADD LOGIC FOR "NORMALIZING" THE ORDER OF THE
-- COORDINATES
function get_walls(lines)
   result = {}
   for i, w in ipairs(lines) do
      -- If the X of both points is the same
      if w[1] == w[3] then
	 table.insert(result, w)
      end
   end
   return result
end

function get_platforms(lines)
   result = {}
   for i, w in ipairs(lines) do
      -- If the Y of both points is the same
      if w[2] == w[4] then
	 table.insert(result, w)
      end
   end
   return result
end

function get_slopes(lines)
   result = {}
   for i, w in ipairs(lines) do
      -- If the X and Y of both points are different
      if (not (w[1] == w[3])) and (not (w[2] == w[4])) then
	 table.insert(result, w)
      end
   end
   return result
end

w.walls = get_walls(w.lines)
w.platforms = get_platforms(w.lines)
w.slopes = get_slopes(w.lines)