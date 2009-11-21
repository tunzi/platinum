-- Handle collision detection between Player Box
-- and game world platforms or walls

-- Collide functions return either FALSE or the distance for collision

-- One cavet is that these functions will move body so that
-- it is perfectly aligned with what it hits

-- Also note the necessity of >= instead of > for edge cases

-- IDEA: ADD state variable to test MAINTAINED collision within these
-- does this require "closures"?

Z = .01 -- collision tolerance

---- PLATFORMS ----
function collide_bottom(body, bottom)
   if body.v_y > 0 then return false end
   if not (body:R() <= bottom[1]) and
      not (body:L() >= bottom[3]) and
      (bottom[2] >= body:B()) and 
      (body:B() >= body.dy + bottom[2]) then -- dy is NEGATIVE!!!!
      return body.y - bottom[2]
   end
   return false
end

function collide_top(body, top)
   if body.v_y < 0 then return false end
   if not (body:R() <= top[1]) and
      not (body:L() >= top[3]) and
      (top[2] <= body:T()) and 
      (body:T() <= (top[2] + body.dy)) then
      return body.y + body.height - top[2]
   end
   return false
end


function collide_platforms(body, platforms)
   for i,plat in ipairs(platforms)  do
      if collide_bottom(body, plat) then 
	 return collide_bottom(body,plat) 
      end
      if collide_top(body, plat) then
	 return collide_top(body,plat)
      end
   end
   return false
end

---- WALLS ----
function collide_left(body, wall)
   if body.v_x > 0 then return false end
-- probably need a get-top, get-bottom for walls, etc....
   if not (body:T() <= wall[2]) and
      not (body:B() >= wall[4]) and
      (wall[1] >= body:L()) and 
      (body:L() >= (wall[1] + body.dx)) then -- dx is NEGATIVE!!!!
      return wall[1] + body.width/2 - body.x
   end
   return false
end


function collide_right(body, wall)
   if body.v_x < 0 then return false end
   if not (body:T() <= wall[2]) and
      not (body:B() >= wall[4]) and
      (wall[1] <= body:R()) and 
      (body:R() <= (wall[1] + body.dx)) then
      return wall[1] - body.width/2 - body.x
   end
   return false
end


function collide_walls(body, walls)
   for i,wall in ipairs(walls)     do
      if collide_left(body, wall)  then
	 return collide_left(body, wall)
      end
      if collide_right(body, wall) then
	 return collide_right(body, wall)
      end
   end
   return false
end

---- SLOPES ----
function collide_slope(body, slope)
--   if body.v_y > 0 then return false end
   m = (slope[4]-slope[2])/(slope[3]-slope[1]) -- (y2-y1)/(x2-x1)
   b = slope[2] + m*(body.x-slope[1]) -- y value of the slope
   if not (body.x < slope[1])   and
      not (body.x > slope[3])   and
      (b >= body:B())              and   -- v safety factor
      (body:B() >= (b + -math.abs(p.dy) - 1.5*math.abs(p.dx))) then
      return body.y-b
  end
  return false
end

function collide_slopes(body, slopes)
   for i,slope in ipairs(slopes)  do
      if collide_slope(body, slope) then
	 return collide_slope(body, slope)
      end
   end
end