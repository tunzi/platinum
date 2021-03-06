-- TODO:
-- add player class (position, velocity, (animation) state, heading, etc.)

anims = {}
left = -1 
right = 1 -- sprites should face this way by default?
heading = right
v_x=0 --player velocity
v_y=0

function load()
   -- Put this into another file?
	-- Set a font.
	local font = love.graphics.newFont(love.default_font, 10)
	love.graphics.setFont(font)


   -- Load Resources
   img_walk = love.graphics.newImage("zerowalk.png")
   img_stand = love.graphics.newImage("zerostand.png")

   world = love.physics.newWorld(100000, 1000)
   world:setGravity(0, 5)
   ground = love.physics.newBody(world, 0, 0, 0)
   ground_shape = love.physics.newRectangleShape(ground, 400, 500, 600, 10)

   player_b = love.physics.newBody(world, 400, 300)
   player_s = love.physics.newRectangleShape(player_b, 30, 43)
--   player_b:setMassFromShapes()
   
   -- Create animations

   anims.walk = love.graphics.newAnimation(img_walk, 36, 43, 0.1)


end

function update(dt)
   local isDown = love.keyboard.isDown
  
   -- Moving left and right
   v_x,v_y = player_b:getVelocity()
   if love.keyboard.isDown(love.key_right) then
      v_x = 5
      player_b:setVelocity(v_x, v_y)
      heading=right
   end
   if love.keyboard.isDown(love.key_left) then
      v_x = -5
      player_b:setVelocity(v_x, v_y)
      heading=left
   end

   -- Stopping
   if not (love.keyboard.isDown(love.key_left) or 
           love.keyboard.isDown(love.key_right)) then
        player_b:setVelocity(v_x/2, v_y)
   end

   -- Jump
   if isDown(love.key_space) then
      v_y = -20
      player_b:setVelocity(v_x,v_y)
   end

   
--   for i,ani in ipairs(anims) do
--       ani:update(dt)
--   end   
  anims.walk:update(dt)

  -- *10 because velocity is capped at 200m/s so time must be scaled
  world:update(dt*10)

end

function draw()
   x,y = player_b:getPosition()
   love.graphics.draw('Position: ('..x..', '..y..')', 50, 50)
   love.graphics.polygon(love.draw_line, ground_shape:getPoints())

-- player.getActiveAnimation()
-- player.heading
-- player.x
-- player.y
   love.graphics.draw(anims.walk, player_b:getX(), player_b:getY(), 
   				  0, heading, 1)
end

