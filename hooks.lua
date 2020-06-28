-- github.com/cxmplex

-- register chat event hooks
local chat_events = {
  "CHAT_MSG_SAY",
  "CHAT_MSG_YELL",
  "CHAT_MSG_CHANNEL",
  "CHAT_MSG_TEXT_EMOTE",
  "CHAT_MSG_WHISPER"
}

-- call filter.lua:FilterText for evaluation
local function chatEventHook(self, event, msg)
  if EasyFilter.FilterText and EasyFilter.FilterText(msg) then
    return true
  end
end

for _, v in pairs(chat_events) do
  ChatFrame_AddMessageEventFilter(v, chatEventHook)
end

-- detect when saved variables (filters) are loaded
local frame = CreateFrame("FRAME")
frame:RegisterEvent("ADDON_LOADED")

-- no need to filter event as we're only registering one
function frame:OnEvent(...)
  -- if this event hook is called, then sessionvariables have been loaded
  if not EASYFILTER_FILTER_CACHE then
    EASYFILTER_FILTER_CACHE = {}
  end
  EASYFILTER_PRINT_MESSAGES = true
end

-- register our OnEvent
frame:SetScript("OnEvent", frame.OnEvent)

-- create cmd filter
SLASH_EASYFILTER1 = "/ef"
SlashCmdList["EASYFILTER"] = function (msg)
  -- parse chat message for command, and arguments
  local _, _, cmd, regex = string.find(msg, "%s?(%w+)%s?(.*)")
  if cmd == "add" then
    local res = EasyFilter.ValidateRegex(regex)
    if res then
      EASYFILTER_FILTER_CACHE[res] = res
    else
      print("Failed to parse entry " .. regex)
    end
    return true
  end
  if cmd == "silence" then
    EASYFILTER_PRINT_MESSAGES = false
    return true
  end
  if cmd == "del" then
    if EASYFILTER_FILTER_CACHE[regex] then
      EasyFilter.RemoveByKey(EASYFILTER_FILTER_CACHE, regex)
    else
      print("Unable to find this entry!")
    end
    return true
  end

  if cmd == "enablepreset" then
    EasyFilter.AddPreset(regex)
    return true
  end
  if cmd == "disablepreset" then
    EasyFilter.RemovePreset(regex)
    return true
  end
  print("You entered an invalid command!")
end
