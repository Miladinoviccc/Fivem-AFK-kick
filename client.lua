-- CONFIG --

-- Vreme za koje zelite da igrac bude automatski izbacen (napisi u sekundama)
secondsUntilKick = 520

-- Upozorenje igraca da ce biti izbacen
kickWarning = true

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)

			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time == math.ceil(secondsUntilKick / 4) then
						TriggerEvent("chatMessage", "UPOZORENJE", {255, 45, 0}, "^0Bit cete kikovani za ^1" .. time .. " ^0sekundi radi AFK!")
					end

					time = time - 1
				else
					TriggerServerEvent("kickForBeingAnAFKDouchebag")
				end
			else
				time = secondsUntilKick
			end

			prevPos = currentPos
		end
	end
end)