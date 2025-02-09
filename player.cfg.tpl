defsvar tourney_map_pool "${TOURNEY_MAP_POOL}"

pool = [ echo (concat "^f8map pool:" (prettylist $tourney_map_pool)) ]

defsvar tourney_server_allocation "${TOURNEY_SERVER_ALLOCATION}" // e.g. "EU 1.2.3.4 4 NA 2.3.4.5 2"

tourney = [
    newgui tourney [
    	guititle "Map pool:"
        guialign 0 [ guilist [ looplist m $tourney_map_pool [ guitext $m 0 ] ] ]
        guistrut .5
        guititle "Servers:"
        push srv_grp_buttons [ loop i $arg3 [ push n (+ @i 1) [ guibutton (format "%1 #%2" @@arg1 $n) [connect @@@arg2 @[n]000] "server" ] ] ] [
            guialign 0 [
                loop i @(div (listlen $tourney_server_allocation) 3) [
                    if (> @i 0) [ guistrut 1.5 ]
                    guilist [ srv_grp_buttons @(sublist $tourney_server_allocation (* $i 3) 3) ]
                ]
            ]
        ]
    ] "${TOURNEY_NAME}"
    showgui tourney
]
