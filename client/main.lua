local Keys = {
	["H"] = 74, ["Z"] = 20, ["LEFTSHIFT"] = 21 
}

local voice = {default = 5.0, shout = 12.0, whisper = 1.0, current = 0, level = nil}

function drawLevel(r, g, b, a)
	SetTextFont(4)
	SetTextScale(0.5, 0.5)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(_U('voice', voice.level))
	EndTextCommandDisplayText(0.175, 0.87)
end

AddEventHandler('onClientMapStart', function()
	if voice.current == 0 then
		NetworkSetTalkerProximity(voice.default)
	elseif voice.current == 1 then
		NetworkSetTalkerProximity(voice.shout)
	elseif voice.current == 2 then
		NetworkSetTalkerProximity(voice.whisper)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
--
		if IsControlJustPressed(1, Keys['H']) and IsControlPressed(1, Keys['LEFTSHIFT']) then
			voice.current = (voice.current + 1) % 3
			if voice.current == 0 then
				NetworkSetTalkerProximity(voice.default)
				voice.level = _U('normal')
			elseif voice.current == 1 then
				NetworkSetTalkerProximity(voice.shout)
				voice.level = _U('shout')
			elseif voice.current == 2 then
				NetworkSetTalkerProximity(voice.whisper)
				voice.level = _U('whisper')
			end
		end
--
		if voice.current == 0 then
			voice.level = _U('normal')
		elseif voice.current == 1 then
			voice.level = _U('shout')
		elseif voice.current == 2 then
			voice.level = _U('whisper')
		end

		if NetworkIsPlayerTalking(PlayerId()) then
			drawLevel(41, 128, 185, 255)
		elseif not NetworkIsPlayerTalking(PlayerId()) then
			drawLevel(185, 185, 185, 255)
		end
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1)
-- 		if IsControlJustPressed(1, Keys['Z']) then
-- 			local id = GetPlayerServerId(PlayerId())
--       drawPlayerId(185, 185, 185, 255, id)
-- 		end
-- 	end
-- end)

-- function drawPlayerId(r, g, b, a, pid)
-- 	SetTextFont(4)
-- 	SetTextScale(0.5, 0.5)
-- 	SetTextColour(r, g, b, a)
-- 	SetTextDropShadow(0, 0, 0, 0, 255)
-- 	SetTextEdge(1, 0, 0, 0, 255)
-- 	SetTextDropShadow()
-- 	SetTextOutline()
-- 	BeginTextCommandDisplayText("STRING")
-- 	AddTextComponentString("~y~ID:~s~ " .. pid)
-- 	EndTextCommandDisplayText(0.192, 0.745)
-- end