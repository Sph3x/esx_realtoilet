ESX                           = nil

local lasttoa = 0

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5)
    end
end)

Citizen.CreateThread(function()
    while true do

        Citizen.Wait(5)

        local entity, distance = ESX.Game.GetClosestObject({
			'prop_ld_toilet_01',
			'prop_portaloo_01a',
        })

        if distance ~= -1 and distance <= 3 then
            if entity ~= nil then
                local toaCoords = GetEntityCoords(entity)
                ESX.Game.Utils.DrawText3D({ x = toaCoords.x, y = toaCoords.y, z = toaCoords.z + 1 }, '[E] Gör dina behov här', 0.4)
                if IsControlJustReleased(0, 38) then
                    if lasttoa ~= entity then
                        lasttoa = entity
						OpenBehovsMeny()
						ESX.Game.Teleport(PlayerPedId(), { x = toaCoords.x, y = toaCoords.y, z = toaCoords.z + 1 })
                        Citizen.Wait(15000)
                        ESX.Game.Teleport(PlayerPedId(), { x = toaCoords.x, y = toaCoords.y, z = toaCoords.z + 2 })
                    end
                end
            else
                Citizen.Wait(500)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function OpenBehovsMeny()
	TriggerEvent('esx-qalle-needs:openMenu')
	--Citizen.Wait(15000)
	--ESX.Game.Teleport(PlayerPedId(), { x = toaCoords.x - 3, y = toaCoords.y - 3, z = toaCoords.z + 1 })
end
