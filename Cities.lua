local aName, aTable = ...

-- takes an array and returns it as a sorted table.
function aTable.createSortedTable(array, indexing)
    if array ~= nil then
        local temp = {}
        for k in pairs(array) do
			table.insert(temp, k)
        end
        table.sort(temp)
        return temp
    else
        print("WIP: No Cities")
    end
end


-- this function assumes it is being given a sorted table.
-- aTable.createSortedTable(array) can be used to produce sorted tables.
function aTable.createAlphabetTable(table)
	local temp = {}
	local letter
	-- efficient local scoping of external locals
	local lower = string.lower
	for k,v in ipairs(table) do
		-- if a new first letter is seen, insert its index in the table
		if lower(v):sub(1,1) ~= letter then
			letter = lower(v):sub(1,1)
			temp[letter] = k
		end
	end
	return temp
end

-- Check if the city leads to nowhere
function aTable.deadEnd(city)
        if aTable.paths[city] then
            for k in pairs(aTable.paths[city]) do
                if k == nil then
                    print("Dead End")
                    return true
                else
                    print("Not Dead End")
                    return false
                end
            end
        end
    end


local function scanBags(item)
	-- TODO: code to scan bags for item, and return its cooldown (if return is nil, then item is not in bags).
		-- -also scan toys for portals
end


aTable.paths = {
	["Stormwind"] = {
		["Ironforge"] = {
			["flying"] = {
				dist = 721,
				req = nil,
				note = ""
			},
			["portal1"] = {
				name = ""
			}
		},
		["Hyjal"] = {
        
		},
        ["Darnassus"] = {
        
        }
	},
    ["Hyjal"] = {
        ["Test Delete"] = {
        
        }
    }
}

aTable.portals = {
	stormwind = {
		{
			-- Cloak of Coordination
			name = GetItemInfo(65360),
			note = "Obtained by being revered with a guild."
		},
		{
			-- Wrap of Unity
			name = GetItemInfo(63206),
			note = "Obtained by being friendly with a guild."
		},
		{
			-- Shroud of Cooperation
			name = GetItemInfo(63352),
			note = "Obtained by being honored with a guild."
		}
	},
	dalaran_legion = {
		{
			-- Dalaran Hearthstone
			name = GetItemInfo(140192),
			note = "Received upon completing the Legion introductory quests."
		},
		{
			-- Empowered Ring of the Kirin Tor
			name = GetItemInfo(139599),
			note = "Bought for 50k gold, in Dalaran."
		}
	},
	deepholm = {
		{
			-- Potion of Deepholm
			name = GetItemInfo(58487),
			note = "Crafted by Alchemists"
		}
	}
}

	
-- variables:
-- ek: Eastern Kingdoms || kd: Kalimdor || nd: Northrend
-- pd: Pandaria	|| bi: Broken Isles || od: Outlands
-- dn: Draenor || ms: Maelstrom || ag: Argus
-- TODO: goblin Kezan
-- cont: continent || req: requirement


		
aTable.cities = {
	["Stormwind"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Wailing Caverns"] = {
		cont = "kd", zoneID = 2320, x = 100, y = 129},
	["Ironforge"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Undercity"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Exodar"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Dalaran-Legion"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Dalaran-Wrath"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Shrine of the Seven Stars Stars Stars Stars"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Orgrimmar"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Thunder Bluff"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Darnassus"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Silvermoon City"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Gnomergan"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Shattrath"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Firelands"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Caverns of Time"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Dragon Soul"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Blackrock Mountain"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Blackrock Depths"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Molten Core"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Zul'Gurub"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Sunken Temple"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Ulduar"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Tomb of Sargeras"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Nighthold"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81},
	["Hyjal"] = {
		cont = "ek", zoneID = 744, x = 73, y = 81}
}












