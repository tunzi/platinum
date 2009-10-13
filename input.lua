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

   if not (isDown(love.key_s) or isDown(love.key_w)) then
      p.v_y = 0
   end

   if isDown(love.key_d) then
      p.v_x = 10
   end

   if isDown(love.key_a) then
      p.v_x = -10
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

end