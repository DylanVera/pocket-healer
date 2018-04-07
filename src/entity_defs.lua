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
        animations = {
            ['walk'] = {
                frames = {5, 6, 7, 8},
                interval = 0.155,
                texture = 'tiles'
            },
            ['idle'] = {
                frames = {152},
                interval = 0.15,
                texture = 'gbTiles'
            }
        },
        color = {64, 48, 128}
    },
    ['enemy'] = {
        name = 'enemy',
        color = {128, 48, 64},
        animations = {

        }
    }
}