QuestLink = LibStub("AceAddon-3.0"):NewAddon("QuestLink", "AceConsole-3.0", "AceEvent-3.0")
local QL = LibStub("AceAddon-3.0"):GetAddon("QuestLink")

local linkButtonLoaded = false;

QuestLogDetailFrame:HookScript("OnShow", function(self)
    if linkButtonLoaded then return end

    QuestLogDetailFrame.LinkBtn = CreateFrame("Button", nil, QuestLogDetailFrame, "OptionsButtonTemplate");
    QuestLogDetailFrame.LinkBtn:SetPoint("TOP", -35, -45);
    QuestLogDetailFrame.LinkBtn:SetSize(100,20);
    QuestLogDetailFrame.LinkBtn:SetText("Open In Db");
    QuestLogDetailFrame.LinkBtn:Show();
    QuestLogDetailFrame.LinkBtn:SetScript("OnClick", function(self,button)
        if IsControlKeyDown() then
            Internal_CopyToClipboard("https://db.ascension.gg/?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        else
            OpenAscensionDBURL("?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        end
    end);
    linkButtonLoaded = true;
end);

local linkButtonLoadedQframe = false;

QuestLogFrame:HookScript("OnShow", function(self)
    if linkButtonLoadedQframe then return end

    QuestLogFrame.LinkBtn = CreateFrame("Button", nil, QuestLogFrame, "OptionsButtonTemplate");
    QuestLogFrame.LinkBtn:SetPoint("BOTTOMRIGHT", -90, 14);
    QuestLogFrame.LinkBtn:SetSize(100,20);
    QuestLogFrame.LinkBtn:SetText("Open In Db");
    QuestLogFrame.LinkBtn:Show();
    QuestLogFrame.LinkBtn:SetScript("OnClick", function(self,button)
        if IsControlKeyDown() then
            Internal_CopyToClipboard("https://db.ascension.gg/?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        else
            OpenAscensionDBURL("?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        end
    end);
    linkButtonLoadedQframe = true;
end);

local linkButtonLoadedMframe = false;

WorldMapQuestScrollFrame:HookScript("OnShow", function(self)
    if linkButtonLoadedMframe then return end

    WorldMapQuestScrollFrame.LinkBtn = CreateFrame("Button", nil, WorldMapQuestScrollFrame, "OptionsButtonTemplate");
    WorldMapQuestScrollFrame.LinkBtn:SetPoint("RIGHT", WorldMapZoomOutButton,110, 0);
    WorldMapQuestScrollFrame.LinkBtn:SetSize(110,21);
    WorldMapQuestScrollFrame.LinkBtn:SetText("Open In Db");
    WorldMapQuestScrollFrame.LinkBtn:Show();
    WorldMapQuestScrollFrame.LinkBtn:SetScript("OnClick", function(self,button)
        if IsControlKeyDown() then
            Internal_CopyToClipboard("https://db.ascension.gg/?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        else
            OpenAscensionDBURL("?quest="..select(9,GetQuestLogTitle(GetQuestLogSelection())))
        end
    end);
    linkButtonLoadedMframe = true;
end);

--[[
SlashCommand(msg):
msg - takes the argument for the /mysticextended command so that the appropriate action can be performed
If someone types /mysticextended, bring up the options box
]]
local function SlashCommand(msg)
    OpenAscensionDBURL("?search="..msg)
end

function QL:OnEnable()
    --Enable the use of /db to open the loot browser
    SLASH_QUESTLINK1 = "/db";
    SlashCmdList["QUESTLINK"] = function(msg)
        SlashCommand(msg);
    end
end

