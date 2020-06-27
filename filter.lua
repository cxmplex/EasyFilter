-- github.com/cxmplex

-- global list to merge with session variables
EASYFILTER_DEFAULT_FILTERS = {
  "gteam\.pro"
}

local LocalCache = {}
-- iterate all filters, run string find
FilterText = function(msg)
  for k, v in pairs(EASYFILTER_FILTER_CACHE) do
    EASYFILTER_DEFAULT_FILTERS[k] = v
  end
  local lMsg = string.lower(msg)
  for _, filter in pairs(EASYFILTER_DEFAULT_FILTERS) do
    if string.find(lMsg, filter) then
      if EASYFILTER_PRINT_MESSAGES and not LocalCache[lMsg] then
        print("Blocking Message: " .. msg)
        LocalCache[lMsg] = 1
      end
      return True
    end
  end
end
