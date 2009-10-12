-- Player
p = {

-- Position
x = 10,
y = 20,

-- Size
width = 1,
height = 2,

-- Velocity
v_x = 0,
v_y = 0,

-- Change in position
dx = 0,
dy = 0,

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
       s.dx = s.v_x * dt;
       s.x  = s.x + s.dx
       s.dy = s.v_y*dt
       s.y  = s.y + s.dy
end,

draw = function(s)
     love.graphics.rectangle(love.draw_line, draw_X(s:L()), draw_Y(s:B()),
     				      s.width*Pixels_Per_Unit, 
	      			      s.height*Pixels_Per_Unit)
end,
}