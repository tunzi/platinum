-- Handle collision detection between Player Box
-- and game world platforms or walls

-- Possibilities:
   --overarching "Collide"
   --collide platforms & collide walls
   --collide alters player data...?

-- Check collide with every object?
   -- Maintain list of active objects?

-- def collide?
   --collide_left?
	--return if heading==left && (see notes)
   --collide_right?
   --etc.

-- The top bottom, right, left collide functions do need
-- to be further constrained (they use infinite lines currently)

-- A further cavet is that these functions will move body so that
-- it is perfectly aligned with what it hits

-- Also note the necessity of >= instead of > for edge cases


-- Bug: get stuck on corners with collide_bottom


function collide_bottom(body, bottom)
   if body.dy >= 0 then return false end
   if not (body:R() <= bottom[1]) and
      not (body:L() >= bottom[3]) and
      (bottom[2] > body:B()) and 
      (body:B() >= (bottom[2] + body.dy)) then -- dy is NEGATIVE!!!!
      body.y = bottom[2]
      return true
   end
end

function collide_top(body, top)
   if body.dy <= 0 then return false end
   if not (body:R() <= top[1]) and
      not (body:L() >= top[3]) and
      (top[2] < body:T()) and 
      (body:T() <= (top[2] + body.dy)) then
      body.y = top[2] - body.height      
      return true
   end
end


function collide_left(body, wall)
   if body.dx > 0 then return false end
-- probably need a get-top, get-bottom for walls, etc....
   if not (body:T() <= wall[2]) and
      not (body:B() >= wall[4]) and
      (wall[1] > body:L()) and 
      (body:L() >= (wall[1] + body.dx)) then -- dx is NEGATIVE!!!!
      body.x = wall[1] + body.width/2
      return true
   end
end


function collide_right(body, wall)
   if body.dx < 0 then return false end
   if not (body:T() <= wall[2]) and
      not (body:B() >= wall[4]) and
      (wall[1] < body:R()) and 
      (body:R() <= (wall[1] + body.dx)) then
      body.x = wall[1] - body.width/2
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


function collide_walls(body, walls)
   for i,wall in ipairs(walls)     do
      if collide_left(body, wall)  or
	 collide_right(body, wall) then
	 return true
      end
   end
end

