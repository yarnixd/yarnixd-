require "SxOrbWalk"
if (myHero.charName ~= "Ryze") then return end
-- de TargetSelector
local ts = TargetSelector(TARGET_LOW_HP_PRIORITY, 600)
function OnLoad()
	Intro()
	-- het menu 
	config = scriptConfig ("Yarnixd's Ryze", "Yarnixd's Ryze")
    -- draw menu
	config:addSubMenu("Draw", "Draw")
	config.Draw:addParam("DrawR", "Draw AA Range", SCRIPT_PARAM_ONOFF, true)
	config.Draw:addParam("DrawQ", "Draw Q Range", SCRIPT_PARAM_ONOFF, true)
	config.Draw:addParam("DrawE", "Draw E and W Range", SCRIPT_PARAM_ONOFF, true)
    -- combo menu 
	config:addSubMenu("Combo", "Combo")
	config.Combo:addParam("Combo", "Combo Mode", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
	config.Combo:addParam("Poke", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
	-- orbwalk menu
	config:addSubMenu("Orbwalker", "SxOrbWalk")
	SxOrb:LoadToMenu(config.SxOrbWalk)
end 

function Intro( )
	PrintChat("<font color=\"#6699ff\">Welcome to Yarnixd's Ryze!!!!")
end

-- ts en combo function 
function OnTick()
	ts:update()
	Poke()
	Combo()
end

-- de draw function
function OnDraw( ... )
	if (myHero.dead) then return end
	if (config.Draw.DrawQ) then 
	    if (myHero:CanUseSpell(_Q) == READY) then
		    DrawCircle(myHero.x, myHero.y, myHero.z, 900, 0xFF33CC)
		end
	end
	if (config.Draw.DrawE) then 
		if (myHero:CanUseSpell(_E) == READY) then 
			DrawCircle(myHero.x, myHero.y, myHero.z, 600, 0xFF6633)
		end
	end
	if (config.Draw.DrawR) then 
		DrawCircle(myHero.x, myHero.y, myHero.z, 610, 0xFF3366)
	end
end
-- de combo function
function Poke()
	if (ts.target ~= nil) and not (ts.target.dead) and (ts.target.visible) then
		if (config.Combo.Poke) then
			if (myHero:GetDistance(ts.target) <= 600) then 
				if (myHero:CanUseSpell(_W) == READY) then
					CastSpell(_W, ts.target)
				end
				if (myHero:CanUseSpell(_Q) == READY) then
					CastSpell(_Q, ts.target.x,ts.target.z)
				end
				if (myHero:CanUseSpell(_E) == READY) then
					CastSpell(_E, ts.target)
				end
			end
		end
	end
end

function Combo()
	if (ts.target ~= nil) and not (ts.target.dead) and (ts.target.visible) then
		if (config.Combo.Combo) then
			if (myHero:GetDistance(ts.target) <= 600) then
				if (myHero:CanUseSpell(_R) == READY) then
					CastSpell(_R)
				end
				if (myHero:CanUseSpell(_W) == READY) then
					CastSpell(_W, ts.target)
				end
				if (myHero:CanUseSpell(_Q) == READY) then
					CastSpell(_Q, ts.target.x,ts.target.z)
				end
				if (myHero:CanUseSpell(_E) == READY) then
					CastSpell(_E, ts.target)
				end
			end
		end
	end
end
