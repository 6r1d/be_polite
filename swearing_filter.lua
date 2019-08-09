-- Replace swearing
be_polite.filter_swearing = function(input, mode, blocked_words)
  local s_start, s_end
  -- Replace each curse word
  while true do
    s_start, s_end = be_polite.detect_swearing(input, blocked_words)
    if s_start and s_end then
      if mode == 'random' then
        input = input:sub(1, s_start - 1) ..
        random_placeholders(s_end - s_start + 1) ..
        input:sub(s_end + 1)
      elseif mode == 'underscore' then
        input = input:sub(1, s_start - 1) ..
        gen_repeats("_", s_end - s_start + 1) ..
        input:sub(s_end + 1)
      end
    else
      break
    end
    -- Break cycle on empty string
    if not input then break end
  end
  return input
end

-- Returns a start and end index for a curse word, found in input string, or
-- nil, nil
be_polite.detect_swearing = function(input, blocked_words)
  local s_start, s_end = nil
  local input_lower = input:lower()
  for _, word in ipairs(blocked_words) do
    s_start, s_end = input:find(word)
    if s_start and s_end then
      break
    end
  end
  return s_start, s_end
end

function random_placeholders(length)
  math.randomseed(os.time())
  if length > 0 then
    return random_placeholders(length - 1) ..
    be_polite.placeholder_charset[math.random(1, #be_polite.placeholder_charset)]
  else
    return ""
  end
end

-- Repeats an input string N times
function gen_repeats(input, n)
  return n > 0 and input .. gen_repeats(input, n - 1) or ""
end
