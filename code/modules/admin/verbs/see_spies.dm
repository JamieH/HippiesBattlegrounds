/client/proc/see_spies()
	set name = "See Spies"
	set category = "WW2"

	if(!check_rights(R_MOD))
		src << "<span class = 'danger'>You don't have the permissions.</span>"
		return
	if (!istype(ticker.mode, /datum/game_mode/ww2))
		src << "<span class = 'danger'>What spies?</span>"
		return

	print_spies(src, 1)

/proc/print_spies(whomst, var/notroundend = 0)

	if (notroundend)
		whomst << "<big>Spies:</big><br><br>"
	else
		whomst << "<big>Spies at the end of the round:</big><br><br>"

	var/list/mobs = getrussianmobs(0)|getgermanmobs(0)

	for (var/mob/living/carbon/human/H in mobs)
		if (istype(H) && H.is_spy)
			var/H_stat = (H.stat == DEAD ? "DEAD" : H.stat == UNCONSCIOUS ? "UNCONSCIOUS" : "ALIVE")
			var/is_ghosted = (H.client ? "IN BODY" : "GHOSTED OR LOGGED OUT")
			if (istype(H.original_job, /datum/job/german))
				whomst << "[H][notroundend ? "/" : ""][notroundend ? H.ckey : ""] - German soldier spying for the Russians. ([H_stat]) ([is_ghosted])<br>"
			else if (istype(H.original_job, /datum/job/russian))
				whomst << "[H][notroundend ? "/" : ""][notroundend ? H.ckey : ""] - Russian soldier spying for the Germans. ([H_stat]) ([is_ghosted])<br>"
