-- Handle collision detection between Player Box
-- and game world platforms or walls

-- Possibilities:
   --overarching "Collide"
   --collide platforms & collide walls
   --collide alters player data...?

-- Check collide with every object?
   -- Maintain list of active objects?

-- One cavet is that these functions will move body so that
-- it is perfectly aligned with what it hits

-- Also note the necessity of >= instead of > for edge cases


-- Bug: get stuck on corners with collide_bottom

-- IDEA: ADD state variable to test MAINTAINED collision within these
-- does this require "closures"?

---- PLATFORMS ----
function collide_bottom(body, bottom)
   if body.v_y > 0 then return false end
   if not (body:R() <= bottom[1]) and
      not (body:L() >= bottom[3]) and
      (bottom[2] >= body:B()) and 
      (body:B() >= (bottom[2] + body.dy)) then -- dy is NEGATIVE!!!!
      body.y = bottom[2]
      return true
   end
end

function collide_top(body, top)
   if body.v_y < 0 then return false end
   if not (body:R() <= top[1]) and
      not (body:L() >= top[3]) and
      (top[2] <= body:T()) and 
      (body:T() <= (top[2] + body.dy)) then
      if not (body.dy == 0) then body.y = top[2] - body.height end
      return true
   end
end


function collide_platforms(body, platforms)
   for i,plat in ipairs(platforms)  do
      if collide_bottom(body, plat) or
	 collide_top(body, plat)    then
	 return true
      end
   end
end

---- WALLS ----
function collide_left(body, wall)
   if body.v_x > 0 then return false end
-- probably need a get-top, get-bottom for walls, etc....
   if not (body:T() <= wall[2]) and
      not (body:B() >= wall[4]) and
      (wall[1] >= body:L()) and 
      (body:L() >= (wall[1] + body.dx)) then -- dx is NEGATIVE!!!!
      body.x = wall[1] + body.width/2
      return true
   end
end


function collide_right(body, wall)
   if body.v_x < 0 then return false end
   if not (body:T() <= wall[2]) and
      not (body:B() >= wall[4]) and
      (wall[1] <= body:R()) and 
      (body:R() <= (wall[1] + body.dx)) then
      body.x = wall[1] - body.width/2
      return true
   end
end


function collide_walls(body, walls)
   for i,wall in ipairs(walls)     do
      if collide_left(body, wall)  or
	 collide_right(body, wall) then
	 return true
      end
   end
end

---- SLOPES ----
function collide_slope(body, slope)
   if body.v_y > 0 then return false end
   m = (slope[4]-slope[2])/(slope[3]-slope[1])
   b = slope[2] + m*(body.x-slope[1]) -- y value of the slope
   if not (body:R() <= slope[1]) and
      not (body:L() >= slope[3])   and
      (b >= body:B())              and
      (body:B() >= (b + p.dy - math.abs(p.dx))) then -- dy is NEGATIVE!!!!
      body.y = b
      return true
  end
end

function collide_slopes(body, slopes)
   for i,slope in ipairs(slopes)  do
      if collide_slope(body, slope) then
	 return true
      end
   end
end