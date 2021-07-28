function start (song)
	sway = false
end

function update (elapsed)
	local currentBeat = (songPos / 1000)*(bpm/60)
	
	if sway then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 25 * math.sin((currentBeat + i*0.5)), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 5 * math.cos((currentBeat + i*0.5)) + 10, i)
		end
	end
end

function beatHit (beat)
end

function stepHit (step)
	if step == 896 then
		sway = true
	end
end