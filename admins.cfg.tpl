pool = [ echo (concat "^f8map pool:" (prettylist "<tourney_map_pool>")) ]
tourney = [
    newgui t [
    	guititle "Map pool:"
        guialign 0 [ guilist [ looplist m "<tourney_map_pool>" [ guitext $m 0 ] ] ]
        guistrut .5
        guititle "Servers:"
        push srv_button [
            guibutton [@arg1@arg3] [ connect @arg2 @[arg3]000 ] "server"
        ] [
            push srv_group [
                guilist [
                    loop i 8 [
                        srv_button @(strreplace @@arg1 "=" " ") (+ $i 1)
                    ]
                ]
            ] [
                guialign 0 [
                    looplist s "<server_allocation>" [
                        guistrut .75; srv_group $s; guistrut .75
                    ]
                ]
            ]
        ]
    ] "<tourney_name>"
    showgui t
]
announcepool = [
    push msg (concat "^f8map pool:" (prettylist "<tourney_map_pool>")) [
        servcmd do (format "sendservmsg %1" (escape $msg))
    ]
]
announcematch = [ // <team/player 1> <team/player 2> <server>
    local p1 p2 srv
    p1 = $arg1; p2 = $arg2; srv = (? (getalias arg3) $arg3 "this server")
    push msg (format "^f8upcoming match: %1 vs. %2 (on %3)" $p1 $p2 $srv) [
        servcmd do (format "sendservmsg %1" (escape $msg))
    ]
]
specall = [ // [<team>]
    looplist cn (listclients 1 1 0 $arg1) [spectator 1 $cn]
]
