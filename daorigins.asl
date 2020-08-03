state("DAOrigins")
{
	bool isLoading : 0x007E0A4C, 0x0, 0x5E4, 0xA8, 0x7E0, 0x42C;
	bool isLoadingScreen : 0x007DD6D4, 0x27C, 0x274, 0x8, 0x4, 0x40C;
	int start : 0x7E5A9C;
	string30 currentLevel : 0x007DD87C, 0x178, 0x8, 0x54, 0x1C, 0x8, 0x3D1;
	int incrementOnKill : 0x007F5100, 0x178, 0x114;
	int dragon : 0x007E9AEC, 0x28, 0x54, 0x48, 0x34, 0x52C, 0x4, 0x8, 0xB38;
}

startup
{
	settings.Add("mapSplits", false, "Lem Splits");
}

init
{
	vars.preFirstLoad = true;
	vars.isLoading = true;
	vars.lastMap = "";
	vars.lastMapOld = "";
}


exit
{
    timer.IsGameTimePaused = true;
}

split
{
	vars.lastMapOld = vars.lastMap;
	if (current.currentLevel != null && current.currentLevel.Length > 1) vars.lastMap = current.currentLevel;
	if (current.dragon == 1 && old.dragon == 0 && 
		current.currentLevel == "cli220ar_fort_roof_1") {
		return true;
	}
	if (settings["mapSplits"] && vars.lastMap != vars.lastMapOld && vars.lastMap.Length > 1 && vars.lastMapOld.Length > 1) {
		if ("bhm600ar_fade_harrowing".Contains(vars.lastMapOld) && "bhm100ar_tower_level_1".Contains(vars.lastMap)) {
			return true;
		}
		if ("bhm100ar_tower_level_1".Contains(vars.lastMapOld) && "pre100ar_kings_camp".Contains(vars.lastMap)) {
			return true;
		}
		if ("pre100ar_kings_camp_night".Contains(vars.lastMapOld) && "pre410ar_tower_level_1".Contains(vars.lastMap)) {
			return true;
		}
		if ("pre440ar_tower_level_4".Contains(vars.lastMapOld) && "pre211ar_flemeths_hut_int".Contains(vars.lastMap)) {
			return true;
		}
		if (("cam100ar_camp_plains".Contains(vars.lastMapOld) || 
			"cam104ar_camp_arch1".Contains(vars.lastMapOld) || 
			"cam110ar_camp_arch3".Contains(vars.lastMapOld) || 
			"ran270ar_forest_ambush".Contains(vars.lastMapOld) || 
			"ran700ar_merchant".Contains(vars.lastMapOld) || 
			"ran300ar_plains_darkspawn_3".Contains(vars.lastMapOld)) && "den200ar_market".Contains(vars.lastMap)) {
			return true;
		}
		if (("den400ar_fort".Contains(vars.lastMapOld) || 
			"cam100ar_camp_plains".Contains(vars.lastMapOld) || 
			"cam104ar_camp_arch1".Contains(vars.lastMapOld) || 
			"cam110ar_camp_arch3".Contains(vars.lastMapOld) || 
			"den911ar_narrow_1".Contains(vars.lastMapOld) || 
			"den912ar_narrow_2".Contains(vars.lastMapOld) || 
			"den920ar_crows".Contains(vars.lastMapOld) || 
			"den921ar_wide_1".Contains(vars.lastMapOld) || 
			"den922ar_wide_2".Contains(vars.lastMapOld)) && "den200ar_market".Contains(vars.lastMap)) {
			return true;
		}
		if (("den300ar_elven_alienage".Contains(vars.lastMapOld) || 
			"den911ar_narrow_1".Contains(vars.lastMapOld) || 
			"den912ar_narrow_2".Contains(vars.lastMapOld) || 
			"den920ar_crows".Contains(vars.lastMapOld) || 
			"den921ar_wide_1".Contains(vars.lastMapOld) || 
			"den922ar_wide_2".Contains(vars.lastMapOld)) && "den200ar_market".Contains(vars.lastMap)) {
			return true;
		}
		if (("den211ar_arl_eamon_estate_1".Contains(vars.lastMapOld) || 
			"den410ar_arl_eamon_estate_2".Contains(vars.lastMapOld)) && "den200ar_market".Contains(vars.lastMap)) {
			return true;
		}
		if ("cli300ar_redcliffe_castle".Contains(vars.lastMapOld) && "den200ar_market".Contains(vars.lastMap)) {
			return true;
		}
		if ("cli700ar_markets".Contains(vars.lastMapOld) && "cli800ar_palace_district".Contains(vars.lastMap)) {
			return true;
		}
		if ("cli210ar_fort_second_floor".Contains(vars.lastMapOld) && "cli220ar_fort_roof_1".Contains(vars.lastMap)) {
			return true;
		}
	}
	return false;
}

start
{
	if (current.start == 0 && old.start == 30) {
		return true;
	}
	return false;
}

update
{
    vars.isLoading = current.isLoading || current.isLoadingScreen;
    if (vars.preFirstLoad && vars.isLoading) {
        vars.preFirstLoad = false;
    }
}

isLoading
{
    return vars.preFirstLoad || vars.isLoading;
}
