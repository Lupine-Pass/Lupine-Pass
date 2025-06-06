/datum/subclass/farmer
	name = "Village Farmer"
	tutorial = "As a Peasent, you are a skilled farmer, able to grow a variety of berrys and apples. \
	Join the local Soilsmen at their farm, or make your own little orchard."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	outfit = /datum/outfit/job/roguetown/towner/farmer
	category_tags = list(CTAG_TOWNER)
	maximum_possible_slots = 3

/datum/outfit/job/roguetown/towner/farmer/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/farming, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 0, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	shirt = null
	pants = /obj/item/clothing/under/roguetown/tights/stockings/silk
	head = /obj/item/clothing/head/roguetown/armingcap
	shoes = null
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/clothing/neck/roguetown/collar/leather/cursed
	armor = null
	mouth = /obj/item/rogueweapon/huntingknife
	beltr = /obj/item/flint
	beltl = /obj/item/key/farm
	backr = /obj/item/rogueweapon/hoe
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		pants = null
	backpack_contents = list(/obj/item/seeds/wheat=1,/obj/item/seeds/apple=1,/obj/item/ash=1)
	H.change_stat("strength", 1)
	H.change_stat("endurance", 1)
	H.change_stat("intelligence", -2)
	H.change_stat("speed", 0)
	if(H.age == AGE_MIDDLEAGED)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
