--[[
    GD50
    Pokemon
    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

ENTITY_IDS = {
    'player',
    'testEnemy'
}

ENTITY_DEFS = {
    ['player'] = {
        name = 'player',
        size = {
            x = TILE_SIZE * 0.6,
            y = TILE_SIZE * 0.6
        },
        animations = {
            ['idle'] = {
                frames = {1, 2, 3, 4},
                interval = 0.1,
                texture = 'tiles'
            },
            ['walk'] = {
                frames = {5, 6, 7, 8},
                interval = 0.1,
                texture = 'tiles'
            },
            
        },
        color = {64, 48, 128}
    },
    ['enemy'] = {
        name = 'enemy',
        size = {
            x = TILE_SIZE * 0.6,
            y = TILE_SIZE * 0.6
        },
        color = {128, 48, 64},
        animations = {
            
        }
    }
}