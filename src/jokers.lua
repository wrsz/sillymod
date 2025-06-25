SMODS.Joker {
    key = "fong_joker",
    unlocked = true,
    discovered =true,
    loc_txt = {name= "Cael Fong", text = {"{C:blue}+#2#{} Chips","{C:red}+#1#{} Mult"}},
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    cost = 4,
    rarity = 1,
    pos = { x = 0, y = 0 },
    config = {extra = {mult = 12, chips = 43}},
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return{
            vars = {
            card.ability.extra.mult,
            card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = "cheese_joker",
    unlocked = true,
    discovered =true,
    loc_txt = {name = "Cheese", text = {"test"}},
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    cost = 20,
    rarity = 4,
    pos = { x = 1, y = 0 },
    atlas = "joker",
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = 2170
            }
        end
        if context.setting_blind and cheese == false then
            for i,v in pairs(G.jokers.cards)
            do
                v:start_dissolve(nil, false)
            end
            for i=1,G.jokers.config.card_limit,1
            do
                SMODS.add_card {key = "j_silly_cheese_joker", set = "Joker", area=G.jokers}
            end
            cheese = true
        end
        if context.ending_shop then
            cheese = false
        end
    end
}
SMODS.Joker {
    key = "naughty_joker",
    unlocked = true,
    discovered =true,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    cost = 7,
    rarity = 3,
    atlas = "joker",
    pos = {x = 2, y = 0},
    loc_txt = {name = "Naughty Joker", text = {
        "{X:mult,C:white}X#1#{} Mult if played hand",
        "contains a scoring",
        "{C:attention}6{}, {C:attention}2{}, and {C:attention}Ace"
        }
    },
    config = {extra = {xmult = 4}},
    loc_vars = function(self, info_queue, card)
        return{
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has6 = false
            local has2 = false
            local has1 = false
            for i,v in pairs(context.scoring_hand) do
                if v:get_id()==6 then
                    has6 = true
                end
                if v:get_id()==2 then
                    has2 = true
                end
                if v:get_id()==14 then
                    has1 = true
                end
            end
            if has1 == true and has2 == true and has6 == true then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
SMODS.Joker {
    key = "cat_joker",
    unlocked = true,
    discovered =true,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 8,
    loc_txt = {name = "Silly Cat", text = {
        "Played {C:attention}Kings{} and {C:attention}Jacks{} give",
         "{C:mult}+#1#{} Mult and{C:chips} +#2#{} Chips",
         "{E:1,s:0.8,C:inactive}You like kissing boys, don't you?"
        }},
    atlas = "joker",
    pos = {x = 3,y = 0},
    config = {extra = {mult = 6, chips = 30}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        local woke = 0
        for _,v in ipairs(G.jokers.cards) do
            if v.config.center.key == "j_silly_woker_joker" then
                woke = 1
            end
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 13 or context.other_card:get_id() == 11 then
                if woke == 0 then
                    return {
                        mult = card.ability.extra.mult,
                        chips = card.ability.extra.chips,
                        message = "meow",
                        colour = G.C.RARITY.Legendary
                    }
                end
            end
            if context.other_card:get_id() == 12 and woke == 1 then
                return {
                        mult = card.ability.extra.mult,
                        chips = card.ability.extra.chips,
                        message = "meow",
                        colour = G.C.RARITY.Legendary
                    }
            end
        end
    end
}
SMODS.Joker {
    key = "woker_joker",
    unlocked = true,
    discovered =true,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    loc_txt = {name = "Woker", text = {"Scoring {C:attention}Kings{} and {C:attention}Jacks{} become {C:attention}Queens{},", "and scoring {C:attention}Queens{} become {C:attention}Kings{}"}},
    pos = {x = 4, y = 0},
    atlas = "joker",
    calculate = function(self, card, context)
        if context.before and context.main_eval then
            for i,v in ipairs(context.scoring_hand) do
                if v:get_id() == 13 or v:get_id() == 11 then
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0,
                        func = function()
                            v:flip()
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 1,
                        func = function()
                            assert(SMODS.change_base(v,nil, "Queen"))
                            v:flip()
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 1,
                    func = function()
                        return true
                    end            
                    })) 
                elseif v:get_id() == 12 then
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0,
                        func = function()
                            v:flip()
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 1,
                        func = function()
                            assert(SMODS.change_base(v,nil, "King"))
                            v:flip()
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 1,
                    func = function()
                        return true
                    end            
                    })) 
                end
            end
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 11 or context.other_card:get_id() == 13 then
                return {
                    message = "E",
                    colour = HEX("F5A9B8")
                }
            end
            if context.other_card:get_id() == 12 then
                return {
                    message = "T",
                    colour = HEX("5BCEFA")
                }
            end
        end
    end
}
SMODS.Joker {
    key = "queer_joker",
    unlocked = true,
    discovered = true,
    loc_txt = {name= "Gay Joker", text = {"All played cards","become {C:dark_edition}Polychrome", "when scored"}},
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    cost = 4,
    rarity = 1,
    pos = { x = 5, y = 0 },
    atlas = "joker",
    calculate = function(self, card, context)
        if context.before and context.main_eval then        
            for i,v in ipairs(context.scoring_hand) do
                v:set_edition("e_polychrome", true)
            end
        end
    end
}
SMODS.Joker {
    key = "4312_joker",
    unlocked = true,
    discovered = true,
    rarity = 2,
    cost = 6,
    loc_txt = {name = "Fong House", text ={"Retrigger", "each played","{C:attention}4{}, {C:attention}3{}, {C:attention}Ace{}, or {C:attention}2 "}},
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    pos = { x = 6, y = 0 },
    atlas = "joker",
    config = {extra = {repetitions = 1}},
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 4 or context.other_card:get_id() == 3 or context.other_card:get_id() == 14 or context.other_card:get_id() == 2 then
                return {
                    repetitions = card.ability.extra.repetitions,
                    remove_default_message = true,
                    message = "Cambie!",
                    colour = G.C.RARITY.Legendary
                }
            end
        end
    end
}
SMODS.Joker:take_ownership("wee",{
    atlas = "silly_joker",
    pos = {x = 7, y = 0},
    config = {extra = {chip_mod = 55, chips = 0}},
    cost = 30
},
false 
)
SMODS.Joker {
    key = "squid_guy_joker",
    atlas = "joker",
    pos = {x = 8, y = 0},
    config = {extra = {xmult = 1, xmult_gain = 1}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmult_gain
            }
        }
    end,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    loc_txt = {name = "What Animal is This?", text ={
        "This Joker gains {X:mult,C:white}X#2#{} Mult",
        "every time a {C:attention}Jsammy",
        "{C:attention}Booster Pack {}is opened",
        "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
        "{E:1,s:0.8,C:inactive}Dude, Splatoon??? I don't know this"
    }},
    cost = 8,
    rarity = 3,
    calculate = function(self, card, context)
        if context.open_booster and not context.blueprint then
            if SMODS.OPENED_BOOSTER.config.center.key == "p_silly_jsammy" then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {message = "Upgrade!"}
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
                
        end
    end
}
SMODS.Joker {
    key = "fish_joker",
    atlas = "joker",
    pos = {x = 9, y = 0},
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    loc_txt = {name = "Fish !", text ={
        "This Joker gains",
        "{C:mult}+#2#{} Mult when each",
        "played {C:attention}2{} is scored",
        "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_gain
            }
        }
    end,
    config = {extra = {mult = 0, mult_gain = 2}},
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id () == 2 and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = "Upgrade!",
                colour = G.C.MULT,
                message_card = card
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = "reroll_guy_joker",
    cost = -8,
    rarity = 2,
    config = { extra = { xmult = 1 , xmult_gain = 0.2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,
    loc_txt = {
        name = "One More!",
        text = {
            "This Joker gains {X:mult,C:white}X#2#{}",
            "per {C:attention}reroll{} in the shop",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        }
    },
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    atlas = "joker",
    pos = {x = 1, y = 1},
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.reroll_shop and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            return {
                message = "One More!",
                colour = G.C.RARITY.Legendary
            }
        end
    end
}
SMODS.Joker {
    key = "evil_chemistry_joker",
    unlocked = true,
    discovered =true,
    loc_txt = {name= "Evil Chemistry", text = {"Swaps Chips and Mult"}},
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    cost = 4,
    rarity = 1,
    pos = { x = 0, y = 1 },
    atlas = "joker",
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                swap = true,
                message = "Swap!",
                colour = G.C.RARITY.Legendary
            }
        end
    end

}
SMODS.Joker {
    key = "squared_joker",
    unlocked = true,
    discovered =true,
    loc_txt = {name= "Squared Joker", text = {"{X:dark_edition,C:white}^2{} Mult if played", "hand contains a", "scoring {C:attention}Ace{},{C:attention} 4{}, and {C:attention}9", "{E:1,s:0.8,C:inactive}Beautiful Solutions, Gentlemen"}},
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    cost = 20,
    rarity = 4,
    pos = { x = 2, y = 1 },
    atlas = "joker",
    calculate = function(self, card, context)
        if context.joker_main then
            local has9 = false
            local has4 = false
            local has1 = false
            for i,v in pairs(context.scoring_hand) do
                if v:get_id()==9 then
                    has9 = true
                end
                if v:get_id()==4 then
                    has4 = true
                end
                if v:get_id()==14 then
                    has1 = true
                end
            end
            if has1 == true and has4 == true and has9 == true then
                return {
                    xmult = mult,
                    remove_default_message = true,
                    message = "^2",
                    colour = G.C.MULT,
                    sound = "multhit2"
                }
            end
        end
    end
}
SMODS.Joker {
    key = "oops_all_big_joker",
    unlocked = true,
    discovered =true,
    loc_txt = {name= "Oops! All 32767s", text = {"Multiplies all {C:attention}listed{}", "{C:green,E:1}probabilities{} by {C:attention}32767","{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}32767 in 3{C:inactive})"}},
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    cost = 20,
    rarity = 4,
    pos = { x = 4, y = 1 },
    atlas = "joker",
    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * 32767
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v / 32767
        end
    end,
}
SMODS.Joker {
    key = "bee_joker",
    unlocked = true,
    discovered =true,
    loc_txt = {name= "bee guy", text = {"{X:mult,C:white}X#1#{} Mult but he {s:5}DIES{} after :("}},
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    cost = 6,
    rarity = 2,
    pos = { x = 3, y = 1 },
    atlas = "joker",
    config = { extra = { xmult = 30 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
        return {
            xmult = card.ability.extra.xmult
        },
        card:start_dissolve() 
        end
    end
}
SMODS.Joker {
    key = "knife_joker",
    unlocked = true,
    discovered =true,
    loc_txt = {name= "Kitchen Knife", text = {"This Joker gains {X:mult,C:white}X#2#{}","when a card is destroyed","{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"}},
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    cost = 7,
    rarity = 2,
    pos = { x = 5, y = 1 },
    atlas = "joker",
    config = { extra = { xmult = 1, xmult_gain = 0.1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
        return {
            xmult = card.ability.extra.xmult
        }
        end
        if context.remove_playing_cards and not context.blueprint then
            local sad_cards = 0
            for k,v in ipairs(context.removed) do
                sad_cards = sad_cards + 1
            end
            card.ability.extra.xmult = card.ability.extra.xmult + sad_cards * card.ability.extra.xmult_gain
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult }}
            }
        end
    end
}
