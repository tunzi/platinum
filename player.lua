-- Player
p = {

-- Position (middle?)
x = 10,
y = 50,

-- Size
width = 1.0,
height = 2.0,

-- Velocity
v_x = 1.0,
v_y = -5.0,

-- Change in position
dx = 0.0,
dy = 0.0,

heading = 1, -- moving left or right?
right = 1,
left = -1,

collided_w, -- Currently colliding with wall
collided_p, -- Currently colliding with platform
collided_s, -- Currently colliding with slope

-- Player Rect
-- defined by 4 params:
   --Left  (x coordinate)
   --Right (x coordinate)
   --Top   (y coordinate)
   --Bottom(y coordinate)
    L = function(s) return s.x-s.width/2 end,
    R = function(s) return s.x+s.width/2 end,
    T = function(s) return s.y+s.height end,
    B = function(s) return s.y end,

update = function(s, dt)
	    message = " " -- DEBUG

	    -- Main movement occurs here 
	    -- Order of updating position and colliding is important

	    s.v_y = s.v_y + w.g * dt	    
	    s.v_y = terminal_velocity(s.v_y)
	    s.dy = s.v_y * dt
	    s:move(0, s.dy)

	    s.collided_s = collide_slopes(s, w.slopes)
	    if s.collided_s then
	       s.y = s.y - s.collided_s
	       -- These make you "ramp" if you move fast enough
	       -- HAHA
	       s.dy = floor(s.dy-s.collided_s)
	       s.v_y = floor(s.dy/dt)
	       s.dv_y  = 0
	       message = "slope"
	    end

	    s.collided_p = collide_platforms(s, w.platforms)
	    if s.collided_p then
	       s.y = s.y - s.collided_p
	       s.dy  = 0
	       s.v_y = 0
	       s.dv_y = 0
	       message = "plat"
	    else

	    end

	    -- If all of the position updating and colliding are
	    -- grouped together, it can cause corner catching issues
	    s.dx = s.v_x * dt; 
	    s:move(s.dx, 0)

	    s.collided_w = collide_walls(s, w.walls)
	    if s.collided_w then
	       s.x = s.x + s.collided_w
	       s.v_x = 0
	       s.dx  = 0
	       message = "wall"
	    end

	    -- Move Camera (center on player's X coordinate)
	    V[1] = p.x - love.graphics.getWidth()*Units_Per_Pixel/2

-- update animation
--	    anims.walk:update(dt)

	 end,

move = function(s, x, y)
	  s.x = s.x + x
 	  s.y = s.y + y
       end,

draw = function(s)
     love.graphics.rectangle(love.draw_line, draw_X(s:L()), draw_Y(s:T()),
     				      s.width*Pixels_Per_Unit, 
	      			      s.height*Pixels_Per_Unit)
--     love.graphics.draw(anims.walk, draw_X(s.x), 
--			draw_Y(s.y)-anims.walk:getHeight()/2, 
--			0, s.heading, 1)
end,
}

function terminal_velocity(x)
   max_vel = 30
   a = math.abs(x)
   if a < max_vel then
      return x else
      return max_vel * x/a -- vel * sign
   end
end

function floor(x)
   if x > 0 then 
      return x 
   else 
      return 0 
   end
end