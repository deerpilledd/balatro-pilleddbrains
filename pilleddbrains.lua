pilleddbrains = {}

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
	-- Here are some other ones Steamodded has
	-- Cryptid doesn't use them YET, but these should be uncommented if Cryptid uses them
	-- These ones add new card areas that Steamodded will calculate through
	-- Might already be useful for sticker calc

	-- Cryptid uses cardarea deck now
	cardareas = {
		deck = true,
		discard = true, -- used by scorch
	},
}

assert(SMODS.load_file("globals.lua"))()

-- Jokers
local joker_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "resources")
for _, file in ipairs(joker_src) do
    assert(SMODS.load_file("resources/" .. "jokers.lua"))()
end

local blind_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "resources")
for _, file in ipairs(blind_src) do
    assert(SMODS.load_file("resources/" .. "blind.lua"))()
end