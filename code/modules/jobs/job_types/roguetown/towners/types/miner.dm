/datum/subclass/miner
	name = "Miner"
	tutorial = "You are a Miner, you mine for the local blacksmith, gathering rare ores. \
	There are tales of ambitious dwarf miners building great forts in the lavalands, to harvest all of it's hardly touched ores."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/towner/miner

	category_tags = list(CTAG_SLAVE)

/datum/outfit/job/roguetown/towner/miner/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/collar/leather/cursed
	shirt = null
	armor = null
	shoes = null
	pants = /obj/item/clothing/under/roguetown/tights/stockings/silk
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/pick
	beltr = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueweapon/huntingknife = 1, /obj/item/rogueweapon/chisel = 1, /obj/item/rogueweapon/hammer/wood,)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // Tough. Well fed. The strongest of the strong.
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("intelligence", -1)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 2)
		H.change_stat("fortune", 2)
		if(H.age == AGE_MIDDLEAGED)
			H.mind.adjust_skillrank(/datum/skill/labor/mining, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE)
