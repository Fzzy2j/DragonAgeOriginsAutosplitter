state("DAOrigins")
{
    bool isLoading : 0x007E0A4C, 0x0, 0x5E4, 0xA8, 0x7E0, 0x42C;
    bool isLoadingScreen : 0x007DD6D4, 0x27C, 0x274, 0x8, 0x4, 0x40C;
	int start : 0x7E5A9C;
	string20 currentLevel : 0x007DD784, 0x44, 0x60, 0x1C, 0x2C, 0x0, 0x0, 0xB0, 0x14, 0x24C;
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
}


exit
{
    timer.IsGameTimePaused = true;
}

split
{
	if (current.dragon == 1 && old.dragon == 0 && 
		current.currentLevel == "Fort Drakon - Roof") {
		return true;
	}
	if (settings["mapSplits"] && current.currentLevel != old.currentLevel) {
		if ("The Fade".StartsWith(vars.lastMap) && "Apprentice Quarters".StartsWith(current.currentLevel)) {
			return true;
		}
		if ("Mage Tower - Basement".StartsWith(vars.lastMap) && "Ostagar".StartsWith(current.currentLevel)) {
			return true;
		}
		if ("Ostagar".StartsWith(vars.lastMap) && "Tower of Ishal - First Floor".StartsWith(current.currentLevel)) {
			return true;
		}
		if ("Tower of Ishal - Upper Floor".StartsWith(vars.lastMap) && "Hut".StartsWith(current.currentLevel)) {
			return true;
		}
		if (("Camp".StartsWith(vars.lastMap) || 
			"Twisted Path".StartsWith(vars.lastMap) || 
			"Gentle Path".StartsWith(vars.lastMap) || 
			"Bloody Plains".StartsWith(vars.lastMap)) && "Denerim Market District".StartsWith(current.currentLevel)) {
			return true;
		}
		if (("Camp".StartsWith(vars.lastMap) || 
			"Fort Drakon".StartsWith(vars.lastMap)) && "Denerim Market District".StartsWith(current.currentLevel)) {
			return true;
		}
		if ("Elven Alienage".StartsWith(vars.lastMap) && "Denerim Market District".StartsWith(current.currentLevel)) {
			return true;
		}
		if ("Arl Eamon's Estate".StartsWith(vars.lastMap) && "Denerim Market District".StartsWith(current.currentLevel)) {
			return true;
		}
		if ("Redcliffe Castle - Main Floor".StartsWith(vars.lastMap) && "Denerim Market District".StartsWith(current.currentLevel)) {
			return true;
		}
		if ("Denerim - Market District".StartsWith(vars.lastMap) && "Palace District".StartsWith(current.currentLevel)) {
			return true;
		}
		if ("Fort Drakon - Second Floor".StartsWith(vars.lastMap) && "For Drakon - Roof".StartsWith(current.currentLevel)) {
			return true;
		}
	}
	if (current.currentLevel != null && current.currentLevel.Length > 0) vars.lastMap = current.currentLevel;
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
