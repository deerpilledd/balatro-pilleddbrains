SMODS.Atlas{
    key = "bl_dp_riot",
    path = "bl_dp_riot.png",
    px = 0,
    py = 0,
}

SMODS.Blind{
    key = "bl_dp_riot",
    atlas = "bl_dp_riot",
    mult = 3, 
    dollars = 7,
    boss = { showdown = true },
    boss_colour = HEX('03FCF4'),
    debuff = { hand = {['Four of a Kind'] = true}, h_size_le = 4, suit = 'Hearts', suit = 'Clubs', value = 13, value = 12, },

    loc_vars = function(self)
        return {key = self.key}
    end
}