local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('NonELSCarSystem:getNonELSCars', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT * FROM ' .. Config.Database.tableName .. ' WHERE owner = @owner', {
        ['@owner'] = identifier
    }, function(result)
        cb(result)
    end)
end)

RegisterNetEvent('NonELSCarSystem:spawnNonELSCar')
AddEventHandler('NonELSCarSystem:spawnNonELSCar', function(carData)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.execute('INSERT INTO ' .. Config.Database.tableName .. ' (owner, model, plate, livery, extras) VALUES (@owner, @model, @plate, @livery, @extras)', {
        ['@owner'] = identifier,
        ['@model'] = carData.model,
        ['@plate'] = carData.plate,
        ['@livery'] = carData.livery,
        ['@extras'] = json.encode(carData.extras)
    }, function(rowsChanged)
        TriggerClientEvent('NonELSCarSystem:spawnNonELSCar', source, carData)
    end)
end)