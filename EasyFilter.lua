-- github.com/cxmplex

local chat_events = {
  "CHAT_MSG_SAY",
  "CHAT_MSG_YELL",
  "CHAT_MSG_CHANNEL",
  "CHAT_MSG_TEXT_EMOTE",
  "CHAT_MSG_WHISPER"
}

local function chatHook(self, event, msg)
  EvalText(msg)
end

for _, v in pairs(chat_events) do
  ChatFrame_AddMessageEventFilter(v, chatHook)
end
