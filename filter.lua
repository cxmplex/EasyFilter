-- github.com/cxmplex

-- global list to merge with session variables
EASYFILTER_DEFAULT_FILTERS = {
  "gteam\.pro"
}

local LocalCache = {}
-- iterate all filters, run string find
FilterText = function(msg)
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
