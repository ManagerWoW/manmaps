local aName, aTable = ...


--[[ Takes an array and returns it as a sorted table.
	If "indexing" (bool) is enabled, it will also return
	a second array that contains the index where each letter (ABC)
	starts. ex: alphabetIndex['c'] = 106 would mean that 'c' words 
	start at the 106th city. This will be used for searching. --]]
function aTable.createSortedTable(array, indexing)
    if array ~= nil then
        local sortedTable = {}               -- array to return
		local alphabetIndex = {}      -- alphabetIndex['a'..'b'..'c'..etc]
		local letter                  -- first letter of the city
		local count = 1               -- index of "letter"
		local STRlower = string.lower -- local scoping of a global
		local STRchar = string.char   -- ''
		
        for k in pairs(array) do
			table.insert(sortedTable, k)
			if indexing then
				letter = STRlower(k):sub(1,1)
				-- collect # of occurences of each letter
				alphabetIndex[letter] = (alphabetIndex[letter] or 0) + 1
			end
        end
        table.sort(sortedTable)
		
		-- alphabetIndex[] is converted to now store the index 
		-- position where each new letter starts.
		if indexing then
			for i=97,122 do --ascii 'a' to 'z'
				letter = STRchar(i)
				local occurences = (alphabetIndex[letter] or 0) -- save old value of aI[]
				alphabetIndex[letter] = count
				count = count + occurences
			end
			return sortedTable, alphabetIndex
		else
			return sortedTable
		end
    else
        print("This city has no connecting destinations")
    end
end


-- boolean check if the city leads to nowhere
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
	else
		print("No city exists")
	end
end

function aTable.searchCity(self, userInput)
	local text, firstLetter = self:GetText()
	local matches = {}
	if (userInput and (text ~= "")) then
		text = string.lower(text)
		
		firstLetter = text:sub(1,1)
		nextLetter  = string.char(string.byte(firstLetter) + 1)
		-- city index ranges to search
		local start = aTable.cityAlphabetTable[firstLetter]
		local stop  = aTable.cityAlphabetTable[nextLetter]
		
		for i=start,stop do
			-- TODO: early break logic to save time
			-- compare user search text to cities
			if (string.lower(aTable.sortedCities[i]):find("^"..text)) then
				table.insert(matches, aTable.sortedCities[i])
			end
		end
		table.sort(matches)
		aTable.sourceScrollFrameUpdate(matches, true)
	else
		aTable.sourceScrollFrameUpdate()
	end
end

function scanBags(item)
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












