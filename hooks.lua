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
  if not FilterText(msg) then
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
  for k, v in pairs EASYFILTER_FILTER_CACHE do
    EASYFILTER_DEFAULT_FILTERS[k] = v
  end
end

-- register our OnEvent
frame:SetScript("OnEvent", frame.OnEvent)

-- create cmd filter
SLASH_EASYFILTER = "/ef"
function SlashCmdList.EASYFILTER(msg)
  -- parse chat message for command, and arguments
  local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
  if cmd == "add" then
    EASYFILTER_FILTER_CACHE[tostring(GetTime())] = args[0]
    return true
  end
  print("You entered an invalid command!")
end
