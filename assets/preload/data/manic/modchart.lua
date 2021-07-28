function start (song)
	hide = true
	camZoom = false
	for i=4,7 do
		setActorX(2000, i)
	end
end

function update (elapsed)

	local currentBeat = (songPos / 1000)*(bpm/60)
	hudX = getHudX()
    hudY = getHudY()
	
    if hide then
		for i=4,7 do
			setActorAlpha(0, i)
		end
    end
	
    if sway then
        camHudAngle = 5 * math.sin(currentBeat * 0.55)
    end
	
	if crisscross then
		for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] - 300 * math.sin(currentBeat * 0.55) + 350, i)
		end
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 300 * math.sin(currentBeat * 0.55) - 275, i)
		end
	end
	
end

function beatHit (beat)
	if camZoom then
		setCamZoom(0.75)
	end
end

function stepHit (step)

	-- Separate these by ranges instead of on certain steps
	-- This is so that when steps are missed from lag, the effect still goes through
	
	-- fix for placement desync due to possible lag
	if (step >= 30 and step < 200) or (step >= 1030) then
        for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'],i)
        end
	end


	-- hide notes
	if not hide and (step < 1) then
		hide = true
	elseif hide and (step == 1) then
		hide = false
		tweenFadeIn(6, 1, 0.3)
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] - 50, i)
		end
	end
	if (step >= 608 and step < 640) then
		for i=0,3 do
			setActorAlpha(0, i)
			showOnlyStrums = true
		end
	end
	if (step >= 640 and step < 672) then
		for i=0,3 do
			tweenFadeIn(i, 1, 1)
		end
	end
	
	-- Sway hud timing
	if not sway and (step >= 672 and step < 1024) then
		sway = true
		showOnlyStrums = false
	elseif sway and (step >= 1024) then
		sway = false
		camHudAngle = 0
	end
	
	--Criss-Cross note timing
	if (step >= 928 and step < 1024) then
		for i=0,3 do
			tweenFadeOut(i, 0.3, 0.4)
		end
	end
	if (step >= 1024) then
		for i=0,3 do
			tweenFadeIn(i, 1, 0.4)
		end
	end
	if not crisscross and (step >= 928 and step < 1024) then
		crisscross = true
	elseif crisscross and (step >= 1024) then
		crisscross = false
	end
	
	-- camera moment
	if (step >= 28 and step < 32) then
		setCamZoom(1)
	end
	if (step >= 32 and step < 160) or (step >= 928 and step < 1024) then
		camZoom = true
	end
	if (step >= 160 and step < 928) or (step >= 1024) then
		camZoom = false
	end
	
	-- spin transition
	if (step == 26) then
		for i=4,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], getActorAngle(i) + 360, 0.2, 'setDefault')
			tweenFadeIn(i, 1, 0.5)
		end
	end
	if (step == 1024) then
		for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], getActorAngle(i) + 360, 0.2, 'setDefault')
		end
	end
end