--[[
  Blue Magic learn database (all families)
  Sources: FFXIclopedia Blue Magic Spell List, Blue Mage Spell Locations,
           Bestiary categories.

  - "level"     = player level required to use the spell
  - "points"    = Blue Magic points (approximate where not listed)
  - "skillReq"  = approximate Blue Magic skill to learn it
]]

local db = {}

db.Families = {
    ------------------------------------------------------------------
    -- Amorphs
    ------------------------------------------------------------------
    ['Worm'] = {
        { name = 'Sandspin',       level = 1,  points = 2, skillReq = 1  },
    },
    ['Hecteyes'] = {
        { name = 'Death Ray',      level = 34, points = 2, skillReq = 70 },
    },
    ['Slime'] = {
        { name = 'Digest',         level = 36, points = 2, skillReq = 75 },
    },
    ['Leech'] = {
        { name = 'MP Drainkiss',   level = 42, points = 4, skillReq = 85 },
    },
    ['Flan'] = {
        { name = 'Corrosive Ooze', level = 66, points = 3, skillReq = 135},
        { name = 'Foul Waters',    level = 99, points = 4, skillReq = 200},
    },

    ------------------------------------------------------------------
    -- Vermin
    ------------------------------------------------------------------
    ['Bee'] = {
        { name = 'Pollen',         level = 1,  points = 1, skillReq = 1  },
    },
    ['Beetle'] = {
        { name = 'Power Attack',   level = 4,  points = 1, skillReq = 5  },
    },
    ['Crawler'] = {
        { name = 'Cocoon',         level = 8,  points = 1, skillReq = 10 },
    },
    ['Fly'] = {
        { name = 'Cursed Sphere',  level = 18, points = 2, skillReq = 30 },
    },
    ['Antlion'] = {
        { name = 'Mandibular Bite',level = 44, points = 2, skillReq = 90 },
    },
    ['Spider'] = {
        { name = 'Sickle Slash',   level = 48, points = 2, skillReq = 95 },
        { name = 'Spiral Spin',    level = 60, points = 3, skillReq = 120},
    },
    ['Scorpion'] = {
        { name = 'Death Scissors', level = 60, points = 2, skillReq = 120},
    },
    ['Wamoura'] = {
        { name = 'Cimicine Discharge', level = 78, points = 3, skillReq = 155},
    },
    ['Chapuli'] = {
        { name = 'Thermal Pulse',  level = 86, points = 4, skillReq = 170},
        { name = 'Nature\'s Meditation', level = 99, points = 6, skillReq = 200},
        { name = 'Tempestuous Upheaval', level = 99, points = 6, skillReq = 200},
        { name = 'Erratic Flutter',level = 99, points = 6, skillReq = 200},
        { name = 'Palling Salvo',  level = 99, points = 6, skillReq = 200},
    },

    ------------------------------------------------------------------
    -- Beasts
    ------------------------------------------------------------------
    ['Rabbit'] = {
        { name = 'Foot Kick',      level = 1,  points = 2, skillReq = 1  },
        { name = 'Wild Carrot',    level = 30, points = 3, skillReq = 60 },
    },
    ['Dhalmel'] = {
        { name = 'Healing Breeze', level = 16, points = 4, skillReq = 25 },
    },
    ['Sheep'] = {
        { name = 'Sheep Song',     level = 16, points = 2, skillReq = 25 },
    },
    ['Tiger'] = {
        { name = 'Claw Cyclone',   level = 20, points = 2, skillReq = 32 },
    },
    ['Coeurl'] = {
        { name = 'Chaotic Eye',    level = 32, points = 2, skillReq = 65 },
    },
    ['Opo-opo'] = {
        { name = 'Blank Gaze',     level = 38, points = 2, skillReq = 80 },
        { name = 'Magic Fruit',    level = 58, points = 3, skillReq = 115},
    },
    ['Marid'] = {
        { name = 'Voracious Trunk',level = 64, points = 4, skillReq = 130},
    },
    ['Behemoth'] = {
        { name = 'Asuran Claws',   level = 70, points = 4, skillReq = 140},
        { name = 'Charged Whisker',level = 88, points = 4, skillReq = 175},
        { name = 'Thunderbolt',    level = 95, points = 5, skillReq = 190},
    },
    ['Buffalo'] = {
        { name = 'Lowing',         level = 71, points = 3, skillReq = 140},
        { name = 'Heat Breath',    level = 71, points = 3, skillReq = 140},
        { name = 'Ram Charge',     level = 73, points = 3, skillReq = 145},
    },
    ['Manticore'] = {
        { name = 'Plenilune Embrace', level = 76, points = 5, skillReq = 150},
    },
    ['Cerberus'] = {
        { name = 'Gates of Hades', level = 97, points = 8, skillReq = 195},
        { name = 'Polar Roar',     level = 99, points = 8, skillReq = 200},
    },

    ------------------------------------------------------------------
    -- Plantoids
    ------------------------------------------------------------------
    ['Sapling'] = {
        { name = 'Sprout Smack',   level = 4,  points = 2, skillReq = 5  },
    },
    ['Mandragora'] = {
        { name = 'Wild Oats',      level = 4,  points = 3, skillReq = 5  },
    },
    ['Funguar'] = {
        { name = 'Queasyshroom',   level = 8,  points = 2, skillReq = 10 },
    },
    ['Flytrap'] = {
        { name = 'Soporific',      level = 24, points = 4, skillReq = 45 },
    },
    ['Treant'] = {
        { name = 'Pinecone Bomb',  level = 36, points = 2, skillReq = 75 },
    },
    ['Goobbue'] = {
        { name = 'Uppercut',       level = 38, points = 3, skillReq = 80 },
    },
    ['Morbol'] = {
        { name = 'Bad Breath',     level = 61, points = 5, skillReq = 120},
        { name = 'Seedspray',      level = 61, points = 2, skillReq = 120},
        { name = 'Dream Flower',   level = 87, points = 5, skillReq = 175},
    },
    ['Sabotender'] = {
        { name = '1000 Needles',   level = 62, points = 2, skillReq = 125},
    },
    ['Rafflesia'] = {
        { name = 'Retinal Glare',  level = 99, points = 6, skillReq = 200},
        { name = 'Nectarous Deluge', level = 99, points = 6, skillReq = 200},
    },

    ------------------------------------------------------------------
    -- Aquans
    ------------------------------------------------------------------
    ['Crab'] = {
        { name = 'Metallic Body',  level = 8,  points = 1, skillReq = 10 },
    },
    ['Pugil'] = {
        { name = 'Screwdriver',    level = 26, points = 3, skillReq = 50 },
    },
    ['Uragnite'] = {
        { name = 'Venom Shell',    level = 42, points = 3, skillReq = 85 },
    },
    ['SeaMonk'] = {
        { name = 'Maelstrom',      level = 61, points = 4, skillReq = 120},
    },
    ['Orobon'] = {
        { name = 'Regeneration',   level = 78, points = 4, skillReq = 155},
    },
    ['Ruszor'] = {
        { name = 'Rending Deluge', level = 99, points = 6, skillReq = 200},
        { name = 'Carcharian Verve', level = 99, points = 6, skillReq = 200},
    },

    ------------------------------------------------------------------
    -- Beastmen
    ------------------------------------------------------------------
    ['Orc'] = {
        { name = 'Battle Dance',   level = 12, points = 3, skillReq = 18 },
        { name = 'Blastbomb',      level = 18, points = 2, skillReq = 30 },
    },
    ['Quadav'] = {
        { name = 'Head Butt',      level = 12, points = 3, skillReq = 18 },
    },
    ['Yagudo'] = {
        { name = 'Feather Storm',  level = 12, points = 3, skillReq = 18 },
    },
    ['Goblin'] = {
        { name = 'Bomb Toss',      level = 28, points = 3, skillReq = 55 },
        { name = 'Frypan',         level = 63, points = 3, skillReq = 125},
    },
    ['Gigas'] = {
        { name = 'Grand Slam',     level = 30, points = 2, skillReq = 60 },
    },
    ['Warmachine'] = {
        { name = 'Blastbomb',      level = 18, points = 2, skillReq = 30 },
    },
    ['Sahagin'] = {
        { name = 'Hydro Shot',     level = 63, points = 3, skillReq = 125},
        { name = 'Flying Hip Press', level = 58, points = 4, skillReq = 115},
    },
    ['Antica'] = {
        { name = 'Light of Penance', level = 58, points = 4, skillReq = 115},
    },
    ['Troll'] = {
        { name = 'Magnetite Cloud',level = 46, points = 3, skillReq = 90 },
        { name = 'Diamondhide',    level = 67, points = 4, skillReq = 135},
    },
    ['Lamiae'] = {
        { name = 'Enervation',     level = 67, points = 4, skillReq = 135},
    },
    ['MamoolJa'] = {
        { name = 'Warm-Up',        level = 68, points = 3, skillReq = 135},
        { name = 'Firespit',       level = 68, points = 3, skillReq = 135},
        { name = 'Tail Slap',      level = 69, points = 3, skillReq = 135},
        { name = 'Hysteric Barrage', level = 69, points = 4, skillReq = 135},
    },
    ['Poroggo'] = {
        { name = 'Water Bomb',     level = 92, points = 5, skillReq = 185},
    },
    ['Tonberry'] = {
        { name = 'Everyone\'s Grudge', level = 90, points = 5, skillReq = 180},
    },
    ['Qiqirn'] = {
        { name = 'Demoralizing Roar', level = 80, points = 4, skillReq = 160},
    },

    ------------------------------------------------------------------
    -- Birds
    ------------------------------------------------------------------
    ['Bird'] = {
        { name = 'Helldive',       level = 16, points = 2, skillReq = 25 },
    },
    ['GiantBat'] = {
        { name = 'Blood Drain',    level = 20, points = 2, skillReq = 32 },
    },
    ['BatTrio'] = {
        { name = 'Jet Stream',     level = 38, points = 2, skillReq = 80 },
    },
    ['Cockatrice'] = {
        { name = 'Sound Blast',    level = 32, points = 1, skillReq = 65 },
        { name = 'Jettatura',      level = 48, points = 3, skillReq = 95 },
    },
    ['Roc'] = {
        { name = 'Feather Barrier',level = 56, points = 3, skillReq = 110},
        { name = 'Feather Tickle', level = 64, points = 3, skillReq = 130},
        { name = 'Yawn',           level = 64, points = 3, skillReq = 130},
        { name = 'Reaving Wind',   level = 90, points = 5, skillReq = 180},
    },
    ['Tulfaire'] = {
        { name = 'Crashing Thunder', level = 99, points = 6, skillReq = 200},
    },

    ------------------------------------------------------------------
    -- Arcana
    ------------------------------------------------------------------
    ['Cardian'] = {
        { name = 'Bludgeon',       level = 18, points = 2, skillReq = 30 },
    },
    ['Weapon'] = {
        { name = 'Smite of Rage',  level = 34, points = 3, skillReq = 70 },
    },
    ['MagicPot'] = {
        { name = 'Mysterious Light', level = 40, points = 4, skillReq = 85 },
    },
    ['Bomb'] = {
        { name = 'Self-Destruct',  level = 50, points = 3, skillReq = 100},
        { name = 'Ice Break',      level = 50, points = 3, skillReq = 100},
    },
    ['Cluster'] = {
        { name = 'Blitzstrahl',    level = 44, points = 3, skillReq = 90 },
    },
    ['Doll'] = {
        { name = 'Refueling',      level = 48, points = 3, skillReq = 95 },
    },

    ------------------------------------------------------------------
    -- Undead
    ------------------------------------------------------------------
    ['Hound'] = {
        { name = 'Poison Breath',  level = 22, points = 1, skillReq = 38 },
    },
    ['Ghost'] = {
        { name = 'Terror Touch',   level = 40, points = 3, skillReq = 85 },
    },
    ['Skeleton'] = {
        { name = 'Blood Saber',    level = 48, points = 2, skillReq = 95 },
    },
    ['Corse'] = {
        { name = 'Memento Mori',   level = 62, points = 3, skillReq = 125},
        { name = 'Stinking Gas',   level = 44, points = 2, skillReq = 90 },
    },
    ['Doomed'] = {
        { name = 'Dimensional Death', level = 60, points = 3, skillReq = 120},
        { name = 'Spinal Cleave',  level = 63, points = 3, skillReq = 125},
    },
    ['Fomor'] = {
        { name = 'Animating Wail', level = 79, points = 4, skillReq = 155},
    },

    ------------------------------------------------------------------
    -- Lizards
    ------------------------------------------------------------------
    ['Lizard'] = {
        { name = 'Geist Wall',     level = 46, points = 3, skillReq = 90 },
        { name = 'Awful Eye',      level = 46, points = 2, skillReq = 90 },
        { name = 'Infrasonics',    level = 65, points = 3, skillReq = 130},
        { name = 'Frost Breath',   level = 66, points = 3, skillReq = 135},
        { name = 'Regurgitation',  level = 69, points = 3, skillReq = 135},
        { name = 'Embalming Earth',level = 99, points = 6, skillReq = 200},
    },
    ['Raptor'] = {
        { name = 'Saurian Slide',  level = 99, points = 7, skillReq = 200},
    },

    ------------------------------------------------------------------
    -- Dragons
    ------------------------------------------------------------------
    ['Dragon'] = {
        { name = 'Radiant Breath', level = 54, points = 4, skillReq = 110},
        { name = 'Body Slam',      level = 62, points = 3, skillReq = 125},
        { name = 'Zephyr Mantle',  level = 65, points = 3, skillReq = 130},
        { name = 'Wind Breath',    level = 99, points = 6, skillReq = 200},
    },

    ------------------------------------------------------------------
    -- Demons
    ------------------------------------------------------------------
    ['Demon'] = {
        { name = 'Frightful Roar', level = 50, points = 3, skillReq = 100},
        { name = 'Hecatomb Wave',  level = 54, points = 4, skillReq = 110},
        { name = 'Eyes On Me',     level = 61, points = 4, skillReq = 120},
        { name = 'Frenetic Rip',   level = 63, points = 3, skillReq = 125},
        { name = 'Mind Blast',     level = 73, points = 4, skillReq = 145},
        { name = 'Triumphant Roar',level = 71, points = 3, skillReq = 140},
    },
    ['Ahriman'] = {
        { name = 'Magic Barrier',  level = 82, points = 5, skillReq = 165},
    },

    ------------------------------------------------------------------
    -- Luminians / Luminions
    ------------------------------------------------------------------
    ['Aern'] = {
        { name = 'Disseverment',   level = 72, points = 4, skillReq = 145},
    },
    ['Hpemde'] = {
        { name = 'Temporal Shift', level = 73, points = 4, skillReq = 145},
    },
    ['Phuabo'] = {
        { name = 'Plasma Charge',  level = 75, points = 4, skillReq = 150},
        { name = 'Vapor Spray',    level = 96, points = 5, skillReq = 190},
    },
    ['Euvhi'] = {
        { name = 'Vertical Cleave',level = 75, points = 4, skillReq = 150},
    },
    ['Ghrah'] = {
        { name = 'Actinic Burst',  level = 74, points = 4, skillReq = 145},
    },
    ['Zdei'] = {
        { name = 'Reactor Cool',   level = 74, points = 4, skillReq = 145},
    },
    ['Xzomit'] = {
        { name = 'Saline Coat',    level = 72, points = 4, skillReq = 145},
    },

    ------------------------------------------------------------------
    -- Empty
    ------------------------------------------------------------------
    ['Craver'] = {
        { name = 'Empty Thrash',   level = 87, points = 5, skillReq = 175},
        { name = 'Vanity Dive',    level = 82, points = 4, skillReq = 165},
    },
    ['Gorger'] = {
        { name = 'Auroral Drape',  level = 84, points = 4, skillReq = 170},
    },
    ['Seether'] = {
        { name = 'Quadratic Continuum', level = 85, points = 5, skillReq = 170},
    },
    ['Thinker'] = {
        { name = 'Occultation',    level = 88, points = 5, skillReq = 175},
    },

    ------------------------------------------------------------------
    -- Vorageans
    ------------------------------------------------------------------
    ['Clionidae'] = {
        { name = 'Acrid Stream',   level = 77, points = 4, skillReq = 155},
        { name = 'Osmosis',        level = 84, points = 4, skillReq = 170},
    },
    ['Limule'] = {
        { name = 'Benthic Typhoon',level = 83, points = 5, skillReq = 165},
    },

    ------------------------------------------------------------------
    -- Elementals
    ------------------------------------------------------------------
    ['Elemental'] = {
        { name = 'Searing Tempest',level = 99, points = 8, skillReq = 200},
        { name = 'Blinding Fulgor',level = 99, points = 8, skillReq = 200},
        { name = 'Spectral Floe',  level = 99, points = 8, skillReq = 200},
        { name = 'Scouring Spate', level = 99, points = 8, skillReq = 200},
        { name = 'Anvil Lightning',level = 99, points = 8, skillReq = 200},
        { name = 'Silent Storm',   level = 99, points = 8, skillReq = 200},
        { name = 'Paralyzing Triad', level = 99, points = 6, skillReq = 200},
    },

    ------------------------------------------------------------------
    -- Supreme Beings / Special
    ------------------------------------------------------------------
    ['Shinryu'] = {
        { name = 'Mighty Guard',   level = 99, points = 9, skillReq = 200},
    },
}

------------------------------------------------------------------
-- Name → Family lookup (common variants)
------------------------------------------------------------------
db.NameToFamily = {
    -- Amorphs
    ['Tunnel Worm'] = 'Worm', ['Giant Worm'] = 'Worm', ['Earthworm'] = 'Worm',
    ['Sandworm'] = 'Worm', ['Cave Worm'] = 'Worm',

    ['Hecteyes'] = 'Hecteyes', ['Hundred Eyes'] = 'Hecteyes',
    
    ['Slime'] = 'Slime', ['Gel'] = 'Slime', ['Jelly'] = 'Slime',
    
    ['Stickpin'] = 'Leech', ['Leech'] = 'Leech', ['Wadi Leech'] = 'Leech',
    ['Thread Leech'] = 'Leech', ['Forest Leech'] = 'Leech', ['Poison Leech'] = 'Leech',
    ['Huge Leech'] = 'Leech',
    
    ['Flan'] = 'Flan', ['Ooze'] = 'Flan',

    -- Vermin
    ['Bumblebee'] = 'Bee', ['Huge Hornet'] = 'Bee', ['Maneating Hornet'] = 'Bee',
    ['Killer Bee'] = 'Bee', ['Giant Bee'] = 'Bee', ['Giddeus Bee'] = 'Bee',
    ['Water Wasp'] = 'Bee', ['Canyon Wasp'] = 'Bee', ['Giant Hornet'] = 'Bee',
    
    ['Beetle'] = 'Beetle', ['Scarab Beetle'] = 'Beetle', ['Sand Beetle'] = 'Beetle',
    ['Diving Beetle'] = 'Beetle', ['Giant Beetle'] = 'Beetle',
    
    ['Crawler'] = 'Crawler', ['Rugged Crawler'] = 'Crawler', ['Soldier Crawler'] = 'Crawler',
    ['Worker Crawler'] = 'Crawler', ['Processionaire'] = 'Crawler',
    
    ['Huge Fly'] = 'Fly', ['Gadfly'] = 'Fly', ['May Fly'] = 'Fly', ['Giant Fly'] = 'Fly',
    
    ['Antlion'] = 'Antlion', ['Giant Antlion'] = 'Antlion',
    
    ['Spider'] = 'Spider', ['Giant Spider'] = 'Spider',
    
    ['Scorpion'] = 'Scorpion', ['Giant Scorpion'] = 'Scorpion',
    
    ['Wamoura'] = 'Wamoura', ['Wamouracampa'] = 'Wamoura',
    
    ['Chapuli'] = 'Chapuli',

    -- Beasts
    ['Forest Hare'] = 'Rabbit', ['Savanna Rarab'] = 'Rabbit', ['Mighty Rarab'] = 'Rabbit',
    ['Mountain Hare'] = 'Rabbit', ['Vorpal Bunny'] = 'Rabbit', ['Island Rarab'] = 'Rabbit',
    ['Polar Hare'] = 'Rabbit', ['Pit Hare'] = 'Rabbit', ['Canyon Rarab'] = 'Rabbit',
    
    ['Wild Dhalmel'] = 'Dhalmel', ['Bull Dhalmel'] = 'Dhalmel', ['Marine Dhalmel'] = 'Dhalmel',
    
    ['Ornery Sheep'] = 'Sheep', ['Wild Sheep'] = 'Sheep', ['Mad Sheep'] = 'Sheep', ['Brutal Sheep'] = 'Sheep',
    
    ['Forest Tiger'] = 'Tiger', ['Tiger'] = 'Tiger',
    
    ['Coeurl'] = 'Coeurl', ['Lynx'] = 'Coeurl',
    
    ['Opo-opo'] = 'Opo-opo', ['Young Opo-opo'] = 'Opo-opo',
    
    ['Marid'] = 'Marid', 
    
    ['Behemoth'] = 'Behemoth',
    
    ['Buffalo'] = 'Buffalo', 
    
    ['Manticore'] = 'Manticore',
    
    ['Cerberus'] = 'Cerberus',

    -- Plantoids
    ['Sapling'] = 'Sapling', ['Walking Tree'] = 'Sapling', ['Stalking Sapling'] = 'Sapling',
    
    ['Mandragora'] = 'Mandragora', ['Tiny Mandragora'] = 'Mandragora',
    ['Pygmy Mandragora'] = 'Mandragora', ['Yuhtunga Mandragora'] = 'Mandragora',
    ['Yhoator Mandragora'] = 'Mandragora', ['Sylvestre'] = 'Mandragora',
    
    ['Funguar'] = 'Funguar', ['Myxomycete'] = 'Funguar', ['Poison Funguar'] = 'Funguar',
    
    ['Flytrap'] = 'Flytrap', ['Giant Flytrap'] = 'Flytrap',
    
    ['Treant'] = 'Treant', 
    
    ['Goobbue'] = 'Goobbue', ['Old Goobbue'] = 'Goobbue',
    
    ['Morbol'] = 'Morbol', 
    
    ['Sabotender'] = 'Sabotender',
    
    ['Rafflesia'] = 'Rafflesia',

    -- Aquans
    ['River Crab'] = 'Crab', ['Land Crab'] = 'Crab', ['Thickshell'] = 'Crab',
    ['Crab'] = 'Crab', ['Clipper'] = 'Crab', ['Snipper'] = 'Crab',
    
    ['Pugil'] = 'Pugil', ['Fanged Pugil'] = 'Pugil', ['Bigclaw'] = 'Pugil',
    
    ['Uragnite'] = 'Uragnite', 
    
    ['Sea Monk'] = 'SeaMonk',
    
    ['Orobon'] = 'Orobon', 
    
    ['Ruszor'] = 'Ruszor',

    -- Beastmen
    ['Orcish Fodder'] = 'Orc', ['Orcish Grappler'] = 'Orc', ['Orcish Mesmerizer'] = 'Orc',
    ['Orcish Grunt'] = 'Orc', ['Orcish Serjeant'] = 'Orc', ['Orcish Stonechucker'] = 'Orc',
    ['Young Quadav'] = 'Quadav', ['Amethyst Quadav'] = 'Quadav', ['Amber Quadav'] = 'Quadav',
    ['Greater Quadav'] = 'Quadav', ['Veteran Quadav'] = 'Quadav',
    ['Yagudo Initiate'] = 'Yagudo', ['Yagudo Acolyte'] = 'Yagudo', ['Yagudo Scribe'] = 'Yagudo',
    ['Goblin Thug'] = 'Goblin', ['Goblin Weaver'] = 'Goblin', ['Goblin Tinkerer'] = 'Goblin',
    ['Gigas'] = 'Gigas', ['Gigas Fighter'] = 'Gigas', ['Gigas Sculptor'] = 'Gigas',
    ['Orcish Warmachine'] = 'Warmachine', ['Warmachine'] = 'Warmachine',
    ['Sahagin'] = 'Sahagin', ['Antica'] = 'Antica',
    ['Troll'] = 'Troll', ['Lamiae'] = 'Lamiae', ['Mamool Ja'] = 'MamoolJa',
    ['Poroggo'] = 'Poroggo', ['Tonberry'] = 'Tonberry', ['Qiqirn'] = 'Qiqirn',

    -- Birds
    ['Carrion Crow'] = 'Bird', ['Akbaba'] = 'Bird', ['Nightshade'] = 'Bird',
    ['Jubjub'] = 'Bird', ['Crow'] = 'Bird',
    ['Mouse Bat'] = 'GiantBat', ['Fledermaus'] = 'GiantBat', ['Blade Bat'] = 'GiantBat',
    ['Cheiroptera'] = 'GiantBat', ['Acro Bat'] = 'GiantBat', ['Grave Bat'] = 'GiantBat',
    ['Poison Bat'] = 'GiantBat', ['Black Bat'] = 'GiantBat', ['Giant Bat'] = 'GiantBat',
    ['Ding Bats'] = 'BatTrio', ['Ding Bat'] = 'BatTrio', ['Spectacled Bats'] = 'BatTrio',
    ['Wind Bats'] = 'BatTrio', ['Gale Bats'] = 'BatTrio', ['Grotto Bats'] = 'BatTrio',
    ['Cockatrice'] = 'Cockatrice', ['Tabar Beak'] = 'Cockatrice',
    ['Roc'] = 'Roc', ['Tulfaire'] = 'Tulfaire',

    -- Arcana
    ['Cardian'] = 'Cardian', ['Two of Cups'] = 'Cardian', ['Three of Swords'] = 'Cardian',
    ['Poltergeist'] = 'Weapon', ['Evil Weapon'] = 'Weapon',
    ['Magic Pot'] = 'MagicPot', ['Bomb'] = 'Bomb', ['Cluster'] = 'Cluster',
    ['Doll'] = 'Doll',

    -- Undead
    ['Hound'] = 'Hound', ['Bogy'] = 'Hound', ['Wolf'] = 'Hound', ['Pit Hound'] = 'Hound',
    ['Ghost'] = 'Ghost', ['Specter'] = 'Ghost', ['Banshee'] = 'Ghost',
    ['Skeleton'] = 'Skeleton', ['Magicked Bones'] = 'Skeleton',
    ['Corse'] = 'Corse', ['Doomed'] = 'Doomed', ['Fomor'] = 'Fomor',

    -- Lizards
    ['Lizard'] = 'Lizard', ['Raptor'] = 'Raptor', ['Giant Lizard'] = 'Lizard',

    -- Dragons
    ['Dragon'] = 'Dragon', ['Wyvern'] = 'Dragon', ['Wyrm'] = 'Dragon',

    -- Demons
    ['Imp'] = 'Demon', ['Demon'] = 'Demon', ['Ahriman'] = 'Ahriman',

    -- Luminians
    ['Aern'] = 'Aern', ['Hpemde'] = 'Hpemde', ['Phuabo'] = 'Phuabo',
    ['Euvhi'] = 'Euvhi', ['Ghrah'] = 'Ghrah', ['Zdei'] = 'Zdei', ['Xzomit'] = 'Xzomit',

    -- Empty
    ['Craver'] = 'Craver', ['Gorger'] = 'Gorger', ['Seether'] = 'Seether',
    ['Thinker'] = 'Thinker',

    -- Vorageans
    ['Clionidae'] = 'Clionidae', ['Limule'] = 'Limule',

    -- Elementals
    ['Fire Elemental'] = 'Elemental', ['Ice Elemental'] = 'Elemental',
    ['Earth Elemental'] = 'Elemental', ['Water Elemental'] = 'Elemental',
    ['Air Elemental'] = 'Elemental', ['Thunder Elemental'] = 'Elemental',
    ['Light Elemental'] = 'Elemental', ['Dark Elemental'] = 'Elemental',

    -- Special
    ['Shinryu'] = 'Shinryu',
}

return db