tourney_announce_pool = [
    push msg (concat "^f8map pool:" (prettylist $tourney_map_pool)) [
        servcmd do (format "sendservmsg %1" (escape $msg))
    ]
]

tourney_announce_match = [ // <team/player 1> <team/player 2> <server>
    local p1 p2 srv
    p1 = $arg1; p2 = $arg2; srv = (? (getalias arg3) $arg3 "this server")
    push msg (format "^f8upcoming match: %1 vs. %2 (on %3)" $p1 $p2 $srv) [
        servcmd do (format "sendservmsg %1" (escape $msg))
    ]
]

tourney_spec_all = [ // [<team>]
    looplist cn (listclients 1 1 0 $arg1) [spectator 1 $cn]
]
