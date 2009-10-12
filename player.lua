-- Player
p = {

-- Position (middle?)
x = 10,
y = 20,

-- Size
width = 1,
height = 2,

-- Velocity
v_x = 1.0,
v_y = 1.0,

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
    T = function(s) return s.y end,
    B = function(s) return s.y+s.height end,

update = function(s, dt)
	    s.dx = s.v_x * dt
	    s.dy = s.v_y * dt
	    s:move(s.dx, s.dy)

	    collide_platforms(s, w.platforms)
	 end,

move = function(s, x, y)
	  s.x = s.x + x
 	  s.y = s.y + y
	  message = x
       end,

draw = function(s)
     love.graphics.rectangle(love.draw_line, draw_X(s:L()), draw_Y(s:B()),
     				      s.width*Pixels_Per_Unit, 
	      			      s.height*Pixels_Per_Unit)
end,
}