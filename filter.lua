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
  "<Massive Deals>", "specific keys (%()?%d+k(%))?", "oblivion boosting", "oblivion community", "nova community", "nova boosting",
  "sylvanas Community", "sylvanas boosting", "wts.+curve.+mount", "wts.+aotc.+mount", "armorstack", "lootstack", "selling.+nyalotha.+heroic.+run",
  "m[%s%(%)%[%]%]%d%-+]+.+%d%d%d[%s%|k]", "come.+get.+aotc", "come.+get.+ahead of the curve", "wts %d%d.+key", "armor.+stack.+free", "free.+armor.+stack",
  "wts.+cheap.+time"
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
    res = EasyFilter.ValidateRegex(filter)
    if not res then return end
    EASYFILTER_FILTER_CACHE[res] = res
  end
end

EasyFilter.RemovePreset = function(preset)
  for _, filter in ipairs(Presets[preset]) do
    res = EasyFilter.ValidateRegex(filter)
    EasyFilter.RemoveByKey(EASYFILTER_FILTER_CACHE, res)
  end
end
