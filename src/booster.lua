SMODS.Booster {
    key = "jsammy",
    unlocked = true,
    discovered =true,
    config = { extra=6, choose = 1},
    loc_txt = {name = "jsammy", text = {"wow look at this guy"}, group_name = "jsammy"},
    weight = 3,
    atlas = "booster",
    create_card = function(self, card, i)
        local _card = {set = "jsammy_pack"}
        return _card
    end
}