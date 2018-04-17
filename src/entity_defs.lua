ENTITY_IDS = {
    'healer',
    'tank',
    'testEnemy'
}

ENTITY_DEFS = {
    ['healer'] = {
        name = 'healer',
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
        abilities = {
            ABILITY_DEFS["heal"],
            ABILITY_DEFS["smite"]
            -- Ability(ABILITY_DEFS["heal"]),
            -- Ability(ABILITY_DEFS["smite"]),
            -- Ability(ABILITY_DEFS["strike"]),
            -- Ability(ABILITY_DEFS["block"])
        },
        flipOffset = TILE_SIZE * 0.6,
        color = {64, 48, 128}
    },
    ['tank'] = {
        name = 'tank',
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
        abilities = {
            ABILITY_DEFS["strike"],
            ABILITY_DEFS["block"]
        },
        flipOffset = TILE_SIZE * 0.6,
        color = {32, 96, 64}
    },
    ['enemy'] = {
        name = 'enemy',
        size = {
            x = TILE_SIZE * 0.6,
            y = TILE_SIZE * 0.6
        },
        color = {128, 48, 64},
        animations = {
            ['idle'] = {
                frames = {1},
                interval = 0.1,
                texture = 'ragebaby'
            },
            ['walk'] = {
                frames = {1},
                interval = 0.1,
                texture = 'ragebaby'
            }
        },
        abilities = {
            ABILITY_DEFS["strike"],
            ABILITY_DEFS["block"]
        }
    }
}