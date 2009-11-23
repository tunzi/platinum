
t = {{0,0}}
math.randomseed(os.time())
for i=1, 500 do
   table.insert(t, {i*10, (t[i][2]*.9+math.random(55)*.1)})
end

world_data = {
   width = 5000,
   paths = {
   -- A horizontal line
      {{10.0, 5.0}, {20.0, 5.0}},
   -- A vertical line
--   {10.0, 5.0, 10.0, 20.0}, 
--   {10.0, 20.0, 20.0, 20.0},
      {{20.0, 5.0}, {20.0, 20.0}, {30.0, 10.0}},

   -- A sloped line
      {{20.0, 20.0}, {22.0, 22.0}},
   -- continued...
--   {22.0, 22.0, 30.0, 23.0},
--   {30.0, 23.0, 35.0, 20.0},
--   {35.0, 20.0, 50.0, 20.0},
   },
}

table.insert(world_data.paths, t)
