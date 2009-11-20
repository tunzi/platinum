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

	    -- Main movement occurs here 
	    -- Need to add acceleration too?
	    -- Move this to before collisions?
	    s.v_y = s.v_y + w.g * dt
	    s.v_y = terminal_velocity(s.v_y)
	    s.dx = s.v_x * dt; V[1] = V[1] + s.dx
	    s.dy = s.v_y * dt
	    s:move(s.dx, s.dy)

	    if collide_platforms(s, w.platforms) then
	       s.dv_y = 0
	       s.v_y = 0
	       s.dy  = 0
	       message = "plat"
	    end

	    if collide_walls(s, w.walls) then
	       s.v_x = 0
	       s.dx  = 0
	       message = "wall"
	    end

	    if collide_slopes(s, w.slopes) then
	       s.dv_y = 0
	       s.v_y = 0
	       s.dy  = 0
	       message = "slope"
	    end

-- update animation
	    anims.walk:update(dt)

	 end,

move = function(s, x, y)
	  s.x = s.x + x
 	  s.y = s.y + y
       end,

draw = function(s)
     love.graphics.rectangle(love.draw_line, draw_X(s:L()), draw_Y(s:T()),
     				      s.width*Pixels_Per_Unit, 
	      			      s.height*Pixels_Per_Unit)
     love.graphics.draw(anims.walk, draw_X(s.x), 
			draw_Y(s.y)-anims.walk:getHeight()/2, 
			0, s.heading, 1)
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