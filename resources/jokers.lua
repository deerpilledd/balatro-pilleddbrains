
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
    path = "j_sample_multieffect.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "tos_monarch",
    path = "j_sample_rarebaseballcard.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "wild_redseal",
    path = "BlankCard.png",
    px = 69,
    py = 93,
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
        if context.scoring_hand and context.cardarea == G.play and G.GAME.current_round.hands_left == 0 then
            local enhanced = {}
            local stoned = {}
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center ~= G.P_CENTERS.m_stone and not v.debuff and not v.stoned then
                    enhanced[#enhanced+1] = v
                    v.stoned = true 
                    v:set_ability(G.P_CENTERS.m_stone, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            v.stoned = nil
                            return true
                            end
                        }))
                    end
            if #enhanced > 0 then
                return {extra = {focus = card, message = localize('dp_stoned_ex')}, colour = G.C.MULT, true}
                end
            end

                if context.joker_main then
                    return {
                        colour = G.C.RED,
                        x_mult = card.ability.extra.x_mult,
                    }
                end

            if context.individual and context.cardarea == G.play then 
                if context.other_card.ability.name == "Stone Card" and not context.blueprint then
                        card.ability.extra.x_mult_mod = 0.2
                        card.ability.extra.x_mult = (card.ability.extra.x_mult + card.ability.extra.x_mult_mod)

                        return {
                            extra = {focus = card, message = localize('k_upgrade_ex')},
                            colour = G.C.MULT,
                        }
                    else
                        return nil, true
                    end
                end
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
    rarity = 4,
    cost = 20,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'tos_monarch',
    soul_pos = nil,

    calculate = function(self, card, context)
        if not context.blueprint and context.consumeable.ability.set == "Tarot" then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    local card = create_card('Tarot_Planet', G.consumeables, nil, nil, nil, nil, G.GAME.last_tarot_planet, 'fool')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    return true
                    end
                }))
            end
        end
    end,
    
    loc_vars = function(self, info_queue, card)
        return { }
    end
}

SMODS.Joker{
    key = "wild_redseal",
    config = { },
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'wild_redseal',
    soul_pos = nil,

	calculate = function(self, card, context)
        if context.end_of_round then 
            return {
                remove = true,
            }
        end
    end
}