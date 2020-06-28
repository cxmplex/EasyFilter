-- github.com/cxmplex

EasyFilter.RemoveByKey = function(tab, val)
  for i, v in ipairs (tab) do
    if (v.id == val) then
      tab[i] = nil
    end
  end
end

-- this is a bit tricky.
EasyFilter.ValidateRegex = function(regex)
  -- determine lower bounds of boundary
  -- and the character to the immediate left (context)
  _, _, context, boundary, limit = string.find(regex, "(.){(%d+),%s-(%d-)}")
  if limit then limit = "+" else limit = "" end
  if boundary and boundary == 0 then
    res, _ = regex:gsub("{(%d+),%s-%d-}", "")
    regex = res
  end
  if context and boundary then
    -- closing a character class
    if context == "]" then
      _, _, class = string.find(regex, "(%[.+%]){%d+,%s-%d-}")
      if not class then return false end
      local appendedClass = ""
      -- repeat the class low bound times
      for i = 1, boundary do
        appendedClass = appendedClass .. class
      end
      res, _ = regex:gsub("%[.+%]{%d+,%s-%d-}", appendedClass .. limit)
      regex = res
      -- closing a capture group
    elseif context == ")" then
      _, _, group = string.find(regex, "(%(.+%)){%d+,%s-%d-}")
      if not group then return false end
      local appendedBoundary = ""
      -- repeat the class low bound times
      for i = 1, boundary do
        appendedBoundary = appendedBoundary .. group
      end
      res, _ = regex:gsub("%(.+%){%d+,%s-%d-}", appendedBoundary .. limit)
      regex = res
    elseif context == '.' then
      local appendedContext = ""
      for i = 1, boundary do
        appendedContext = appendedContext .. context
      end
      res, _ = regex:gsub("(.){(%d+),%s-%d-}", appendedContext .. limit)
      regex = res
    end
  end
  res, _ = regex:gsub("%+%?", "-")
  if res then regex = res end
  return regex
end
