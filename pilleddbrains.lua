pilleddbrains = {}

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true
}

assert(SMODS.load_file("globals.lua"))()
assert(SMODS.load_file("resources/rarities.lua"))()
assert(SMODS.load_file("resources/backs.lua"))()
assert(SMODS.load_file("resources/blind.lua"))()
assert(SMODS.load_file("resources/jokers.lua"))()