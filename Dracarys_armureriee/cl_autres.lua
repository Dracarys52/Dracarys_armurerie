ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	end
  end)


weapon = {
  Base = {Header = {"shopui_title_gunclub", "shopui_title_gunclub"}, Title = "", Color = {color_black}, HeaderColor = {255, 255, 255}}, 
  Data = {currentMenu = "Acheter vos armes"},
  Events = {
      onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
        if self.Data.currentMenu == "Armes" then
          print(btn.name)
          local price = btn.price
          
          weapon.Menu["Option Armes : "].b = {}
          table.insert(weapon.Menu["Option Armes : "].b, {name = "Prix : ~g~ " .. price, askX = true})
          table.insert(weapon.Menu["Option Armes : "].b, {name = "~b ~Armes : " .. btn.name, askX = true})
          table.insert(weapon.Menu["Option Armes : "].b, {name = "Essayer l'~o~arme", prices = price,  weapontest = btn.weapon,askX = true})
          table.insert(weapon.Menu["Option Armes : "].b, {name = "Acheter l'arme", colorFree = { 0, 139, 36, 100 },colorSelected = { 3, 63, 8, 100 }, prices = price, weapontest = btn.weapon, askX = true})
          OpenMenu('Option Armes : ')

        end

        if btn.name == "Armes" then
          weapon.Menu["Armes"].b = {}
           table.insert(weapon.Menu["Armes"].b, {name = "~w~Pistolet de combat", price = 18000, askX = true, armes = btn.name, weapon = "weapon_pistol"})
           table.insert(weapon.Menu["Armes"].b, {name = "Calibre 50", price = 19000, askX = true, armes = btn.name, weapon = "weapon_pistol50"})
           table.insert(weapon.Menu["Armes"].b, {name = "Revolver", price = 20000, askX = true, armes = btn.name, weapon = "weapon_revolver"})
           table.insert(weapon.Menu["Armes"].b, {name = "Smg", price = 35000, askX = true, armes = btn.name, weapon = "weapon_smg"}) 
           table.insert(weapon.Menu["Armes"].b, {name = "Fusil a pompe", price = 38500, askX = true, armes = btn.name, weapon = "weapon_pumpshotgun"}) 
          OpenMenu('Armes')

        elseif btn.name == "Essayer l'~o~arme" then
          print(btn.weapontest)
          DoScreenFadeOut(500)
          Wait(600)
          DoScreenFadeIn(1000)  
          SetEntityCoords(GetPlayerPed(-1), 13.19, -1097.80, 29.79)
          ESX.ShowNotification('Test en ~r~cours...' )
          TriggerServerEvent('Dracarys:weapon', 1, btn.weapontest, "Armes")
          Wait(20)
          --FreezeEntityPosition(GetPlayerPed(-1), true)
          Wait(9000)
          SetEntityCoords(GetPlayerPed(-1), 21.486, -1106.53, 28.90)
          RemoveAllPedWeapons(GetPlayerPed(-1), true)
          Wait(20)
          --FreezeEntityPosition(GetPlayerPed(-1), false)

        elseif btn.name == "Acheter l'arme" then
          print(btn.prices)       
          TriggerServerEvent('Dracarys:buyweapon', btn.prices, btn.weapontest, "Armes")

        elseif btn.name == "Fermer le menu" then
          CloseMenu()

  

        end
    end,
      },

Menu = {
    ["Acheter vos armes"] = {
      b = {
        {name = "Armes", ask = ">>",  askX = true},
        {name = "Fermer le menu", ask = ">>", colorFree = { 252, 7, 7,100 },colorSelected = { 0, 0, 0, 100 },  askX = true}
       }
      },

    ["Armes"] = {
        b = {}
       },
  

    ["Option Armes : "] = {
        b = {}
       },


       }
     }


local pos4 = { 
    {x = 21.486,   y = -1106.53,  z = 29.79 },   
}


--- BLIPPSS

    
Citizen.CreateThread(function()
    for _, pos in pairs(pos4) do
      blips = AddBlipForCoord( 21.486, -1106.53, 29.79)
      SetBlipSprite(blips, 110)
      SetBlipScale(blips, 1.0)
      SetBlipDisplay(blips, 2)
      SetBlipColour(blips, 15)
      SetBlipAsShortRange(blips, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Armurerie")
      EndTextCommandSetBlipName(blips)
    end
end)  



 --CREATE MENU 
   
Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)  
        for k in pairs(pos4) do    
          local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
          local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos4[k].x, pos4[k].y, pos4[k].z)
              if dist <= 5.0 then
                DrawMarker(25, 21.486, -1106.53, 28.90 , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 142, 254, 100)
              else
               Citizen.Wait(500)
            end 
              if dist <= 1.0 then
           ESX.ShowHelpNotification("Press ~b~ E ~s~ pour accèder a l'armurerie.") 
          if IsControlJustPressed(1,51) then   
              CreateMenu(weapon)
            end
          end
      end
  end  
end)
---- DISCORD POUR QUESTION OU AUTRE : https://discord.gg/HU2qZaAXUU
---- Script armurerie by Dracarys + la possibilité de tester l'arme avant de l'acheter et évidemment l'arme n'est plus dans l'inventaire du joueur après le test de l'arme
