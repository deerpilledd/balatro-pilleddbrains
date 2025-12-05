
-- you can have shared helper functions
function shakecard(self) --visually shake a card
    G.E_MANAGER:add_event(Event({
        func = function()
            self:juice_up(0.5, 0.5)
            return true
        end
    }))
end

function return_JokerValues() -- not used, just here to demonstrate how you could return values from a joker
    if context.joker_main and context.cardarea == G.jokers then
        return {
            chips = card.ability.extra.chips,       -- these are the 3 possible scoring effects any joker can return.
            mult = card.ability.extra.mult,         -- adds mult (+)
            x_mult = card.ability.extra.x_mult,     -- multiplies existing mult (*)
            card = self,                            -- under which card to show the message
            colour = G.C.CHIPS,                     -- colour of the message, Balatro has some predefined colours, (Balatro/globals.lua)
            message = localize('k_upgrade_ex'),     -- this is the message that will be shown under the card when it triggers.
            extra = { focus = self, message = localize('k_upgrade_ex') }, -- another way to show messages, not sure what's the difference.
        }
    end
end

SMODS.Atlas({
    key = "tos_medusa",
    path = "blankcard.png",
    px = 71,
    py = 95,
})

SMODS.Atlas({
    key = "tos_monarch",
    path = "j_monarch.png",
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "wild_redseal",
    path = "j_redseal.png",
    px = 71,
    py = 95,
})

SMODS.Atlas({
    key = "jk_simple",
    path = "blankcard.png",
    px = 71,
    py = 95,
})

SMODS.Atlas({
    key = "jk_cellshaggy",
    path = "j_cellshaggy.png",
    px = 71,
    py = 95,
})

SMODS.Atlas({
    key = "jk_exposed",
    path = "j_exposed.png",
    px = 71,
    py = 95,
})

SMODS.Atlas({
    key = "rsb",
    path = "blankcard.png",
    px = 71,
    py = 95,
})

SMODS.Joker{
    key = "tos_medusa",
    config = { extra = { x_mult = 1, x_mult_mod = 0.2 }},
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'tos_medusa',
    soul_pos = nil,

    calculate = function(self, card, context)
            if context.joker_main then
                return {
                    colour = G.C.RED,
                    x_mult = card.ability.extra.x_mult,
                }
            end
        if context.individual and context.cardarea == G.play and context.other_card.ability.name == "Stone Card" and not context.blueprint then
            card.ability.extra.x_mult_mod = 0.2
            card.ability.extra.x_mult = (card.ability.extra.x_mult + card.ability.extra.x_mult_mod)

            return {
                extra = {focus = card, message = localize('k_upgrade_ex')},
                colour = G.C.MULT,
            }
        end 
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return { 
            vars = { card.ability.extra.x_mult_mod, card.ability.extra.x_mult }, 
            key = self.key,
        }
    end
}

SMODS.Joker{
    key = "tos_monarch",
    config = { },
    pos = { x = 0, y = 0 },
    rarity = "dp_apex",
    cost = 40,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'tos_monarch',
    soul_pos = { x = 0, y = 1, },

    calculate = function(self, card, context)
        if context.using_consumeable and G.consumeables.cards[0] then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local card_to_copy, _ = G.GAME.last_tarot_planet
                    local copied_card = copy_card(card_to_copy)
                    copied_card:set_edition("e_negative", true)
                    copied_card:add_to_deck()
                    G.consumeables:emplace(copied_card)
                    return true
                end
            }))
            return { message = localize('k_duplicated_ex') }
        end
    end,
    
    loc_vars = function(self, info_queue, card)
        return { }
    end
}

SMODS.Joker{
    key = "wild_redseal",
    config = { extra = {repetitions = 1}},
    pos = { x = 0, y = 0 },
    rarity = "dp_apex",
    cost = 40,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'wild_redseal',
    soul_pos = nil,

	calculate = function(self, card, context)
        if context.other_joker and context.other_joker.label == 'dp_wild_redseal' then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end

        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end

        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}

SMODS.Joker{
    key = "jk_simple",
    config = { extra = {x_mult = 1} },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 7, 
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true, 
    discovered = true,  
    effect = nil,
    atlas = "jk_simple",
    soul_pos = nil,

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.x_mult },
            key = self.key,
            }
        end,

    calculate = function(self, card, context)
        if context.joker_main then 
            card.ability.extra.x_mult = 1
            return {
                colour = G.C.MULT,
                x_mult = card.ability.extra.x_mult,
                balance = true
            }
        end
    end
}

SMODS.Joker{
    key = "jk_cellshaggy",
    config = { extra = {creates = 1} },
    rarity = 2,
    cost = 7, 
    unlocked = true,
    discovered = true,
    pos = { x = 0, y = 0},
    atlas = "jk_cellshaggy",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.creates } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.creates,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            key_append = 'dp_jk_cellshaggy'
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('dp_zoinks_ex'),
                colour = G.C.BLUE,
            }
        end
    end
}

SMODS.Joker{
    key = "jk_exposed",
    config = { extra = {dollars = 1, odds = 6} },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    pos = { x = 0, y = 0 },
    atlas = "jk_exposed",

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'dp_jk_exposed') 
        return { vars = { card.ability.extra.dollars, numerator, denominator } }   
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss
            and SMODS.pseudorandom_probability(card, 'dp_jk_exposed', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.blind:disable()
                                return true
                            end
                        }))
                        SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                        return true
                    end
                }))
            end
        end
}

SMODS.Joker{
    key = "rsb",
    config = { extra = {h_size = 0, h_mod = 1}},
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    pos = { x = 0, y = 0 },
    atlas = "rsb",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size, card.ability.extra.h_mod } }
    end,

    calculate = function(self, card, context)
        if context.playing_card_added and not context.blueprint then
            card.ability.extra.h_size = card.ability.extra.h_size + #context.cards * card.ability.extra.h_mod
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
            }
        end
        if context.remove_playing_cards and not context.blueprint then  
            cardarea = G.hand
	        scoring_hand = scoring_hand
    	    remove_playing_cards = true
	        removed = cards_destroyed
            card.ability.extra.h_size = card.ability.extra.h_size - 2
        end
    end
}