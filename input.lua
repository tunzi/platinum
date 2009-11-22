-- Input conditionals
-- ALTERS global game data as necessary

isDown = love.keyboard.isDown

function input()	 
   if isDown(love.key_x) then
      love.system.exit()
   end

   if not (isDown(love.key_d) or isDown(love.key_a)) then
      p.v_x = 0
   end

-- FFFFFF just wasted 20 minutes because of this...
--   if not (isDown(love.key_s) or isDown(love.key_w)) then
--      p.v_y = 0
--   end

   if isDown(love.key_left) then
      p.v_x = -100
      p.heading = p.left
   end

   if isDown(love.key_right) then
      p.v_x = 100
      p.heading = p.right
   end

   if isDown(love.key_d) then
      p.v_x = 10
      p.heading = p.right
   end

   if isDown(love.key_a) then
      p.v_x = -10
      p.heading = p.left
   end

   if isDown(love.key_w) then
      p.v_y = 10
   end

   if isDown(love.key_s) then
      p.v_y = -10
   end

   if isDown(love.key_a) and isDown(love.key_d) then
      p.v_x = 0
   end

   if isDown(love.key_space) 
   and (p.collided_w or p.collided_p or p.collided_s) then
      message = "space"
      p.v_y = 30
   end


end