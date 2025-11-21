return {
    descriptions = {
        Blind = {
            bl_dp_riot = {
                name = "The Riot",
                text = {
                    "No Kings, Queens, Four of a Kind",
                    "Must play less than 5 cards,",
                    "No Hearts or Clubs.",
                },
            },
        },

        Joker = {
            j_dp_tos_medusa = {
                name = "Medusa",
                text = {
                    {
                        "On {C:attention}final hand{} of round, turns all",
                        "scored cards into {C:attention}Stone{} cards.",
                        "per every {C:attention}Stone{} card scored,",
                        "this Joker gains {X:mult,C:white} X#1# {} Mult",
                        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive})",
                    },
                },
            },
            j_dp_tos_monarch = {
                name = "Monarch",
                text = {
                    {
                        "Creates a copy of",
                        "the last used {C:tarot}Tarot{} card.",
                        "{s:0.8,C:dark_edition,E:1}Only once though, Use wisely.{}",
                    },
                },
            },
            j_dp_wild_redseal = {
                name = "Red Seal",
                text = {
                    {
                        "{E:1,C:dark_edition}Retriggers all cards.{}",
                        "{s:0.8,C:green}Played and Held in hand."
                    },
                },
            },
            j_dp_xm_simple = {
                name = "Simpleton",
                text = {
                    {
                        "{s:1.3,C:edition,E:1,X:mult} X#1#{} {s:1.3,E:1}Mult{}"
                    },
                },
            },
            j_dp_jk_cellshaggy = {
                name = "Shaggy From Fortnite",
                text = {
                    {
                        "Create a random {C:attention}Joker{}",
                        "when {C:attention}Blind{} is selected",
                        "{s:0.6,E:0.5,C:transparent}Like Zoinks Scoob! They're Clowns!{}",
                        "{s:0.9,C:transparent}(Must have room){}",
                    },
                },
            },
        },
    },
    misc = {

            -- do note that when using messages such as: 
            -- message = localize{type='variable',key='a_xmult',vars={current_xmult}},
            -- that the key 'a_xmult' will use provided values from vars={} in that order to replace #1#, #2# etc... in the localization file.
            -- what the fuck does this mean

        dictionary = {
            a_chips="+#1#",
            a_chips_minus="-#1#",
            a_hands="+#1# Hands",
            a_handsize="+#1# Hand Size",
            a_handsize_minus="-#1# Hand Size",
            a_mult="+#1# Mult",
            a_mult_minus="-#1# Mult",
            a_remaining="#1# Remaining",
            a_sold_tally="#1#/#2# Sold",
            a_xmult="X#1# Mult",
            a_xmult_minus="-X#1# Mult",
            dp_stoned_ex="Stoned!",
            dp_zoinks_ex="Zoinks!",
        },

        v_dictionary = {
			a_xchips = { "X#1# Chips" },
            a_xchips_minus = { "-X#1# Chips" },
			a_powchips = { "^#1# Chips" },
            a_powchips_minus = { "-^#1# Chips" },
			a_powmult = { "^#1# Mult" },
            a_powmult_minus = { "-^#1# Mult" },
			a_powmultchips = { "^#1# Mult+Chips" },
			a_powmultchips_minus = { "-^#1# Mult+Chips" },
			a_round_minus = { "-#1# Round" },
			a_tag_minus = { "-#1# Tag" },
			a_tags_minus = { "-#1# Tags" },
			a_tag = { "+#1# Tag" },
			a_tags = { "+#1# Tags" },
        }
    }
}