-- This needs to define a world object of some kind, 

-- The world object is built from a world file in resources

-- 

-- World Object List
w = {}
w.g = -100 -- gravity


   -- Draw all collidable lines
w.draw = function(s) 
	    for j,path in ipairs(s.paths) do
	       for i, point in ipairs(path) do
		  if not (i==1) then
		     last_point = path[i-1]
		     love.graphics.line(draw_X(last_point[1]), 
					draw_Y(last_point[2]),
					draw_X(point[1]), 
					draw_Y(point[2]))
		  end
	       end
	    end
	 end


-- These filter the w.lines into the 3 primary collision types
-- THESE NEED TO ADD LOGIC FOR "NORMALIZING" THE ORDER OF THE
-- COORDINATES
function get_walls(paths)
   result = {}
   for j, path in ipairs(paths) do
      for i, point in ipairs(path) do
	 if not (i==1) then -- skip first one
	    last_point = path[i-1]
	    if point[1] == last_point[1] then  -- if x coord is same
	       table.insert(result, {last_point[1], last_point[2], 
				     point[1], point[2]})
	    end
	 end
      end
   end
   return result
end

function get_platforms(paths)
   result = {}
   for j, path in ipairs(paths) do
      for i, point in ipairs(path) do
	 if not (i==1) then -- skip first one
	    last_point = path[i-1]
	    if point[2] == last_point[2] then  -- if y coord is same
	       table.insert(result, {last_point[1], last_point[2], 
				     point[1], point[2]})
	    end
	 end
      end
   end
   return result
end

function get_slopes(paths)
   result = {}
   for j, path in ipairs(paths) do
      for i, point in ipairs(path) do
	 if not (i==1) then -- skip first one
	    last_point = path[i-1]
	    if not (point[1] == last_point[1])  -- if x and y are different
	    and not (point[2] == last_point[2]) then
	       table.insert(result, {last_point[1], last_point[2], 
				     point[1], point[2]})
	       print "slope"
	    end
	 end
      end
   end   
   return result
end

function w.populate(s, world_data)

   -- paths are currently used to draw lines,
   -- but they are not strictly necessary once processed
   s.paths = world_data.paths

   -- Create the collide surfaces
   s.walls = get_walls(s.paths)
   s.platforms = get_platforms(s.paths)
   s.slopes = get_slopes(s.paths)
end