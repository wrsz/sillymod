SMODS.Rank {
    key = "square_guy",
    card_key = "B",
    pos = {x = 0},
    nominal = 10,
    loc_txt = {name = "■"},
    shorthand = "■",
    next = {"10"},
    lc_atlas = 'cardlc', hc_atlas = 'cardhc'
}
SMODS.Rank:take_ownership("9",{
    next = {"10","silly_square_guy"},
},
false 
)