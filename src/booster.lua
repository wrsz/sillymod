SMODS.Booster {
    key = "jsammy",
    unlocked = true,
    discovered =true,
    config = { extra=3, choose = 1},
    loc_txt = {name = "jsammy", text = {"wow look at this guy"}, group_name = "jsammy"},
    weight = 2,
    atlas = "booster",
    create_card = function(self, card, i)
        local _card = {set = "jsammy_pack"}
        return _card
    end
}
SMODS.Booster {
    key = "secret_evil",
    unlocked = true,
    discovered =true,
    cost = 10,
    config = { extra=1, choose = 1},
    loc_txt = {name = "Silly Present!!!", text = {"Buy to open!!","{E:1,s:0.8,C:inactive}(it might be a cat)"}, group_name = "evil and mean :("},
    weight = .2,
    atlas = "booster",
    pos = {x = 1, y = 0},
    create_card = function(self, card, i)
        local _card = {key = "j_silly_job_application_joker"}
        return _card
    end
}
SMODS.Booster {
    key = "john",
    unlocked = true,
    discovered =true,
    config = { extra=1, choose = 1},
    loc_txt = {name = "secert", text = {"like from shoe"}, group_name = "John Balatro"},
    cost = 100,
    weight = .1,
    atlas = "booster",
    pos = {x = 2, y = 0},
    create_card = function(self, card, i)
        local _card = {key = "j_silly_john_joker"}
        return _card
    end,
    no_collection = true
}

