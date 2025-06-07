/datum/job/roguetown/citywatch
	title = "Town Watch"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 12
	spawn_positions = 12
	selection_color = JCOLOR_SOLDIER
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/lupian)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	display_order = JDO_TOWNWATCH
	allowed_patrons = ALL_NON_INHUMEN_PATRONS
	whitelist_req = TRUE
	tutorial = "You are the Town Watch. Your duty is to enforce the will of the Base Commander and maintain order. You are not here to protect the innocent, but to ensure obedience and punish defiance."
	always_show_on_latechoices = TRUE

	outfit = /datum/outfit/job/roguetown/citywatch
	give_bank_account = 16
	min_pq = 0
	max_pq = null
	subclass_cat_rolls = list(CTAG_TOWNWATCH = 3)

	cmode_music = 'sound/music/combat_guard.ogg'

/datum/outfit/job/roguetown/citywatch/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	gloves = /obj/item/clothing/gloves/roguetown/chain
	shoes = /obj/item/clothing/shoes/roguetown/armor
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/rogueweapon/mace/cudgel
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger = 1, /obj/item/rope/chain = 1, /obj/item/storage/keyring/town_watch = 1, /obj/item/reagent_containers/glass/bottle/rogue/lesserhealthpot = 1)
	if(H.mind)
		assign_skills(H)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BOGVULNERABLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SLAVER, TRAIT_GENERIC)

/datum/job/roguetown/citywatch/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/surcoat/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "town watch jupon ([index])"
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/outfit/job/roguetown/citywatch/proc/assign_skills(mob/living/carbon/human/H)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)

/mob/proc/haltyell()
	set name = "HALT!"
	set category = "Noises"
	emote("haltyell")
