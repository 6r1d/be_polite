local placeholder_charset = {'!','@','#','$','%','^','&','*'}

function string.random(length)
  math.randomseed(os.time())

  if length > 0 then
    return string.random(length - 1) .. placeholder_charset[math.random(1, #placeholder_charset)]
  else
    return ""
  end
end
