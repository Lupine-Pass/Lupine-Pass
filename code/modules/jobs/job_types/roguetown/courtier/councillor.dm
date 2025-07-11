/datum/job/roguetown/foreign_noble
	title = "Foreign Noble"
	flag = FOREIGN_NOBLE
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 10
	spawn_positions = 10
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_FOREIGN_NOBLE
	allowed_patrons = ALL_NON_INHUMEN_PATRONS
	tutorial = "You've cruelly paid good money to use the services here."
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/foreign_noble

	give_bank_account = 40
	min_pq = 0
	max_pq = null

/datum/job/roguetown/foreign_noble/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		to_chat(H, span_notice("Setting up your noble appearance..."))
		
		var/index = findtext(H.real_name, " ")
		if(index)
			index = copytext(H.real_name, 1,index)
		if(!index)
			index = H.real_name
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Lord"
		if(H.gender == FEMALE)
			honorary = "Lady"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		
		// Schedule the choices to happen after a short delay
		addtimer(CALLBACK(src, PROC_REF(present_noble_choices), H), 1 SECONDS)

/datum/job/roguetown/foreign_noble/proc/present_noble_choices(mob/living/carbon/human/H)
	if(!H || !ishuman(H))
		return
		
	// Let them choose a mask
	to_chat(H, span_notice("Please choose your mask..."))
	var/list/mask_choices = list(
		"Steel Mask" = /obj/item/clothing/mask/rogue/facemask/steel,
		"Gold Mask" = /obj/item/clothing/mask/rogue/facemask/goldmask,
		"Psydonian Mask" = /obj/item/clothing/mask/rogue/facemask/psydonmask,
		"Eoran Mask" = /obj/item/clothing/head/roguetown/eoramask,
		"Death Mask" = /obj/item/clothing/head/roguetown/necramask
	)
	
	var/mask_choice = input(H, "Choose your mask", "Mask Selection") as null|anything in mask_choices
	if(mask_choice)
		var/mask_path = mask_choices[mask_choice]
		var/obj/item/clothing/mask/new_mask = new mask_path(H)
		if(H.equip_to_slot_or_del(new_mask, SLOT_WEAR_MASK))
			to_chat(H, span_notice("You equip the [mask_choice]."))
		else
			to_chat(H, span_warning("Failed to equip the [mask_choice]!"))
	else
		to_chat(H, span_warning("No mask was selected!"))
	
	// Let them choose between mortal and vampire
	to_chat(H, span_notice("Now choose your nature..."))
	var/moral_choice = alert(H, "Choose your nature", "Nature Selection", "Mortal", "Vampire")
	if(moral_choice == "Vampire")
		to_chat(H, span_notice("You have chosen to become a vampire..."))
		var/datum/antagonist/vampire/new_antag = new /datum/antagonist/vampire()
		if(H.mind)
			H.mind.add_antag_datum(new_antag)
			// Add vampire traits
			ADD_TRAIT(H, TRAIT_STRONGBITE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOSTAMINA, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOBREATH, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_LIMPDICK, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SPECIALUNDEAD, TRAIT_GENERIC)
			// Give them night vision eyes
			var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
			if(eyes)
				eyes.Remove(H,1)
				QDEL_NULL(eyes)
			eyes = new /obj/item/organ/eyes/night_vision/zombie
			eyes.Insert(H)
			to_chat(H, span_notice("You are now a vampire!"))
		else
			to_chat(H, span_warning("Failed to make you a vampire - no mind found!"))
	else
		to_chat(H, span_notice("You remain mortal."))

/datum/outfit/job/roguetown/foreign_noble/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/councillor
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/armor
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/keyring/councillor
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1, /obj/item/leash/leather = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 1)
		H.change_stat("fortune", 1)

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw, /mob/living/carbon/human/proc/request_law, /mob/living/carbon/human/proc/request_law_removal)


/mob/living/carbon/human/proc/request_law()
	set name = "Request Law"
	set category = "Council Law"
	if(stat)
		return
	var/inputty = input("Write a new law", "MARTIAL LAW") as text|null
	if(inputty)
		if(hasomen(OMEN_NOLORD))
			make_law(inputty)
		else
			var/lord = find_lord()
			if(lord)
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_law_requested), src, lord, inputty)
			else
				make_law(inputty)


/mob/living/carbon/human/proc/request_law_removal()
	set name = "Request Law Removal"
	set category = "Council Law"
	if(stat)
		return
	var/inputty = input("Remove a law", "MARTIAL LAW") as text|null
	var/law_index = text2num(inputty) || 0
	if(law_index && GLOB.laws_of_the_land[law_index])
		if(hasomen(OMEN_NOLORD))
			remove_law(law_index)
		else
			var/lord = find_lord()
			if(lord)
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_law_removal_requested), src, lord, law_index)
			else
				remove_law(law_index)


/mob/living/carbon/human/proc/request_outlaw()
	set name = "Request Outlaw"
	set category = "Council Law"
	if(stat)
		return
	var/inputty = input("Outlaw a person", "COUNCIL LAW") as text|null
	if(inputty)
		if(hasomen(OMEN_NOLORD))
			make_outlaw(inputty)
		else
			var/lord = find_lord()
			if(lord)
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_outlaw_requested), src, lord, inputty)
			else
				make_outlaw(inputty)


/proc/find_lord(required_stat = CONSCIOUS)
	var/mob/living/lord
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(!H.mind || H.job != "Duke" || (H.stat > required_stat))
			continue
		lord = H
		break
	return lord


/proc/lord_law_requested(mob/living/councillor, mob/living/carbon/human/lord, requested_law)
	var/choice = alert(lord, "The Council requests a new law!\n[requested_law]", "COUNCIL LAW REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(councillor)
			to_chat(councillor, span_warning("The Duke has denied the request for a new law!"))
		return
	make_law(requested_law)

/proc/lord_law_removal_requested(mob/living/councillor, mob/living/carbon/human/lord, requested_law)
	if(!requested_law || !GLOB.laws_of_the_land[requested_law])
		return
	var/choice = alert(lord, "The Council requests the removal of a law!\n[GLOB.laws_of_the_land[requested_law]]", "COUNCIL", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(councillor)
			to_chat(councillor, span_warning("The Duke has denied the request for a law removal!"))
		return
	remove_law(requested_law)

/proc/lord_outlaw_requested(mob/living/councillor, mob/living/carbon/human/lord, requested_outlaw)
	var/choice = alert(lord, "The Council requests to outlaw someone!\n[requested_outlaw]", "COUNCIL OUTLAW REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(councillor)
			to_chat(councillor, span_warning("The Duke has denied the request for declaring an outlaw!"))
		return
	make_outlaw(requested_outlaw)
