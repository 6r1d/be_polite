be_polite = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

-- Settings
dofile(modpath .. "/settings.lua")
-- Utility functions
dofile(modpath .. "/util.lua")
-- Swearing filter
dofile(modpath .. "/swearing_filter.lua")

-- Check if message needs to be blocked
be_polite.filter_message = function(message)
  local match = false
  local return_msg = ""
  local message_lower = string.lower(message)
  local is_exception = false
  -- Ignore chat commands
  if message:sub(1, 1) == "/" then
    is_exception = true
  end
  -- Ignore the answer with a player name, which is online
  local player = minetest.get_player_by_name("singleplayer")
  if player then
    is_exception = true
  end
  -- Ignore words from an exception table
  for _, exception in ipairs(be_polite.exceptions) do
    if message_lower == exception then
      is_exception = true
    end
  end
  -- Check if message should be intercepted
  if not is_exception then
    for _, mask_data in ipairs(be_polite.masks) do
      if message_lower:match(mask_data.pattern) then
        match = true
        return_msg = mask_data.msg
        break
      end
    end
    if be_polite.is_caps_gibberish(message) then
      match = true
      return_msg = "Please do not write in caps."
    end
  end
  -- Tell if message should be intercepted and what to send to the user
  return {match = match, msg = return_msg}
end

-- Intercept messages
minetest.register_on_chat_message(function(name, message)
  -- Tell users they can't shout
  local privs = minetest.get_player_privs(name)
  if not privs.shout then
    minetest.chat_send_player(name, "You can't shout (you don't have shout priv), sorry.")
    return true
  end
  local filter_status = be_polite.filter_message(message)
  local blocked_msg = ""
  if filter_status.match == true then
    -- Tell user if the message was blocked and a reason for that
    blocked_msg = "Attention! Your message was blocked!\n"..filter_status.msg
    minetest.chat_send_player(name, blocked_msg)
    return true
  end
end)

-- Swearing filter
if be_polite.filter_swearing then
  local register_on_message = minetest.register_on_chat_message
  if core.register_on_sending_chat_messages then
    register_on_message = minetest.register_on_sending_chat_messages
  end
  register_on_message(function(name, message)
    local s_start, s_end = be_polite.detect_swearing(message, be_polite.blocked_words)
    if s_start and s_end then
      minetest.chat_send_all(
        be_polite.filter_swearing("<"..name.."> "..message, "random", be_polite.blocked_words)
      )
      return true
    end
  end)
end
