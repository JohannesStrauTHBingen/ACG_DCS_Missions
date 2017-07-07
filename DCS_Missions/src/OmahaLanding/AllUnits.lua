---
--by Johannes Strauﬂ aka IronJockel

jagtwaffe = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()
fighterwings = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterStart()
gerRecUnits = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes("Ger"):FilterStart()
usRecUnits = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes("US"):FilterStart()
 
raid1 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17One"):FilterStart()
raid2 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Two"):FilterStart()
raid3 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Third"):FilterStart()
raid4 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Four"):FilterStart()
raid5 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Five"):FilterStart()
raid6 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Six"):FilterStart()
raid7 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Seven"):FilterStart()
raid8 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Eight"):FilterStart()
raid9 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Nine"):FilterStart()
raid10 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Ten"):FilterStart()
raid11 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Eleven"):FilterStart()
bombers = nil