require("config")

biterCurve = 
(function()
                     local res = {}
                     res[1] = {"small-biter", {{0.0, 0.3}, {0.7, 0.0}}}
                     res[2] = {"medium-biter", {{0.3, 0.0}, {0.6, 0.3}, {0.8, 0.0}}}
                     res[3] = {"big-biter", {{0.6, 0.2}, {1.0, 0.3}}}
                     res[4] = {"behemoth-biter", {{0.95, 0.0}, {0.99, 0.2}, {1.0, 0.7}}}
                     return res
                   end)()

if BiterBias.biasFactor == 0 then
	error(serpent("Bias factor was set to zero, this is invalid!"))
end		   
f = 1/BiterBias.biasFactor - 1
				   
spitterCurve = (function()
                     local res = {}
                     res[1] = {"small-biter", {{0.0, 0.3}, {0.35, 0}}}
                     res[2] = {"small-spitter", {{0.25, 0.0}, {0.5, 0.3}, {0.7, 0.0}}}
                     res[3] = {"medium-spitter", {{0.5, 0.0}, {0.7, 0.3}, {0.9, 0.1}}}
                     res[4] = {"big-spitter", {{0.6, 0.0}, {1.0, 0.4}}}
                     res[5] = {"behemoth-spitter", {{0.99, 0.0}, {1.0, 0.5}}}
					 
					 res[6] = {"medium-biter", {{0.5, 0.0}, {0.7, 0.3*f}, {0.9, 0.1*f}}}
                     res[7] = {"big-biter", {{0.6, 0.0}, {1.0, 0.4*f}}}
                     res[8] = {"behemoth-biter", {{0.99, 0.0}, {1.0, 0.3*f}}}
                     return res
                   end)()

				   
data.raw["unit-spawner"]["biter-spawner"].max_count_of_owned_units = math.floor(data.raw["unit-spawner"]["biter-spawner"].max_count_of_owned_units*BiterBias.biterRate*BiterBias.globalSpawnRate)
data.raw["unit-spawner"]["biter-spawner"].max_friends_around_to_spawn = math.floor(data.raw["unit-spawner"]["biter-spawner"].max_friends_around_to_spawn*BiterBias.biterRate*BiterBias.globalSpawnRate)

data.raw["unit-spawner"]["biter-spawner"].spawning_cooldown = {360, math.floor(150/(BiterBias.biterRate*BiterBias.globalSpawnRate))} --defaults to {360, 150}

if BiterBias.globalSpawnRate ~= 1.0 then
	data.raw["unit-spawner"]["spitter-spawner"].max_count_of_owned_units = math.floor(data.raw["unit-spawner"]["spitter-spawner"].max_count_of_owned_units*BiterBias.globalSpawnRate)
	data.raw["unit-spawner"]["spitter-spawner"].max_friends_around_to_spawn = math.floor(data.raw["unit-spawner"]["spitter-spawner"].max_friends_around_to_spawn*BiterBias.globalSpawnRate)
	data.raw["unit-spawner"]["spitter-spawner"].spawning_cooldown = {360, math.floor(150/BiterBias.globalSpawnRate)} --defaults to {360, 150}
end

if BiterBias.biggerBiters then
	data.raw["unit-spawner"]["biter-spawner"].result_units = biterCurve
end

--data.raw["unit-spawner"]["spitter-spawner"].max_count_of_owned_units = math.floor(data.raw["unit-spawner"]["biter-spawner"].max_count_of_owned_units/BiterBias.biterRate)
--data.raw["unit-spawner"]["spitter-spawner"].max_friends_around_to_spawn = math.floor(data.raw["unit-spawner"]["biter-spawner"].max_friends_around_to_spawn/BiterBias.biterRate)
if BiterBias.biasFactor < 1 then
	data.raw["unit-spawner"]["spitter-spawner"].result_units = spitterCurve
end