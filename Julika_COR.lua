include('organizer-lib.lua')
include('displayBox.lua')
-- Local Settings, setting the zones prior to use

Idle_Index = 1
Run_Index = 1
Leaden_Index = 1
Savage_Index = 1
Roll_Index = 2
autoShoot = false
weaponLocked = false

toau_zones = S{"Leujaoam Sanctum","Mamool Ja Training Grounds","Lebros Cavern","Periqia","Ilrusi Atoll",
        "Nyzul Isle","Bhaflau Remnants","Arrapago Remnants","Silver Sea Remnants","Zhayolm Remnants"}

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
    "Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}

elements = {}
elements.use_on_single_conflict = false
elements.strong_against = {['Fire'] = 'Ice', ['Earth'] = 'Thunder', ['Water'] = 'Fire', ['Wind'] = 'Earth', ['Ice'] = 'Wind', ['Thunder'] = 'Water', ['Light'] = 'Dark', ['Dark'] = 'Light'}
elements.weak_against = {['Fire'] = 'Water', ['Earth'] = 'Wind', ['Water'] = 'Thunder', ['Wind'] = 'Ice', ['Ice'] = 'Fire', ['Thunder'] = 'Earth', ['Light'] = 'Dark', ['Dark'] = 'Light'}

capeSS={ name="Camulus's Mantle", augments={'"Snapshot"+10',}}
capeTP={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
capeWS={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}}
capeSavage={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
capeTPMelee={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
capeDT={ name="Camulus's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Damage taken-5%',}}

HercLegsMAB={ name="Herculean Trousers", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','Weapon skill damage +3%','MND+5','Mag. Acc.+12','"Mag.Atk.Bns."+14',}}

-- Start Functions here
-- Gear Sets
function get_sets()
sets.roll = {}
sets.roll.index = {"Short", "Long"}
sets.roll.Short = {
    head={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
    body="Lanun Frac +3",
    hands="Chasseur's Gants +1", --Chasseur's Gants
    -- legs="Lanun Culottes",
    feet="Meg. Jam. +2",
    neck="Regal Necklace",
    waist="Chaac Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    -- right_ring="Barataria Ring",
    back=capeTP, --AMBUSCADE
}

sets.roll.Long = set_combine(sets.roll.Short, {left_ring="Luzaf's Ring"})

sets.Idle = {}
sets.Idle.index = {"Standard", "DT"}
sets.Idle.Standard = {

    --range="Compensator",
    -- ammo="Eminent Bullet",
    head="Meghanada Visor +2",
    hands="Meghanada gloves +2",
    legs="Feast Hose",
    feet="Hermes' Sandals",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Etiolation Earring",
    right_ear="Hearty Earring",
    left_ring="Karieyh Ring",
    right_ring="Defending Ring",
    back="Iximulew cape",
    -- back="Repulse Mantle",
}

sets.Idle.DT = set_combine(sets.Idle.Standard, {
    head="Malignance chapeau",
    body="Lanun frac +3",
    legs="Malignance tights",
    feet="Malignance boots",
    left_ring="Gelatinous Ring +1",
    back=capeDT
})

sets.Melee = {
    head="Malignance chapeau",
    neck="Iqabi necklace",
    ear1="Telos Earring",
    ear2="Suppanomimi",
    body="Adhemar jacket +1",
    hands="Floral Gauntlets",
    ring1="Chirich Ring +1",
    ring2="Meghanada Ring",
    back=capeTPMelee,
    waist="Reiki Yotai",
    legs="Malignance tights",
    feet="Malignance Boots"
    -- feet="Herculean Boots",
}

sets.preshot = { -- aim 60 Snapshot, then Rapid Shot
    head="Taeon Chapeau",
    body="Laksamana's frac +3", --Need
    -- body="Oshosi Vest",
    hands="Carmine Finger Gauntlets +1",
    waist="Yemaya Belt",
    legs="Laksamana's trews +3", --Need
    feet="Meg. Jam. +2",
    back=capeSS,
    neck="Commodore Charm",
}

sets.RA = {}
sets.RA.index = {'Standard', 'Accuracy'}
rangedSets = {'Standard', 'Accuracy'}
rangedIndex = 1

sets.RA.Standard = { --RAcc and STP
    head="Meghanada Visor +2",
    body="Oshosi Vest",
    hands="Adhemar Wristbands +1",
    legs="Adhemar Kecks +1",
    feet="Meg. Jam. +2",
    neck="Iskur gorget",
    waist="Yemaya Belt",
    left_ear="Neritic Earring",
    right_ear="Enervating Earring",
    back=capeTP,
    ring1="Dingir Ring",
    ring2="Ilabrat Ring",
}

sets.RA.Accuracy = set_combine(sets.RA, { --RAcc and STP
    body="Laksamana's Frac +3",
    legs="Laksamana's Trews +3",
    neck="Iskur gorget",
    ring1="Hajduk Ring",
    ring2="Hajduk Ring",
})

sets.WS = {}

sets.WS.SavageBlade = {
    head="Meghanada Visor +2",
    neck="Caro Necklace",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    body="Laksamana's Frac +3",
    hands="Meghanada Gloves +2",
    ring1="Regal Ring",
    ring2="Karieyh Ring", 
    back=capeSavage,
    waist="Metalsinger Belt", --Sailfi Belt +1
    legs="Laksamana's Trews +3",
    feet="Lanun Bottes +3",
}
sets.WS.SavageBlade.index = {"Attack", "Accuracy"}

sets.WS.SavageBlade.Attack = sets.WS.SavageBlade
sets.WS.SavageBlade.Accuracy = set_combine(sets.WS.SavageBlade, {
    neck="Sanctity Necklace",
    ear1="Telos Earring",
    waist="Grunfeld Rope",
    ring1="Chirich ring +1",
    })

sets.WS.LastStand = { --Generic Physical WS
    head="Meghanada Visor +2",
    body="Laksamana's Frac +3",
    hands="Meghanada Gloves +2",
    legs="Laksamana's trews +3",
    feet="Lanun Bottes +3",
    neck="Commodore Charm",
    waist="Eschan Stone",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    ring1="Hajduk Ring",
    ring2="Regal Ring",
    back=capeWS,
}

sets.WS.Wildfire = {
    head={ name="Herculean Helm", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+2','"Mag.Atk.Bns."+15',}},
    body="Lanun Frac +3",
    hands="Carmine finger gauntlets +1",
    legs=HercLegsMAB,
    feet="Lanun Bottes +3",
    neck="Commodore Charm",
    waist="Eschan Stone",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    ring1="Dingir Ring",
    ring2="Ilabrat ring",
    back=capeWS,
}


sets.WS.LeadenSalute = {}

sets.WS.LeadenSalute.index = {"Standard", "Enmity"}
sets.WS.LeadenSalute.Standard = { --AGI Weaponskill
    head="Pixie Hairpin +1",
    body="Lanun Frac +3",
    hands="Carmine finger gauntlets +1",
    legs=HercLegsMAB,
    feet="Lanun Bottes +3",
    -- neck="Commodore Charm",
    neck="Commodore Charm",
    waist="Eschan Stone",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    left_ring="Dingir Ring",
    right_ring="Archon Ring",
    back=capeWS,
}

sets.WS.LeadenSalute.Enmity = set_combine(sets.WS.LeadenSalute.Standard, {
    right_ear="Enervating Earring",
    left_ring="Resonance Ring",
    hands={ name="Taeon Gloves", augments={'"Mag.Atk.Bns."+19','Weapon skill damage +2%',}},
    legs="Laksamana's Trews +3",
    waist="Reiki Yotai"
    })

sets.FastCast = {
    -- head="Carmine Mask",
    body="Taeon Tabard",
    -- feet="Carmine Greaves +1",
    neck="Voltsurge Torque",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    -- right_ring="Weather. Ring",
}

sets.roll["Caster's Roll"] = {
    -- legs="Chasseur's Culottes"
}
sets.roll["Tactician's Roll"] = {
    -- body="Chasseur's Frac"
}
sets.RandomDeal = {body="Lanun Frac +3"}
sets.Fold = {
    -- hands="Lanun Gauntlets"
}
sets.SnakeEye = {
    -- legs="Lanun Culottes"
}
sets.WildCard = {feet="Lanun Bottes +3"}

-- sets.Luzaf = {ring1="Luzaf's Ring"}

organizer_items = {
    echos="Echo Drops",
    holy="Holy Water",
    RREar="Reraise Earring",
    InstRR="Instant Reraise",
    Warp="Warp Ring",
    WarpItem="Instant Warp",
    CP="Trizek Ring",
    Exp="Echad Ring",
    CPMantle="Mecistopins Mantle",
    Prism="Prism Powder",
    Oils="Silent Oil",
    remedy="Remedy",
    Crepe="Pear Crepe",
    gun1="Fomalhaut",
    gun2="Death Penalty",
    bullet="Living Bullet",
    Food1="Cehuetzi Snow Cone",
    Food2="Sublime Sushi"
    -- gun1="Doomsday",
}

    user_setup()
end

function addNewColors()
    -- addTextColorPair("HighMP", "blue")
    addTextColorPair("DT", "yellow")
    addTextColorPair("Standard", "green")
    addTextColorPair("Short", "green")
    addTextColorPair("Accuracy", "yellow")
    addTextColorPair("Long", "yellow")
    addTextColorPair("Enmity", 'yellow')
end

function updateTable()
    addToTable("(F7)  Roll  Set", sets.roll.index[Roll_Index])
    addToTable("(F9)  Savage Set", sets.WS.SavageBlade.index[Savage_Index])
    addToTable("(F10) Ranged Set", sets.RA.index[rangedIndex])
    addToTable("(F11) Leaden Set", sets.WS.LeadenSalute.index[Leaden_Index])
    addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    update_message()
end

-- --- Precast ---

function precast(spell)
    if spell.english == 'Random Deal' then
        equip(sets.RandomDeal)
    elseif spell.english == 'Fold' then
        equip(sets.Fold)
    elseif spell.english == 'Snake Eye' then
        equip(sets.SnakeEye)
    elseif spell.english == 'Wild Card' then
        equip(sets.WildCard)
    elseif (spell.type == 'CorsairRoll') or (spell.name == 'Double-Up') then
        equip(set_combine(sets.roll[sets.roll.index[Roll_Index]], sets.roll[spell.name]))
    end

    if spell.action_type == 'Ranged Attack' then
        equip(sets.preshot)
    elseif spell.type:lower() == 'weaponskill' then
        if (spell.english == "Leaden Salute") then
        	equip(use_obi(spell, sets.WS.LeadenSalute[sets.WS.LeadenSalute.index[Leaden_Index]]))
        elseif (spell.english == "Savage Blade") then
              equip(sets.WS.SavageBlade[sets.WS.SavageBlade.index[Savage_Index]])
        elseif (spell.english == "Wildfire") then
        	equip(sets.WS.Generic)
        elseif (spell.english == "Last Stand") then
        	equip(sets.WS.Generic)
        else
        	equip(sets.WS.Generic)
        end
        -- add_to_chat(140, "Blah")
    end
    if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
        equip(sets.FastCast)
    end
end
-- --- MidCast ---
function midcast(spell)
    if spell.english == 'Random Deal' then
        equip(sets.RandomDeal)
    elseif spell.english == 'Fold' then
        equip(sets.Fold)
    elseif spell.english == 'Snake Eye' then
        equip(sets.SnakeEye)
    elseif spell.english == 'Wild Card' then
        equip(sets.WildCard)
    elseif (spell.type == 'CorsairRoll') or (spell.name == 'Double-Up') then
        equip(set_combine(sets.roll[sets.roll.index[Roll_Index]], sets.roll[spell.name]))
    end

    if spell.action_type == 'Ranged Attack' then
        equip(sets.RA[rangedSets[rangedIndex]])
    end
end 

-- --- Aftercast ---

function aftercast(spell)
    --equip(sets.RA)
    equip_current()
end

function status_change(new,tab)
    equip_current()
end

function equip_current()
    if player.status == 'Engaged' then
        equip_TP()
    else
        equip_idle()
    end
end

function equip_TP()
    equip(sets.Melee)
end

function equip_idle()
    equip(sets.Idle[sets.Idle.index[Idle_Index]])
end

function self_command(command)

    --toggles
    if command == 'toggle RA set' then
        rangedIndex = rangedIndex +1
        if rangedIndex > #sets.RA.index then 
            rangedIndex = 1 
        end
        send_command('@input /echo <----- RA Set changed to '..sets.RA.index[rangedIndex]..' ----->')
        equip(sets.RA[sets.RA.index[rangedIndex]])
    elseif command == 'toggle dt' then
        Idle_Index = Idle_Index +1
        if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
        add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
        equip(sets.Idle[sets.Idle.index[Idle_Index]])
    elseif command == 'toggle roll' then
        Roll_Index = Roll_Index +1
        if Roll_Index > #sets.roll.index then Roll_Index = 1 end
        add_to_chat(140, '<----- Roll Set changed to '..sets.roll.index[Roll_Index]..' ----->')
    elseif command == 'toggle leaden' then
        Leaden_Index = Leaden_Index +1
        if Leaden_Index > #sets.WS.LeadenSalute.index then Leaden_Index = 1 end
        add_to_chat(140, '<----- Leaden Set changed to '..sets.WS.LeadenSalute.index[Leaden_Index]..' ----->') 
        elseif command == 'toggle savage' then
        Savage_Index = Savage_Index +1
        if Savage_Index > #sets.WS.SavageBlade.index then Savage_Index = 1 end
        add_to_chat(140, '<----- Savage Set changed to '..sets.WS.SavageBlade.index[Savage_Index]..' ----->') 
    end


    if command == 'aimAtTarget' then
        send_command('input /attack on')
        send_command('setkey numpad2 down')
        send_command('wait 0.1; gs c finishAiming')
    elseif command == 'finishAiming' then
        send_command('setkey numpad2 up')
        send_command('autora start')
    elseif command == 'equipmelee' then
        equip({main="Naegling", sub="Lanun Knife", ranged="Anarchy +2"})
    elseif command == 'equipranged' then
        equip({main="Lanun Knife", sub="Naegling", ranged="Death Penalty", ammo="Living Bullet"})
    elseif command == 'unequip' then
        equip({main="", sub=""})
    end
    updateTable()
end

function user_setup()
    add_to_chat(140, "Loading Julika's Gearswap")
    send_command('bind f7 gs c toggle roll')
    send_command('bind f9 gs c toggle savage')
    send_command('bind f10 gs c toggle RA set')
    send_command('bind f11 gs c toggle leaden')
    send_command('bind f12 gs c toggle dt')
    send_command('bind pause send @others /follow Julika')

    text_setup()
    addNewColors()
    updateTable()
end

function file_unload()
    add_to_chat(140, "Unloading Julika's COR gearswap.")
end

function use_obi(spell, equip_set)
    local use_obi = false
    -- first check to see if any elemental obi rule matches
    if (spell.name == "Leaden Salute") then
        spell.element = "Dark"
    end
    if(S{world.day_element, world.weather_element}:contains(spell.element)) then
        -- If at least one matches, try to find out if there is also a weak element involved
        if (world.weather_element == elements.weak_against[spell.element] ) then
            -- If weak weather is involved, but it is only single weather, check to see if use_on_single_conflict is set to true
            if (world.weather_id % 2 == 0 and elements.use_on_single_conflict) then
                use_obi = true
            end
        elseif (world.day_element == elements.weak_against[spell.element]) then
            -- If weak day is involved check for double weather or single weather + use_on_single_conflict set to true
            if (world.weather_id % 2 == 1 or ( elements[use_on_single_conflict] and world.weather_id % 2 == 0) ) then
                use_obi = true
            end
        else
            use_obi = true
        end
    end
 
    if (use_obi) then
        equip_set =  set_combine(equip_set, {waist="Hachirin-no-obi"})
        -- equip_set = set_combine(equip_set, sets.midcast_ElementalDay)
    end
 
    return equip_set
end