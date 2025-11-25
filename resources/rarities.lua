SMODS.Rarity {
    key = "legendary",
    default_weight = 0.001,
    badge_colour = HEX("b26cbb"),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "dp_apex",
    default_weight = 0,
    badge_colour = HEX("FF0000"),
    pools = { ["Joker"] = true, },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}