-- github.com/cxmplex

-- global list to merge with session variables
EASYFILTER_DEFAULT_FILTERS = {
  "gteam%.pro"
}

local Presets = {}

Presets["boosting"] = {
  "huokan", "wts.+ny'?a.+mythic", "%sgallywix%s", "freehold.+leveling",
  "boost.+freehold", "wowbop", "freehold.+boost", "wts.+m%s?%+-[%d]+",
  "selling mythic", "with top US guilds", "free.+armor.+stack", "wts.+heroic.+nya",
  "wts.+nya.+heroic", "weekend%sspecial", "wts.+visions.+mask", "wts%s5%smask", "wts.+five mask",
  "wts.+full%s-clear", "wts.+boost", "weekend%sdiscount", "weekend%ssales", "timer guarantee",
  "guaranteed in%s-time", "wts.+pvp.+boost", "wts mythic", "wts 12/12", "wts.+nzoth", "gold%sonly", "only%sgold",
  "<Massive Deals>", "mythic.+specific key", "wts.+specific key", "oblivion boosting", "oblivion community", "nova community", "nova boosting",
  "sylvanas community", "sylvanas boosting", "wts.+curve.+mount", "wts.+aotc.+mount", "armorstack", "lootstack", "selling.+nyalotha.+heroic.+run",
  "m[%s%(%)%[%]%]%d%-+]+.+%d%d%d%s-|-k", "come.+get.+aotc", "come.+get.+ahead of the curve", "wts %d%d.+key", "armor.+stack.+free", "free.+armor.+stack",
  "wts.+cheap.+time", "wts.+stack.+armor", "wts.+loot.+tradeable", "wts.+special.+price", "wts.+discount.+price", "wts.+special.+%d%d%d", "wts.+discount.+%d%d%d", "stack armor"
}

Presets["twitch"] = {
  "twitch%.tv%",
  "[%a%d%-_]+TTV",
  "twitch..-.-tv"
}

Presets["lang"] = {
  "[\227-\237]"
}

local LocalCache = {}
-- iterate all filters, run string find
EasyFilter.FilterText = function(msg)
  -- merge the filter cache (user defined) |
  -- this could be tied to an event instead
  for k, v in pairs(EASYFILTER_FILTER_CACHE) do
    EASYFILTER_DEFAULT_FILTERS[k] = v
  end
  -- run str.find on each filter
  local lMsg = string.lower(msg)
  for _, filter in pairs(EASYFILTER_DEFAULT_FILTERS) do
    if string.find(lMsg, filter) then
      if EASYFILTER_PRINT_MESSAGES and not LocalCache[lMsg] then
        print("Blocking Message: " .. msg)
        LocalCache[lMsg] = 1
      end
      return true
    end
  end
end


EasyFilter.AddPreset = function(preset)
  for _, filter in ipairs(Presets[preset]) do
    EASYFILTER_FILTER_CACHE[filter] = filter
  end
end

EasyFilter.RemovePreset = function(preset)
  for _, filter in ipairs(Presets[preset]) do
    EasyFilter.RemoveByKey(EASYFILTER_FILTER_CACHE, filter)
  end
end
