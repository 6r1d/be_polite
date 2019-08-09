-- Checks if string contains a text written in caps;
-- doesn't need to check length, since there are start and end markers.
-- Unhandled case: UnHaNdLeD
be_polite.is_caps_gibberish = function(input)
    if string.match(input, '^[%u%d%s%.%?%!%;]+$') then
       return true
    else
       return false
    end
end
