local aName, aTable = ...
local mmf -- Man Maps Frame
local selectedCity

--print(aTable.paths["Stormwind"]["Ironforge"]["flying"].dist)

function aTable.createFrames()

	--------------------------------------
	--------------------------------------
	--          Frames/Buttons          --
	--------------------------------------
	--------------------------------------

-- List of variables/frames
-- mmf (ManMapsFrame; main addon frame)
-- routesf (RoutesFrame; frame section that displays all route results)

	mmf = CreateFrame("Frame", "ManMapsFrame", UIParent)

	-- Setup background frame
	mmf:SetPoint("CENTER",0,0)
	mmf:SetBackdrop({
		bgFile="Interface\\Addons\\ManMaps\\media\\White", 
		edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
		tile=1, tileSize=32, edgeSize=32, 
		insets={left=11, right=12, top=12, bottom=11}})
	mmf:SetBackdropColor(0.1,0.1,0.1,1)
	mmf:SetSize(900,660)
	mmf:SetFrameStrata("MEDIUM")
	mmf:SetToplevel(true)
	mmf:EnableMouse(true)
	mmf:SetMovable(true)
	mmf:RegisterForDrag("LeftButton")
	mmf:SetScript("OnDragStart", function(self) self:StartMoving() end)
	mmf:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    mmf:Hide()


	-- Title text for main frame
	mmf.Title = mmf:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	mmf.Title:SetPoint("TOP",0,-15)
	mmf.Title:SetFont("Fonts\\MORPHEUS.ttf",20)
	mmf.Title:SetTextColor(1,.7,0,1)
	mmf.Title:SetText("ManMaps")

	-- Close button for main frame
	mmf.Close = CreateFrame("Button", "ManMapsClose", mmf, "UIPanelCloseButton")
	mmf.Close:SetPoint("TOPRIGHT", -9, -9)

	-- FauxScrollframe for source locations
	mmf.sourceScrollFrame = CreateFrame("ScrollFrame", "ManMaps_SourceScrollFrame", ManMapsFrame, "FauxScrollFrameTemplate")
	mmf.sourceScrollFrame:SetPoint("TOPLEFT", 20, -100)
	mmf.sourceScrollFrame:SetPoint("BOTTOMRIGHT", -700, 20)
	mmf.sourceScrollFrame:SetBackdrop({
		bgFile="Interface\\Addons\\ManMaps\\media\\White",
		edgeFile="Interface\\ChatFrame\\ChatFrameBackground",
		tile=1, tileSize=1, edgeSize=1, 
		insets={left=12, right=12, top=12, bottom=12}})
	mmf.sourceScrollFrame:SetBackdropColor(0.1,0.1,0.1,1)
	mmf.sourceScrollFrame:SetBackdropBorderColor(0.3,0.3,0.3,1)
    
	-- FauxScrollframe for desinations
	mmf.destScrollFrame = CreateFrame("ScrollFrame", "ManMaps_DestinationScrollFrame", ManMapsFrame, "FauxScrollFrameTemplate")
	mmf.destScrollFrame:SetPoint("TOPLEFT", mmf.sourceScrollFrame, "TOPRIGHT", 30, 0)
	mmf.destScrollFrame:SetPoint("BOTTOMRIGHT", -480, 20)
	mmf.destScrollFrame:SetBackdrop({
		bgFile="Interface\\Addons\\ManMaps\\media\\White",
		edgeFile="Interface\\ChatFrame\\ChatFrameBackground",
		tile=1, tileSize=1, edgeSize=1, 
		insets={left=1, right=1, top=1, bottom=1}})
	mmf.destScrollFrame:SetBackdropColor(0.1,0.1,0.1,1)
	mmf.destScrollFrame:SetBackdropBorderColor(0.3,0.3,0.3,1)
    
	-- Home tab
	mmf.mainTab = CreateFrame("Button", "ManMaps_Home", mmf, "UIPanelButtonTemplate")
	mmf.mainTab:SetPoint("TOPLEFT", 13, -13)
	mmf.mainTab:SetFrameLevel(mmf:GetFrameLevel()+1)
	mmf.mainTab:SetScript("OnClick", function(self, button)
		mmf.sourceScrollFrame:Show()
        mmf.destScrollFrame:Show() end)
	-- Font String
	mmf.mainTab.Text = mmf.mainTab.Text or mmf:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	mmf.mainTab.Text:SetText("Home")
	mmf.mainTab.Text:SetPoint("CENTER", ManMaps_Home, "CENTER")
	mmf.mainTab:SetFontString(mmf.mainTab.Text)
	mmf.mainTab:SetSize(mmf.mainTab.Text:GetStringWidth()+10,mmf.mainTab.Text:GetStringHeight()+10)

	-- Routes tab
	mmf.RoutesTab = CreateFrame("Button", "ManMaps_Routes", mmf.mainTab, "UIPanelButtonTemplate")
	mmf.RoutesTab:SetPoint("TOPLEFT", mmf.mainTab, "TOPRIGHT")
	mmf.RoutesTab:SetFrameLevel(mmf:GetFrameLevel()+1)
	mmf.RoutesTab:SetScript("OnClick", function(self, button)
		mmf.sourceScrollFrame:Hide() 
        mmf.destScrollFrame:Hide() end)
	-- Font String
	mmf.RoutesTab.Text = mmf.RoutesTab.Text or mmf:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	mmf.RoutesTab.Text:SetText("Routes")
	mmf.RoutesTab.Text:SetPoint("CENTER", ManMaps_Routes, "CENTER")
	mmf.RoutesTab:SetFontString(mmf.RoutesTab.Text)
	mmf.RoutesTab:SetSize(mmf.RoutesTab.Text:GetStringWidth()+10,mmf.RoutesTab.Text:GetStringHeight()+10)

    
	--------------------------------------
	--------------------------------------
	--         Populating Frames        --
	--------------------------------------
	--------------------------------------
	
    --
    -- Source Scroll Frame
	--
    local NUM_LINES = 20 -- how many cities to display
    local LINE_HEIGHT = 15 -- spacing between city names
	mmf.sourceScrollFrame.sources = {} -- list of source cities
	
	for i=1,NUM_LINES do
		local sourceCity = CreateFrame("Button", "$parentCity"..i, mmf.sourceScrollFrame, "UIPanelButtonTemplate")
        sourceCity:SetHeight(LINE_HEIGHT)
        sourceCity:SetWidth(mmf.sourceScrollFrame:GetWidth())
		sourceCity:SetPoint("TOPLEFT", 0, -(i-1)*LINE_HEIGHT-4)
        -- disable the button until it is needed
        sourceCity:Disable()
        -- removes the button background
        sourceCity:DisableDrawLayer("BACKGROUND")
		mmf.sourceScrollFrame.sources[i] = sourceCity
		
	end
	


    mmf.sourceScrollFrame:SetScript("OnShow", mmf.SourceScrollFrameUpdate)
    mmf.sourceScrollFrame:SetScript("OnVerticalScroll", function(self, offset)
        FauxScrollFrame_OnVerticalScroll(self, offset, LINE_HEIGHT, mmf.SourceScrollFrameUpdate)
    end)
	
	
    function mmf.SourceScrollFrameUpdate()
        local offset = FauxScrollFrame_GetOffset(mmf.sourceScrollFrame)
        FauxScrollFrame_Update(mmf.sourceScrollFrame, #aTable.sortedCities, NUM_LINES, LINE_HEIGHT)
        
        for i=1, NUM_LINES do
            local idx = offset+i
            local button = mmf.sourceScrollFrame.sources[i]
            
            if idx <= #aTable.sortedCities then
                -- button was disable on creation until ready to be used
                button:Enable()
                button:SetScript("OnClick", function(self, button)
                    selectedCity = aTable.sortedCities[idx]
                    mmf.DestScrollFrameUpdate(selectedCity)
                    end)
                button.text = button:GetFontString() or button:CreateFontString(nil,"ARTWORK","GameFontNormal")
                button.text:SetPoint("LEFT", button, "LEFT", 6, 0)
                button.text:SetWidth(mmf.sourceScrollFrame:GetWidth()-10)
                button.text:SetJustifyH("LEFT")
                button.text:SetWordWrap(false)
                button.text:SetText(aTable.sortedCities[idx])
                button.text:SetTextColor(1,.7,0,1)
                button:Show()
            else
                button:Hide()
            end
        end
    end
    
    
    --
    -- Destination Scroll Frame
	--
    local NUM_LINES = 20 -- how many cities to display
    local LINE_HEIGHT = 15 -- spacing between city names
	mmf.destScrollFrame.destinations = {} -- list of destination cities
	
	for i=1,NUM_LINES do
		local destCity = CreateFrame("Button", "$parentCity"..i, mmf.destScrollFrame, "UIPanelButtonTemplate")
        destCity:SetHeight(LINE_HEIGHT)
        destCity:SetWidth(mmf.destScrollFrame:GetWidth())
		destCity:SetPoint("TOPLEFT", 6, -(i-1)*LINE_HEIGHT-4)
        -- removes the button background
        destCity:DisableDrawLayer("BACKGROUND")
        -- disable the button until it is needed
        destCity:Disable()
		mmf.destScrollFrame.destinations[i] = destCity
	end
	


    --mmf.destScrollFrame:SetScript("OnShow", mmf.DestScrollFrameUpdate)
    mmf.destScrollFrame:SetScript("OnVerticalScroll", function(self, offset)
        FauxScrollFrame_OnVerticalScroll(self, offset, LINE_HEIGHT, mmf.DestScrollFrameUpdate)
    end)
	
	
    function mmf.DestScrollFrameUpdate(source)
        local offset = FauxScrollFrame_GetOffset(mmf.destScrollFrame)
        --FauxScrollFrame_Update(mmf.destScrollFrame, #aTable.sortedPaths, NUM_LINES, LINE_HEIGHT)
        -- debugg print when clicking dest city
        --print("--------")
        --print(source)
        local paths = aTable.arrayToTable(aTable.paths[source])
        
        if paths ~= nil then
            for i=1, NUM_LINES do
                local idx = offset+i
                local button = mmf.destScrollFrame.destinations[i]
                
                if idx <= #paths then
                    button:SetScript("OnClick", function(self, button)
                        selectedCity = paths[idx]
                        mmf.DestScrollFrameUpdate(selectedCity) end)
                    button.text = button:GetFontString() or button:CreateFontString(nil,"ARTWORK","GameFontNormal")
                    button.text:SetPoint("LEFT", button, "LEFT")
                    button.text:SetWidth(mmf.destScrollFrame:GetWidth()-10)
                    button.text:SetJustifyH("LEFT")
                    button.text:SetWordWrap(false)
                    button.text:SetText(paths[idx])
                    button.text:SetTextColor(1,.7,0,1)
                    button.tooltipText = "Hello"
                    -- button was disable on creation until ready to be used
                    button:Enable()
                    button:Show()
                else
                    button:Hide()
                end
            end
        else
            mmf.DestScrollFrameClear()
        end
    end
    
    function mmf.DestScrollFrameClear()
        for i=1, NUM_LINES do
            local button = mmf.destScrollFrame.destinations[i]
            button:Hide()
        end
    end
	
    function mmf.OnEvent(self, event)
        -- sorted table of all the cities
        aTable.sortedCities = aTable.arrayToTable(aTable.cities, 1)
		-- sorted table of paths between cities
        aTable.sortedPaths = aTable.arrayToTable(aTable.paths)
        mmf.sourceScrollFrame.ScrollBar:SetValue(0)
        mmf.SourceScrollFrameUpdate()
        mmf.destScrollFrame.ScrollBar:SetValue(0)
        --mmf.DestScrollFrameUpdate()
    end

    mmf:SetScript("OnEvent", mmf.OnEvent)
    mmf:HookScript("OnShow", mmf.OnEvent)

end


	--------------------------------------
	--------------------------------------
	--          Slash Commands          --
	--------------------------------------
	--------------------------------------
function aTable.slashCommands()
	SLASH_MANMAPS1 = "/manmaps"
	SLASH_MANMAPS2 = "/manmap"
	SLASH_MANMAPS3 = "/mmap"
	SLASH_MANMAPS4 = "/mmaps"
	SlashCmdList["MANMAPS"] = function(message)
		if mmf:IsShown() then mmf:Hide() else mmf:Show() end
	end
end


























