# Be polite
This is a [Minetest](http://minetest.net) mod
that prevents people from shouting useless things like "help" globally.

Pull requests are welcome! Please add new messages to the filter and tell me
if you have ideas about improving it. It is not regex-based
and for now I am not adding regex library.

# Plans
- [x] Add filter for all-caps, question signs and exclamation points
- [x] Add swearing filter
- [x] Add settings
- [x] Ignore player names (for online players, because it's simple to do)
- [ ] Detect RaNdOm case messages
- [ ] Detect messages without whitespaces and random mix of characters
- [ ] Integrate with Beerchat, so it doesn't break anything (I'm concerned about the swearing filter sending messages)
