be_polite = {}

local has_xp_redo_mod = minetest.get_modpath("xp_redo")

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

-- Filtered messages and answers
be_polite.masks = {
    {
        pattern="help",
        msg="Please explain what you need and, if possible, who are you asking for help."
    },
    {
        pattern="HELP",
        msg="Please explain what you need and, if possible, who are you asking for help."
    },
    {
        pattern="help me",
        msg="Please explain what you need and, if possible, who are you asking for help."
    },
    {
        pattern="where are you",
        msg="Please mention who you are asking, or send a personal message."
    },
    {
        pattern="come",
        msg="Please mention who you are asking, or send a personal message."
    },
    {
        pattern="come here",
        msg="Please mention who you are asking, or send a personal message."
    },
}

-- Check if message needs to be blocked
local filter_message = function(message)
    local match = false
    local return_msg = ""
    local message_lower = string.lower(message)
    for _, mask_data in ipairs(be_polite.masks) do
        -- print("Matching '"..message_lower.."' with "..mask_data.pattern)
	if message_lower:match(mask_data.pattern) then
            match = true
            return_msg = mask_data.msg
            -- print('Match!')
            break
        end
    end
    return {match=match, msg=return_msg}
end

minetest.register_on_chat_message(function(name, message)
    -- only filter chat messages from players with certain xp-points (if the xp-redo mod is installed)
    if has_xp_redo_mod then
        local xp = xp_redo.get_xp(name)
        -- TODO: maybe put this in a setting
        if xp > 10000 then
            -- experienced player (should be anyways): don't filter message
            return false
        end
    end
    local filter_status = filter_message(message)
    local blocked_msg = ""
    if filter_status.match == true then
        -- "Message blocked"
        blocked_msg = "Attention! Your message was blocked!\n"..filter_status.msg
        minetest.chat_send_player(name, blocked_msg)
        return true
    end
end)
