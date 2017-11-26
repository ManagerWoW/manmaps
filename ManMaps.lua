local aName, aTable = ...

function aTable.OnEvent(self, event, ...)
	if (event == "ADDON_LOADED") then
		local addonName = ...
		if addonName == "ManMaps" then
            aTable.slashCommands()
			aTable.createFrames()
		end
	end
end


-- Events for loading addon
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
--f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", aTable.OnEvent)




























