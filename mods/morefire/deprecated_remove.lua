minetest.register_abm({
    nodenames = {
        "morefire:fire",
        "morefire:smoke",
        "morefire:explosion",
    },
    interval = 7200,
    chance = 1,

    action = function(pos, node, active_object_count, active_object_count_wider)
        minetest.env:remove_node(pos)
    end,
})
