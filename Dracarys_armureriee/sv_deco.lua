ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('Dracarys:weapon')
AddEventHandler('Dracarys:weapon', function(price, weapon, label)
     local _source = source
     local xPlayer = ESX.GetPlayerFromId(_source)
     xPlayer.addWeapon(weapon, 200)  
end)



RegisterServerEvent('Dracarys:buyweapon')
AddEventHandler('Dracarys:buyweapon', function(price, weapon, label)
          local _source = source
          local xPlayer = ESX.GetPlayerFromId(_source)
          if xPlayer.getMoney() >= price then
          xPlayer.removeMoney(price)
          xPlayer.addWeapon(weapon, 200)

         TriggerClientEvent('esx:showAdvancedNotification', source, "Ammunation", "~g~Achat Effectué", "Nouvelle armes disponilbe", "CHAR_AMMUNATION", "Chat Box")
     else
          TriggerClientEvent('esx:showAdvancedNotification', source, "Ammunation", "Achat ~r~annulé", "L'ame n'a pas été acheter", "CHAR_AMMUNATION", "Chat Box")    end
end)

