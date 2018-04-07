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
        sprite = '',
        animations = {
            ['walk'] = {
                frames = {1,2,3,4},
                interval = 0.155,
                texture = 'tiles'
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