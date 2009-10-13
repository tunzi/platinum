-- Player
p = {

-- Position (middle?)
x = 10,
y = 10,

-- Size
width = 1,
height = 2,

-- Velocity
v_x = 1.0,
v_y = -5.0,

-- Change in position
dx = 0.0,
dy = 0.0,

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


	    if collide_platforms(s, w.platforms) then
	       s.v_y = 0
	       s.dy  = 0
	    end

	    if collide_walls(s, w.walls) then
	       s.v_x = 0
	       s.dx  = 0
	    end

	    -- Main movement occurs here 
	    -- Need to add acceleration too?
	    -- Move this to before collisions?
	    s.dx = s.v_x * dt
	    s.dy = s.v_y * dt
	    s:move(s.dx, s.dy)

	 end,

move = function(s, x, y)
	  s.x = s.x + x
 	  s.y = s.y + y
       end,

draw = function(s)
     love.graphics.rectangle(love.draw_line, draw_X(s:L()), draw_Y(s:T()),
     				      s.width*Pixels_Per_Unit, 
	      			      s.height*Pixels_Per_Unit)
end,
}