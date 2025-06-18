QuestLink = LibStub("AceAddon-3.0"):NewAddon("QuestLink", "AceConsole-3.0", "AceEvent-3.0")
local QL = LibStub("AceAddon-3.0"):GetAddon("QuestLink")

local linkButtonLoaded = false

QuestLogDetailFrame:HookScript("OnShow", function(self)
    if linkButtonLoaded then return end

    QuestLogDetailFrame.LinkBtn = CreateFrame("Button", "QuestLogDetailFrameDB", QuestLogDetailFrame, "AscenDBbuttonTemplate" )
    QuestLogDetailFrame.LinkBtn:SetPoint("TOP", -35, -45)
    QuestLogDetailFrame.LinkBtn.tooltipTitle = VIEW_ASCENSION_DB
    QuestLogDetailFrame.LinkBtn.tooltipText = "Opens your browser to this quest on https://db.ascension.gg/"
    QuestLogDetailFrame.LinkBtn:Show()
    QuestLogDetailFrame.LinkBtn:SetScript("OnClick", function(self,button)
        if IsControlKeyDown() then
            Internal_CopyToClipboard("https://db.ascension.gg/?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        else
            OpenAscensionDBURL("?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        end
    end)
    linkButtonLoaded = true
end)

local linkButtonLoadedQframe = false

QuestLogFrame:HookScript("OnShow", function(self)
    if linkButtonLoadedQframe then return end

    QuestLogFrame.LinkBtn = CreateFrame("Button", "QuestLogFrameDB", QuestLogFrame, "AscenDBbuttonTemplate")
    QuestLogFrame.LinkBtn:SetPoint("BOTTOMRIGHT", -90, 14)
    QuestLogFrame.LinkBtn:SetText("Open In Db")
    QuestLogFrame.LinkBtn:Show()
    QuestLogFrame.LinkBtn.tooltipTitle = VIEW_ASCENSION_DB
    QuestLogFrame.LinkBtn.tooltipText = "Opens your browser to this quest on https://db.ascension.gg/"
    QuestLogFrame.LinkBtn:SetScript("OnClick", function(self,button)
        if IsControlKeyDown() then
            Internal_CopyToClipboard("https://db.ascension.gg/?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        else
            OpenAscensionDBURL("?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        end
    end)
    linkButtonLoadedQframe = true
end)

local linkButtonLoadedMframe = false

WorldMapQuestScrollFrame:HookScript("OnShow", function(self)
    if linkButtonLoadedMframe then return end

    WorldMapQuestScrollFrame.LinkBtn = CreateFrame("Button", "WorldMapQuestScrollFrameDB", WorldMapQuestScrollFrame, "AscenDBbuttonTemplate" )
    WorldMapQuestScrollFrame.LinkBtn:SetPoint("RIGHT", WorldMapZoomOutButton,110, 0)
    WorldMapQuestScrollFrame.LinkBtn:Show()
    WorldMapQuestScrollFrame.LinkBtn.tooltipTitle = VIEW_ASCENSION_DB
    WorldMapQuestScrollFrame.LinkBtn.tooltipText = "Opens your browser to this quest on https://db.ascension.gg/"
    WorldMapQuestScrollFrame.LinkBtn:SetScript("OnClick", function(self,button)
        if IsControlKeyDown() then
            Internal_CopyToClipboard("https://db.ascension.gg/?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        else
            OpenAscensionDBURL("?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        end
    end)
    linkButtonLoadedMframe = true
end)

--[[
SlashCommand(msg):
msg - takes the argument for the /mysticextended command so that the appropriate action can be performed
If someone types /mysticextended, bring up the options box
]]
local function SlashCommand(msg)
    -- taken from https://antifandom.com/wowwiki-archive/wiki/ItemLink
    local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, reforging, Name = string.find(msg, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
    if Ltype == "item" or Ltype == "spell" or Ltype == "quest" or Ltype == "achievement" then
        OpenAscensionDBURL("?"..Ltype.."="..Id)
    else
        local _, _, text = string.match(msg, [[|H([^:]*):([^|]*)|h(.*)|h]])
        if text then
            text = gsub(text,"%[","")
            text = gsub(text,"%]","")
        else
            text = msg
        end
        OpenAscensionDBURL("?search="..text)
    end
end

function QL:OnEnable()
    --Enable the use of /db to open the loot browser
    SLASH_QUESTLINK1 = "/db"
    SlashCmdList["QUESTLINK"] = function(msg)
        SlashCommand(msg)
    end
end

