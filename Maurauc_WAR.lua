require('closetCleaner')
include('organizer-lib.lua')
include('displayBox.lua')

-- Local Settings, setting the zones prior to use
toau_zones = S{"Leujaoam Sanctum","Mamool Ja Training Grounds","Lebros Cavern","Periqia","Ilrusi Atoll",
        "Nyzul Isle","Bhaflau Remnants","Arrapago Remnants","Silver Sea Remnants","Zhayolm Remnants"}

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
	"Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}

elements = {}
elements.use_on_single_conflict = false
elements.strong_against = {['Fire'] = 'Ice', ['Earth'] = 'Thunder', ['Water'] = 'Fire', ['Wind'] = 'Earth', ['Ice'] = 'Wind', ['Thunder'] = 'Water', ['Light'] = 'Dark', ['Dark'] = 'Light'}
elements.weak_against = {['Fire'] = 'Water', ['Earth'] = 'Wind', ['Water'] = 'Thunder', ['Wind'] = 'Ice', ['Ice'] = 'Fire', ['Thunder'] = 'Earth', ['Light'] = 'Dark', ['Dark'] = 'Light'}

capeLocked = false
weaponLocked = false



-- Start Functions here
-- Gear Sets
function get_sets()

	Ragnarok = "Ragnarok"
	Chango = "Chango"
	Grip = "Utu Grip"

	CapeTP = {name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	    
	CapeWS = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}


	areas = {}
	areas.AdoulinCity = S{'Eastern Adoulin','Western Adoulin','Mog Garden','Celennia Memorial Library'}

	sets.desperation = {body="Seidr Cotehardie"}
	sets.Idle = {
		feet="Hermes' Sandals"
	}

	sets.TP  ={};
	sets.TP.index = {'Standard', 'DT'}
	TP_ind = 1
	sets.TP.Standard = {
	    ammo="Ginsen",
	    head="Flam. Zucchetto +2",
	    body="Valorous Mail",
--	    hands={ name="Odyssean Gauntlets", augments={'Accuracy+25 Attack+25','Weapon Skill Acc.+3','DEX+5','Accuracy+1','Attack+12',}},
--		hands="Emicho Gauntlets",
		hands="Sulevia's Gauntlets +2",
	    legs="Pummeler's Cuisses +3",
	    feet="Pummeler's Calligae +3",
	    -- neck="Lissome Necklace",
	    neck="Warrior's Bead Necklace +1",
	    right_ear="Brutal Earring",
	    left_ear="Cessance Earring",
	    left_ring="Flamma Ring",
	    right_ring="Niqmaddu Ring",
	    back=CapeTP,
	    waist="Ioskeha Belt"
	}

	sets.DT = {
		ammo="Vanir Battery",
	    head="Hjarrandi Helm",
	    body="Hjarrandi Breast.",
	    hands="Sulev. Gauntlets +2",
	    legs="Pumm. Cuisses +3",
	    feet="Pumm. Calligae +3",
	    neck="Loricate Torque +1",
	    waist="Ioskeha Belt",
	    left_ear="Cessance Earring",
	    right_ear="Brutal Earring",
	    left_ring="Defending Ring",
	    right_ring="Regal Ring",
	    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	}

	sets.DT2 = {    
		ammo="Staunch Tathlum",
    	head="Hjarrandi Helm",
	    body="Hjarrandi Breast.",
	    hands="Sulev. Gauntlets +2",
	    legs="Pumm. Cuisses +3",
	    feet="Pumm. Calligae +3",
	    neck="War. Beads +1",
	    waist="Ioskeha Belt",
	    left_ear="Cessance Earring",
	    right_ear="Brutal Earring",
	    left_ring="Defending Ring",
	    right_ring="Regal Ring",
	    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	}

	sets.TP.DT = sets.DT2


	-- sets.Hybrid = {
	--     ammo="Staunch Tathlum",
	--     head="Flam. Zucchetto +2",
	--     neck="Loricate Torque +1",
	--     ear1="Darkness Earring",
	--     ear2="Genmei Earring",
	--     body="Souv. Cuirass +1",
	--     hands="Sulev. Gauntlets +2",
	--     ring1="Moonlight Ring",
	--     ring2="Defending Ring",
	--     back="Cichol's Mantle",
	--     waist="Ioskeha Belt",
	--     legs="Sulev. Cuisses +2",
	--     feet="Pumm. Calligae +3"
	-- }

	sets.WS = {
	    ammo="Knobkierrie",
	    head="Sulevia's Mask +2",
	    body="Dagon Breastplate",
	    hands="Sulevia's Gauntlets +2",
	    legs="Sulevia's Cuisses +2",
	    feet="Sulevia's Leggings +2",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Ishvara Earring",
	    right_ring="Regal Ring",
	    left_ring="Niqmaddu Ring",
	}

	sets.Impulse = {
	    main="Shining One",
	    sub="Utu Grip",
	    ammo="Knobkierrie",
	    head={ name="Agoge Mask +2", augments={'Enhances "Savagery" effect',}},
	    body="Pumm. Lorica +3",
	    hands={ name="Odyssean Gauntlets", augments={'Attack+27','Accuracy+8','Weapon skill damage +6%','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
	    legs={ name="Odyssean Cuisses", augments={'Potency of "Cure" effect received+3%','Weapon skill damage +4%','Accuracy+18 Attack+18',}},
	    feet="Sulev. Leggings +2",
	    neck="War. Beads +1",
	    waist="Metalsinger Belt",
	    left_ear="Ishvara Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Niqmaddu Ring",
	    right_ring="Regal Ring",
	    back=CapeWS
	}

-- 	sets.WS.Upheaval = {
-- 	    ammo="Knobkierrie",
-- 		head="Flamma Zucchetto +2",
-- 	    body="Dagon Breastplate",
-- 	    hands="Sulevia's Gauntlets +2",
-- 	    legs="Pummeler's Cuisses +3",
-- 	    feet="Sulevia's Leggings +2",
-- 	    neck="Fotia Gorget",
-- 	    -- waist="Fotia Belt",
-- 	    waist="Ioskeha Belt",
-- 	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
-- 	    right_ear="Brutal Earring",
-- 	    left_ring="Regal Ring",
-- 	    right_ring="Niqmaddu Ring",
-- 	    back=CapeWS
-- 	}

	sets.WS.Upheaval = {
	    ammo="Knobkierrie",
	    head="Agoge Mask +2",
	    neck="Fotia Gorget",
	    ear1="Moonshade Earring",
	    ear2="Telos Earring",
	    body="Pumm. Lorica +3",
	    hands="Sulev. Gauntlets +2",
	    ring2="Niqmaddu Ring",
	    ring1="Regal Ring",
	    back=CapeWS,
	    waist="Fotia Belt",
	    legs="Sulev. Cuisses +2",
	    feet="Pumm. Calligae +3"
	}

	sets.WS.Upheaval.HighTP = set_combine(sets.WS.Upheaval, {
		neck="War. Beads +1",
		hands="Odyssean Gauntlets",
		legs="Odyssean Cuisses",
		feet="Sulevia's Leggings +2",
		ear2="Ishvara Earring"
	})

	sets.WS.Upheaval.Mid = set_combine(sets.WS.Upheaval, {
		right_ear="Telos Earring",
		legs="Pummeler's Cuisses +3",
		feet="Pummeler's Calligae +3"
	})

	-- sets.TP.GS =  {
	--     ammo="Ginsen",
	--     head="Flam. Zucchetto +2",
	--     neck="Lissome Necklace",
	--     ear1="Brutal Earring",
	--     ear2="Cessance Earring",
	--     body="Valorous Mail",
	--     hands="Sulev. Gauntlets +2",
	--     --ring1="Niqmaddu Ring",
	--     ring1="Regal Ring",
	--     ring2="Flamma Ring",
	--     back=CapeTP,
	--     waist="Ioskeha Belt",
	--     legs="Pumm. Cuisses +3",
	--     feet="Pumm. Calligae +3"
	-- }

	-- sets["HighEndResolution"] = { --The ultimate goal
	--     ammo="Seeth. Bomblet +1",
	--     head="Flam. Zucchetto +2",
	--     neck="Fotia Gorget",
	--     ear1="Cessance Earring",
	--     ear2="Moonshade Earring",
	--     body="Argosy Hauberk +1",
	--     hands="Argosy Mufflers +1",
	--     ring1="Regal Ring",
	--     ring2="Niqmaddu Ring",
	--     back=CapeTP,
	--     waist="Fotia Belt",
	--     legs="Argosy Breeches +1",
	--     feet="Flam. Gambieras +2"
	-- }

	-- sets["MontaWS"] = { --A good start
	--     ammo="Knobkierrie",
	--     head="Flam. Zucchetto +2",
	--     neck="Fotia Gorget",
	--     ear1="Moonshade Earring",
	--     ear2="Brutal Earring",
	--     body="Pumm. Lorica +2",
	--     hands="Sulev. Gauntlets +2",
	--     ring1="Flamma Ring",
	--     ring2="Regal Ring",
	--     back=CapeTP,
	--     waist="Fotia Belt",
	--     legs="Pumm. Cuisses +3",
	--     feet="Pumm. Calligae +3"
	-- }

	sets.Aggressor = {
		head="Pummeler's Mask +1"
	}

	sets.Berserk = {
		body="Pummeler's Lorica +3",
		feet="Agoge Calligae"
	}

	sets.MightyStrikes = {
		hands="Agoge Mufflers"
	}

	sets.Warcry = {
		head="Agoge Mask +2"
	}

	sets.Reraise = {
		head="Twilight Helm",
		body="Twilight Mail"
	}

	windower.register_event('zone change', function()
		equip(customize_idle_set(sets.Idle))
	end)

    send_command('bind f10 gs c toggle TP set')

 text_setup()
    addTextPairs()
    updateTable()
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("Potency", "green")
    addTextColorPair("Accuracy", "yellow")
    addTextColorPair("DT", "yellow")
end

function updateTable()
    addToTable("(F10) TP Set", sets.TP.index[TP_ind])
    update_message()
end

-- --- Precast ---

function precast(spell)
	if spell.english == 'Upheaval' then
		add_to_chat(140,'Upheaval')
		if (player.tp < 1250) then 
			equip(sets.WS.Upheaval)
		else
			equip(sets.WS.Upheaval.HighTP)
		end
	elseif spell.english == "Impulse Drive" then
		equip(sets.Impulse)
		add_to_chat(140,'Impulse!')
	elseif spell.action_type == 'WeaponSkill' then	
			add_to_chat(140,'Weaponskill!')
			equip(sets.WS)
	end

	if spell.english == 'Aggressor' then
		equip(sets.Aggressor)
	end

	if spell.english == 'Berserk' then
		equip(sets.Berserk)
	end

	if spell.english == 'Mighty Strikes' then
		equip(sets.MightyStrikes)
	end

	if spell.english == 'Warcry' then
		equip(sets.Warcry)
	end
end
-- --- MidCast ---
function midcast(spell)
end	

-- --- Aftercast ---



function aftercast(spell)
	if player.status == 'Engaged' then
            equip_TP()
    else
    	equip(customize_idle_set(sets.Idle))
    end
end

-- Status Change - ie. Resting

function equip_TP()
	-- equip(sets.TP)
	equip(sets.TP[sets.TP.index[TP_ind]])
end

function status_change(new,tab)
	if new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
		--disable("Main")
	else
		equip(sets.Idle)
		--enable("Main")
	end
end

function customize_idle_set(idleSet)
    if areas.AdoulinCity:contains(world.area) then
        idleSet = set_combine(idleSet, {body="Councilor's Garb"})
    end
 
    return idleSet
end

function self_command(command)
	 if command == 'toggle TP set' then
            TP_ind = TP_ind + 1
            if TP_ind > #sets.TP.index then TP_ind = 1 end
            send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
            equip(sets.TP[sets.TP.index[TP_ind]])
        end
        updateTable()
end

function use_obi(spell, equip_set)
    local use_obi = false
    -- first check to see if any elemental obi rule matches
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
        equip_set = set_combine(equip_set, { waist = "Hachirin-No-Obi"})
    end
 
    return equip_set
end