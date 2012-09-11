local nodebox_cart = {
                {-0.5,-0.5,-0.5, 0.5,-0.4,0.5},
                
                {-0.5,-0.5,-0.5, -0.4,0.5,0.5},
                { 0.4,-0.5,-0.5,  0.5,0.5,0.5},
                
                {-0.5,-0.5,-0.5,  0.5,0.5,-0.4},
                {-0.5,-0.5, 0.4,  0.5,0.5, 0.5},
            }
            
minetest.register_node("pushable_block:box_cart", {
    tiles = { "pushable_block_cart.png" },
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = nodebox_cart
        },
        })