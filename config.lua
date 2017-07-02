BiterBias = {}

-- change this to affect the global spawn rate; it is multiplied by all spawn rates (and by biterRate for biter spawn rate). 1.0 is vanilla and default.
BiterBias.globalSpawnRate = settings.startup["global-spawn-rate"].value--1.0

-- change this to modify the biter spawner spawn rate. 1.0 is vanilla settings, 4.0 is default.
BiterBias.biterRate = settings.startup["biter-rate"].value--1.0 --2.0 is a good medium

-- change this to modify the bias factor, that is, the Biter/Spitter spawn ratio. 1.0 is vanilla settings, 0.5 is default (i.e. 50% of spitter spawns become biter spawns).
BiterBias.biasFactor = settings.startup["bias-factor"].value--0.33

-- To compensate for the reduced difficulty (since spitters are more dangerous than biters), increase biter spawn size (as per the evolution factor). Note that this does not make any size appear earlier, just more likely once it does appear.
BiterBias.biggerBiters = settings.startup["bigger-biters"].value--true