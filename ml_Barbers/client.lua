local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3,["LALT"] = 0xE8342FF2, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9, ["J"] = 0xF3830D8E }
local list_hair = {}
local list_hair_f = {}
local list_mustache = {}
local adding = true
local adding2 = true
local active = false
local ShopPrompt
local hasAlreadyEnteredMarker, lastZone
local currentZone = nil

--Lupo
Citizen.CreateThread(function()
    while adding do
        Citizen.Wait(0)
        for i, v in ipairs(MaleComp) do
            if v.category == "hair" then
                table.insert(list_hair, v.Hash)
            elseif v.category == "mustache" then
                table.insert(list_mustache, v.Hash)
            end
        end
        adding = false
    end
end)

Citizen.CreateThread(function()
    while adding2 do
        Citizen.Wait(0)
        for i, v in ipairs(FemaleComp) do
            if v.category == "hair" then
                table.insert(list_hair_f, v.Hash)
            end
        end
        adding2 = false
    end
end)

-- edit Lupo

Citizen.CreateThread(function()
	local currenthairIndex = 1
    local selectedhairIndex = 1
    local currentmustacheIndex = 1
    local selectedmustacheIndex = 1
	
    if not DoesEntityExist(florencewatson) then
        local hash = GetHashKey("S_M_M_Barber_01")
        --RequestModel(hash)

        while not HasModelLoaded(hash) do
            Wait(100)
        end

        local florencewatson = CreatePed(hash, -815.861, -1364.531, 43.750, 272.97, false, true)
        SetPedRandomComponentVariation(florencewatson, 0)
        SetBlockingOfNonTemporaryEvents(florencewatson, true)
        SetEntityInvincible(florencewatson, true)
        SetPedCanBeTargettedByPlayer(florencewatson, GetPlayerPed(), false)
    end


    WarMenu.CreateMenu('BarberMenu', "Barbers")
    WarMenu.SetSubTitle('BarberMenu', ' ')
    --WarMenu.SetMenuWidth('BarberMenu', 0.222)
    WarMenu.SetMenuX('BarberMenu', 0.04)
    WarMenu.SetMenuMaxOptionCountOnScreen('BarberMenu', 15)

    WarMenu.CreateSubMenu('HairMenu', 'BarberMenu', ' ')
    WarMenu.CreateSubMenu('BeardMenu', 'BarberMenu', ' ')
	WarMenu.CreateSubMenu('fHairMenu', 'BarberMenu', ' ')

    while true do
        Citizen.Wait(0)

        if WarMenu.IsMenuOpened('BarberMenu') then
            if IsPedModel(GetPlayerPed(), GetHashKey("mp_male")) then
                
            

            if WarMenu.MenuButton('Hair styles', 'HairMenu') then
            end
			
			if WarMenu.MenuButton('Beard styles', 'BeardMenu') then
            end
			
			else
			
			if WarMenu.MenuButton('F Hair styles', 'fHairMenu') then
            end

            end

            if WarMenu.IsMenuAboutToBeClosed() then
                ClearPedTasks(GetPlayerPed())
            end

            WarMenu.Display()
        end

        --Sub menus
		
        if WarMenu.IsMenuOpened('HairMenu') then
		if WarMenu.ComboBox('Hair: < '..currenthairIndex..' >', list_hair, currenthairIndex, selectedhairIndex, function(currenthair, selectedhair)
                        currenthairIndex = currenthair
                        selectedhairIndex = selectedhair
                        local hash = ("0x" ..list_hair[currenthairIndex])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- HAIR
                    end) then
                    TriggerServerEvent("Barbers:SaveHair", selectedhairIndex)
           -- for key, value in pairs(hair) do
                --if WarMenu.Button(value.name, "") then
                 --   Citizen.InvokeNative(0xD3A7B003ED343FD9, GetPlayerPed(), value.hash, true, true, true)
                   -- TriggerServerEvent("Barbers:SaveHair", key)
               -- end
            end

            WarMenu.Display()
        end

        if WarMenu.IsMenuOpened('BeardMenu') then
		if WarMenu.ComboBox('Beard: < '..currentmustacheIndex..' >', list_mustache, currentmustacheIndex, selectedmustacheIndex, function(currentmustache, selectedmustache)
                        currentmustacheIndex = currentmustache
                        selectedmustacheIndex = selectedmustache
                        local hash = ("0x" ..list_mustache[currentmustacheIndex])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- Facial hair
                    end) then
                   TriggerServerEvent("Barbers:SaveBeard", selectedmustacheIndex)
           -- for key, value in pairs(beards) do
             --   if WarMenu.Button(value.name, "") then
               --     Citizen.InvokeNative(0xD3A7B003ED343FD9, GetPlayerPed(), value.hash, true, true, true)
               --     TriggerServerEvent("Barbers:SaveBeard", key)
              --  end
            end

            WarMenu.Display()
        end
		
		if WarMenu.IsMenuOpened('fHairMenu') then
		if WarMenu.ComboBox('Hair: < '..currenthairIndex..' >', list_hair_f, currenthairIndex, selectedhairIndex, function(currenthair, selectedhair)
                        currenthairIndex = currenthair
                        selectedhairIndex = selectedhair
                        local hash = ("0x" ..list_hair_f[currenthairIndex])
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- HAIR
                    end) then
                    TriggerServerEvent("Barbers:SaveHair", selectedhairIndex)
          --  for key, value in pairs(fhair) do
             --   if WarMenu.Button(value.name, "") then
                 --   Citizen.InvokeNative(0xD3A7B003ED343FD9, GetPlayerPed(), value.hash, true, true, true)
                 --   TriggerServerEvent("Barbers:SaveHair", key)
              --  end
            end

            WarMenu.Display()
        end

		if IsPlayerNearCoords(-814.263, -1364.779, 43.750) then
           TriggerEvent('redem_roleplay:Tip', "Press ~INPUT_ENTER~ to open the barber shop.", 100)
          if IsControlJustPressed(0, 0xCEFD9220) then
				TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey("PROP_PLAYER_BARBER_SEAT"), -815.3, -1367.018, 43.50, 90.60, 0, 0, 1)
				WarMenu.OpenMenu('BarberMenu')
          end
        end
		
		if IsPlayerNearCoords(-307.45, 812.17, 118.98) then
           TriggerEvent('redem_roleplay:Tip', "Press ~INPUT_ENTER~ to open the barber shop.", 100)
          if IsControlJustPressed(0, 0xCEFD9220) then
				TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey("PROP_PLAYER_BARBER_SEAT"), -306.62, 813.56, 118.75, 90.60, 0, 0, 1)
				WarMenu.OpenMenu('BarberMenu')
          end
        end
		
		if IsPlayerNearCoords(2655.05, -1179.92, 53.28) then
           TriggerEvent('redem_roleplay:Tip', "Press ~INPUT_ENTER~ to open the barber shop.", 100)--Middle Seat
          if IsControlJustPressed(0, 0xCEFD9220) then
                TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey("PROP_PLAYER_BARBER_SEAT"), 2655.38, -1180.92, 53.00, 182.8, 0, 0, 1)
                WarMenu.OpenMenu('BarberMenu')
          end
        end        
        
        if IsPlayerNearCoords(2652.90, -1180.27, 53.28) then
           TriggerEvent('redem_roleplay:Tip', "Press ~INPUT_ENTER~ to open the barber shop.", 100)--Right Seat
          if IsControlJustPressed(0, 0xCEFD9220) then
                TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey("PROP_PLAYER_BARBER_SEAT"), 2653.75, -1180.92, 53.00, 182.8, 0, 0, 1)
                WarMenu.OpenMenu('BarberMenu')
          end
        end    

        if IsPlayerNearCoords(2657.65, -1180.32, 53.28) then
           TriggerEvent('redem_roleplay:Tip', "Press ~INPUT_ENTER~ to open the barber shop.", 100)--Left Seat
          if IsControlJustPressed(0, 0xCEFD9220) then
                TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey("PROP_PLAYER_BARBER_SEAT"), 2657.00, -1180.92, 53.00, 182.8, 0, 0, 1)
                WarMenu.OpenMenu('BarberMenu')
          end
        end
		
    end
end)

function IsPlayerNearCoords(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(GetPlayerPed(), 0))
    local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)

    if distance < 1 then
        return true
    end
end


