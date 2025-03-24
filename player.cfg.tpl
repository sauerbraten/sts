pool = [ echo (concat "^f8map pool:" (prettylist $tourney_map_pool)) ]
tourney = [
    newgui tourney [
    	guititle "Map pool:"
        guialign 0 [ guilist [ looplist m $tourney_map_pool [ guitext $m 0 ] ] ]
        guistrut .5
        guititle "Servers:"
        push srv_grp_buttons [ loop i 8 [ push n (+ $i 1) [ guibutton (format "%1%2" @@arg1 $n) [connect @@@arg2 @[n]000] "server" ] ] ] [
            guialign 0 [
                loop i (listlen $tourney_server_allocation) [
                    if (> $i 0) [ guistrut 1.5 ]
                    guilist [ srv_grp_buttons @(strreplace (at $tourney_server_allocation $i) "=" " ") ]
                ]
            ]
        ]
    ] $tourney_name
    showgui tourney
]
