pool = [ echo (concat "^f8map pool:" (prettylist "<tourney_map_pool>")) ]
tourney = [ newgui t [ push b [ guibutton [@arg1@arg3] [ connect @arg2 @[arg3]000 ] "server" ] [ looplist s "<server_allocation>" [ loop i 8 [ b @(strreplace $s "=" " ") (+ $i 1) ] ] ] ] "<tourney_name>"; showgui t ]
