data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("Barbers:SaveHair")
AddEventHandler("Barbers:SaveHair", function(index)
	local _item = item
    local _source = source
	TriggerEvent('redemrp:getPlayerFromId', source, function(user)
		local identifier = user.getIdentifier()
		local charid = user.getSessionVar("charid")
		local price = 3
		
        if user.getMoney() >= price then
                user.removeMoney(price)
		MySQL.Async.fetchAll("SELECT skin FROM skins WHERE identifier=(@identifier) AND charid=(@charid)", {['@identifier'] = identifier, ['@charid'] = charid}, function(data)
			local skin = {}

			print("Barbers: Hair saved in database, " .. tostring(index))

			skin = json.decode(data[1].skin)
			skin['hair'] = tostring(index)

			MySQL.Async.execute("UPDATE skins SET skin=(@skin) WHERE identifier=(@identifier)", {['@identifier'] = identifier, ['@skin'] = json.encode(skin)})
		end)
				TriggerClientEvent("redemrp_notification:start", _source, "You bought New Hair.", 3, "success")
		else
            TriggerClientEvent("redemrp_notification:start", _source, "You need more money",3)

        end
	end)
end)

RegisterServerEvent("Barbers:SaveBeard")
AddEventHandler("Barbers:SaveBeard", function(index)
	local _item = item
    local _source = source
	TriggerEvent('redemrp:getPlayerFromId', source, function(user)
		local identifier = user.getIdentifier()
		local charid = user.getSessionVar("charid")
		local price = 3
		
        if user.getMoney() >= price then
                user.removeMoney(price)

		MySQL.Async.fetchAll("SELECT skin FROM skins WHERE identifier=(@identifier) AND charid=(@charid)", {['@identifier'] = identifier, ['@charid'] = charid}, function(data)
			local skin = {}

			print("Barbers: Beard saved in database, " .. tostring(index))

			skin = json.decode(data[1].skin)
			skin['beard'] = tostring(index)

			MySQL.Async.execute("UPDATE skins SET skin=(@skin) WHERE identifier=(@identifier)", {['@identifier'] = identifier, ['@skin'] = json.encode(skin)})
		end)
			TriggerClientEvent("redemrp_notification:start", _source, "You bought New Beard.", 3, "success")
		else
            TriggerClientEvent("redemrp_notification:start", _source, "You need more money",3)

        end
	end)
end)
