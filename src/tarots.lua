SMODS.Consumable {
    key = "11_tarot",
    set = "Tarot",
    loc_txt = {name= "guh????", text = {"its a secret"}},
    cost = 3,
    unlocked = true,
    discovered = true,
    config = { max_highlighted = 1 },
    pos = { x = 0, y = 0 },
     atlas = "tarot",
    use = function(self, card, area, copier)
        local card_guy = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    card_guy:flip()
                    play_sound('card1', percent)
                    card_guy:juice_up(0.3, 0.3)
                    return true
                end}))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                assert(SMODS.change_base(card_guy,nil, "silly_square_guy"))
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    card_guy:flip()
                    play_sound('tarot2', percent, 0.6)
                    card_guy:juice_up(0.3, 0.3)
                    return true
                end
            }))
    end
}