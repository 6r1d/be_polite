be_polite.filter_swearing = true
be_polite.filter_caps = true
be_polite.xp_threshold = 10000

-- Filtered messages and answers
be_polite.masks = {
    {
        pattern="^help$",
        msg="Please explain what you need and, if possible, who are you asking for help."
    },
    {
        pattern="^help me$",
        msg="Please explain what you need and, if possible, who are you asking for help."
    },
    {
        pattern="^where are you$",
        msg="Please mention who you are asking, or send a personal message."
    },
    {
        pattern="^come$",
        msg="Please mention who you are asking, or send a personal message."
    },
    --{
    --    pattern="^come$",
    --    msg="Please mention who you are asking, or send a personal message."
    --},
    --{
    --    pattern="^come here$",
    --    msg="Please mention who you are asking, or send a personal message."
    --},
}

be_polite.exceptions = {
    "tp me", "ok"
}

-- Curse words
local blocked_words = {
  'ass', 'asshole', 'bastard', 'bitch', 'bitching', 'cunt', 'dick', 'jerk', 'kike',
  'nigga', 'nigger', 'pussy', 'shit', 'shitting', 'fag', 'faggot',
  'fuck', 'fucking'
}

-- Placeholder characters
be_polite.placeholder_charset = {'!', '@', '#', '$', '%', '^', '&', '*'}

-- Sort the curse table by length,
-- so longer words are replaced in the beginning.
table.sort(blocked_words, function(a, b) return #a > #b end)
-- Register
be_polite.blocked_words = blocked_words
