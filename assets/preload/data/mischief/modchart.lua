function start (song)
end

function update (elapsed)
end

function beatHit (beat)
end

function stepHit (step)
	if (step >= 448 and step % 16 == 0 and step < 576) then
		setCamZoom(1)
		setHudZoom(1.2)
	end
end