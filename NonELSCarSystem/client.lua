local ESX = nil
local NonELSCars = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()

    for _, car in ipairs(Config.NonELSCars) do
        NonELSCars[car.model] = car
    end

    RegisterNetEvent('NonELSCarSystem:spawnNonELSCar')
    AddEventHandler('NonELSCarSystem:spawnNonELSCar', function(carData)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)

        ESX.Game.SpawnVehicle(carData.model, coords, heading, function(vehicle)
            SetVehicleLivery(vehicle, carData.livery)
            for extra, state in pairs(carData.extras) do
                SetVehicleExtra(vehicle, extra, state and 0 or -1)
            end

            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        end)
    end)
end)