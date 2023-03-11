  Config { 
  -- appearance
     font        =  "Font Awesome 6 Free Solid 16"
   , additionalFonts = [ "Bitstream Vera Sans Mono 16"]  
   , bgColor     =  "black"
   , fgColor     =  "white"
   , position    =  Static { xpos = 0, ypos = 0, width = 1920, height = 25 }
   , border      =  BottomB 
   , borderColor =  "#646464"

   -- layout
   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignmen t
   , template = " <fc=#0088cc>%XMonadLog%</fc> }{ <fc=#00b3b3>%cpu%</fc> | <fc=#e04a5c>%memory%</fc> | <fc=#e28a00>%battery%</fc> | <fc=#aa80ff>%date%</fc> "

   -- general behavior
   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       True    -- enable/disable hiding (True = disabled)

   , commands = 

        -- weather monitor
        [ Run Weather "VOCB" [ "--template", "<skyCondition> | <fc=#4682B4><tempC></fc>°C | <fc=#4682B4><rh></fc>% | <fc=#4682B4><pressure></fc>hPa"
                             ] 36000

        -- network activity monitor (dynamic interface resolution)
        , Run DynNetwork     [ "--template" , " <dev>: <tx>kB/s|<rx>kB/s "
                             , "--Low"      , "1000"       -- units: B/s
                             , "--High"     , "5000"       -- units: B/s
                             , "--low"      , "green"
                             , "--normal"   , "orange"
                             , "--high"     , "red"
                             ] 10

        -- cpu activity monitor
        , Run Cpu            [ "-t" , " Cpu: <total>% "
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "#66ff00"
                             , "--normal"   , "yellow"
                             , "--high"     , "red"
                             ] 10

        -- cpu core temperature monitor
        , Run CoreTemp       [ "--template" , "Temp: <core0>°C|<core1>°C "
                             , "--Low"      , "70"        -- units: °C
                             , "--High"     , "80"        -- units: °C
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 50
                          
        -- memory usage monitor
        , Run Memory         [ "--template" ," Mem: <usedratio>% "
                             , "--Low"      , "40"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "#66ff00"
                             , "--normal"   , "yellow"
                             , "--high"     , "red"
                             ] 10

        -- battery monitor
        , Run Battery        [ "--template" , "Batt: <acstatus>"
                             , "--Low"      , "15"        -- units: %
                             , "--High"     , "75"        -- units: %
                             , "--low"      , "red"
                             , "--normal"   , "#66ff00"
                             , "--high"     , "#66ff00"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=green>Charging</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#006000>Charged</fc>"
                             ] 50

        -- time and date indicator 
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date " <fc=#ff66cc>%b %d %Y</fc> <fc=white>|</fc> %H:%M:%S " "date" 10

        -- keyboard layout indicator
        , Run Kbd            [ ("us(dvorak)" , "<fc=#00008B>DV</fc>")
                             , ("us"         , "<fc=#8B0000>US</fc>")
                             ]

        , Run XMonadLog
        ]
   }
