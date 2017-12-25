-- Label parameters
-- Copyright (C) 2004, Eagle Dynamics.

AirOn			 		= true
GroundOn 		 		= false
NavyOn		 	 		= false
WeaponOn 		 		= false
labels_format_version 	= 1 -- labels format vesrion

-- Label max distance depends on graphics visibility range option value
-- For low E40000.0 m
-- For medium E50000.0 m
-- For high E80000.0 m

---------------------------------
-- Label text format symbols
-- %N - name of object
-- %D - distance to object
-- %P - pilot name
-- %n - new line 
-- %% - symbol '%'
-- %x, where x is not NDPn% - symbol 'x'
-- %C - extended info for vehicle's and ship's weapon systems
------------------------------------------
-- Example
-- labelFormat[5000] = {"Name: %N%nDistance: %D%n Pilot: %P","LeftBottom",0,0}
-- up to 5km label is:
--       Name: Su-33
--       Distance: 30km
--       Pilot: Pilot1


-- alignment options 
--"RightBottom"
--"LeftTop"
--"RightTop"
--"LeftCenter"
--"RightCenter"
--"CenterBottom"
--"CenterTop"
--"CenterCenter"
--"LeftBottom"
font_properties =  {"DejaVuLGCSans.ttf", 15, 0, 0, 0}
AirFormat = {
--[distance]		= {format , alignment,color_blending_k,opacity,shift_pixels_x,shift_in_pixels_y}
[500]	= {"˙","CenterCenter",1, 0.0, 0, -5},
[600]	= {"˙","CenterCenter",1, 0.1, 0, -5},
[700]	= {"˙","CenterCenter",1, 0.1, 0, -5},
[800]	= {"˙","CenterCenter",1, 0.2, 0, -5},
[900]	= {"˙","CenterCenter",1, 0.2, 0, -5},
[1000]	= {"˙","CenterCenter",1, 0.3, 0, -5},
[1100]	= {"˙","CenterCenter",1, 0.3, 0, -5},
[1200]	= {"˙","CenterCenter",1, 0.3, 0, -5},
[1300]	= {"˙","CenterCenter",1, 0.3, 0, -5},
[1400]	= {"˙","CenterCenter",1, 0.3, 0, -5},
[1500]	= {"˙","CenterCenter",1, 0.3, 0, -5},
[1600]	= {"˙","CenterCenter",1, 0.3, 0, -5},
[1700]	= {"˙","CenterCenter",1, 0.3, 0, -5},
[1800]	= {"˙","CenterCenter",1, 0.3, 0, -5},
[1900]	= {"˙","CenterCenter",1, 0.3, 0, -5},
[2000]	= {"˙","CenterCenter",1, 0.2, 0, -5},
[3000]	= {"˙","CenterCenter",1, 0.2, 0, -5},
[4000]	= {"˙","CenterCenter",1, 0.2, 0, -5},
[5000]	= {"˙","CenterCenter",1, 0.2, 0, -5},
[6000]	= {"˙","CenterCenter",1, 0.1, 0, -5},
[7000]	= {"˙","CenterCenter",1, 0.1, 0, -5},
[8000]	= {"˙","CenterCenter",1, 0.1, 0, -5},
[9000]	= {"˙","CenterCenter",1, 0.1, 0, -5},
[10000]	= {"˙","CenterCenter",1, 0.1, 0, -5},
[80000]	= {"","CenterCenter",1, 1, 0, -5},
}

GroundFormat = {
--[distance]		= {format , alignment,color_blending_k,opacity,shift_pixels_x,shift_in_pixels_y}
[5000]  = {"{%N%n%D%n%P","LeftBottom"},
[10000] = {"~%n%D"		,"LeftBottom"},
[20000] = {"`"			,"LeftBottom"},
}

NavyFormat = {
--[distance]		= {format , alignment,color_blending_k,opacity,shift_pixels_x,shift_in_pixels_y}
[10000]	= {"{%N%n%D"	,"LeftBottom"},
[20000]	= {"~%n%D"		,"LeftBottom"},
[40000]	= {"`"			,"LeftBottom"},
}

WeaponFormat = {
--[distance]		= {format , alignment,color_blending_k,opacity,shift_pixels_x,shift_in_pixels_y}
[5000]	= {"[%N%n%D"	,"LeftBottom"},
[10000]	= {"|%n%D"		,"LeftBottom"},
[20000]	= {"|"			,"LeftBottom"},
}

-- Colors in {red, green, blue} format, volume from 0 up to 255

ColorAliesSide   = {10, 10, 10}
ColorEnemiesSide = {10, 10, 10}
ColorUnknown     = {50,50,50} -- will be blend at distance with coalition color