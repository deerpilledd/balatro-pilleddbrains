SMODS.Atlas({
    key = "s_apex",
    path = "s_apex.png",
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Consumable{
    key = "s_apex",
    set = 'Spectral',
    config = { },
    atlas = "s_apex",
    pos = {x = 0, y = 0},
    cost = 5,
    soul_pos = { x = 0, y = 1},
    hidden = true,
    soul_set = 'Tarot', 
    soul_rate = 0.01,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = "dp_apex" })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}