-- This needs to define a world object of some kind, 

-- The world object is built from a world file in resources

-- 

-- World Object List
w = {}
w.g = -100 -- gravity
w.screen_width = 80
w.screen_height = w.screen_width*3/4
   -- Draw all collidable lines
w.draw = function(s) 
	    for j,path in pairs(s.active.paths) do
	       for i, point in pairs(path) do
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
w.draw = function(s) 

	    for i,line in pairs(s.active.walls) do
	       love.graphics.line(draw_X(line[1]), draw_Y(line[2]), 
				  draw_X(line[3]), draw_Y(line[4]))
	    end
	    for i,line in pairs(s.active.platforms) do
	       love.graphics.line(draw_X(line[1]), draw_Y(line[2]), 
				  draw_X(line[3]), draw_Y(line[4]))
	    end
	    for i,line in pairs(s.active.slopes) do
	       love.graphics.setColor(255,255,255)
	       love.graphics.line(draw_X(line[1]), draw_Y(line[2]), 
				  draw_X(line[3]), draw_Y(line[4]))
	       love.graphics.setColor(200,0,0)
	       love.graphics.quad(love.draw_line,
				  draw_X(line[1]),
				  draw_Y(line[2]),
				  draw_X(line[3]),
				  draw_Y(line[4]),
				  draw_X(line[3]),
				  draw_Y(0),
				  draw_X(line[1]),
				  draw_Y(0))
	    end

	 end


-- Return only paths between x1,x2 (+ 1 outside)
function get_paths(paths, x1, x2)
   result = {}
   for j, path in ipairs(paths) do
      for i, point in ipairs(path) do
	 if not (i==1) then -- skip first one
	    last_point = path[i-1]
	    if between_X(point,x1,x2) or between_X(last_point,x1,x2) then
	       table.insert(result, {last_point[1], last_point[2], 
				     point[1], point[2]})
	    end
	 end
      end
   end
   return result
end


-- These filter the w.lines into the 3 primary collision types
-- @TODO Add a parameter to only get within a certain range (+ 1)
-- This way we can segregate these collidables and make one subset active
-- @TODO normalize so first point is lower left and second is upper right, etc.
function get_walls(paths, x1, x2)
   result = {}
   for j, path in ipairs(paths) do
      for i, point in ipairs(path) do
	 if not (i==1) then -- skip first one
	    last_point = path[i-1]
	    if between_X(point,x1,x2) or between_X(last_point,x1,x2) then
	       if point[1] == last_point[1] then  -- if x coord is same
		  table.insert(result, {last_point[1], last_point[2], 
					point[1], point[2]})
	       end
	    end
	 end
      end
   end
   return result
end

function get_platforms(paths, x1, x2)
   result = {}
   for j, path in ipairs(paths) do
      for i, point in ipairs(path) do
	 if not (i==1) then -- skip first one
	    last_point = path[i-1]
	    if between_X(point,x1,x2) or between_X(last_point,x1,x2) then
	       if point[2] == last_point[2] then  -- if y coord is same
		  table.insert(result, {last_point[1], last_point[2], 
					point[1], point[2]})
	       end
	    end
	 end
      end
   end
   return result
end

function get_slopes(paths, x1, x2)
   result = {}
   for j, path in ipairs(paths) do
      for i, point in ipairs(path) do
	 if not (i==1) then -- skip first one
	    last_point = path[i-1]
	    if between_X(point,x1,x2) or between_X(last_point,x1,x2) then
	       if not (point[1] == last_point[1])  -- if x and y are different
	       and not (point[2] == last_point[2]) then
	       table.insert(result, {last_point[1], last_point[2], 
				     point[1], point[2]})
	    end
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
   s.width = world_data.width
   s.height = 100
   s.segments = {} -- Split collision surfaces between segments, 
                   -- of which only one is active
   
   -- Create the collide surfaces
   num_segments = s.width/s.screen_width * 2 + 1 -- number of segments
   seg_width = 1 -- length of one segment in double screen widths
   for i=0,num_segments do
      s.segments[i+1] = {} -- New segment
      seg_left = (i/2.0-seg_width)*s.screen_width
      seg_right =  (i/2.0+seg_width)*s.screen_width
      s.segments[i+1].paths = get_paths(s.paths, seg_left, seg_right)
      s.segments[i+1].walls = get_walls(s.paths, seg_left, seg_right)
      s.segments[i+1].platforms =  get_platforms(s.paths, seg_left, seg_right)
      s.segments[i+1].slopes = get_slopes(s.paths, seg_left, seg_right)

   end
   -- Set active segment
   active_segment_index = math.floor(p.x/w.screen_width*2 + 1)
   s.active = s.segments[active_segment_index]
end

-- Check to see if a point is between two X coordinates
function between_X(point, x1, x2)
   return (x1 < point[1]) and (point[1] < x2)
end

-- Get width of the world based on path data
function get_width()
   return
end