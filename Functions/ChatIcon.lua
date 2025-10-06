-- Chat Icon functionality for Ultra Hardcore
-- Adds icons to chat messages based on the number of active options

-- Function to count active options from GLOBAL_SETTINGS
local function CountActiveOptions()
    local count = 0
    for key, value in pairs(GLOBAL_SETTINGS) do
        if value == true then
            count = count + 1
        end
    end
    return count
end

-- Function to determine icon color based on active option count
local function GetIconForActiveOptions()
    local activeCount = CountActiveOptions()
    
    -- Green for <5 options, Red for all options (19 total), Yellow for in between
    if activeCount < 5 then
        return "🟢" -- Green circle
    elseif activeCount >= 19 then
        return "🔴" -- Red circle  
    else
        return "🟡" -- Yellow circle
    end
end

-- Hook into the SendChatMessage function to add icons
local originalSendChatMessage = SendChatMessage
SendChatMessage = function(message, chatType, language, channel)
    -- Only add icon to player messages (not system messages)
    if chatType == "SAY" or chatType == "YELL" or chatType == "EMOTE" or 
       chatType == "PARTY" or chatType == "RAID" or chatType == "GUILD" or
       chatType == "CHANNEL" then
        
        local icon = GetIconForActiveOptions()
        local modifiedMessage = icon .. " " .. message
        return originalSendChatMessage(modifiedMessage, chatType, language, channel)
    else
        return originalSendChatMessage(message, chatType, language, channel)
    end
end

-- Function to get current icon status (for debugging/testing)
function GetChatIconStatus()
    local activeCount = CountActiveOptions()
    local icon = GetIconForActiveOptions()
    return {
        activeOptions = activeCount,
        totalOptions = 19,
        icon = icon,
        status = activeCount < 5 and "Low" or (activeCount >= 19 and "Maximum" or "Medium")
    }
end

-- Add slash command for testing
SLASH_CHATICON1 = "/chaticon"
SlashCmdList["CHATICON"] = function()
    local status = GetChatIconStatus()
    print(string.format("|cFF00FF00[Ultra Hardcore]|r Chat Icon Status: %s (%d/%d active options)", 
          status.status, status.activeOptions, status.totalOptions))
end
