SMODS.Booster {
    key = "jsammy",
    unlocked = true,
    discovered =true,
    config = { extra=2, choose = 1},
    loc_txt = {name = "jsammy", text = {"wow look at this guy"}, group_name = "jsammy"},
    weight = 1,
    atlas = "booster",
    create_card = function(self, card, i)
        local _card = {set = "jsammy_pack"}
        return _card
    end
}