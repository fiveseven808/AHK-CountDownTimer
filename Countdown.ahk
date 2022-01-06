#SingleInstance
;Progress, m1 b fs70 fm12 zh10 CTgreen w250, % "00:00", Enter start time
reset:
	settimer,label,Delete
	y := ""
	x := ""
	w := ""
	Progress, m2 fs70 fm12 zh10 CTgreen w250, % "00:00", Enter start time
	loop,4
		{
		Input x, L1,{esc}{enter},1,2,3,4,5,6,7,8,9,0
		w .= x , y := SubStr("000" w, -3)
		if (ErrorLevel = "Match")
			;Progress, m1 b fs70 fm12 zh10 CTgreen w250, % SubStr(y,1,2) ":" SubStr(y,3,2), Enter to accept and start
			Progress, m2 fs70 fm12 zh10 CTgreen w250, % SubStr(y,1,2) ":" SubStr(y,3,2), Enter to accept and start
		else if (Errorlevel = "EndKey:enter")
			break
		else
			exitapp
		}
startover:
	t := 0, w := SubStr(y,1,2)*60 + SubStr(y,3,2)
	settimer,label,1000
	return
	label:
	++t
	if (t < w)
		Progress, % 100*(w-t)/w, % SubStr("00" floor((w-t)/60),-1) ":" SubStr("00" mod(w-t,60),-1), count down
	else if (t = w)
		{
		;Progress, m1 b fs70 fm12 zh10 CTred w250, 0, Done!
		Progress, m2 fs70 fm12 zh10 CTred w250, 0, Done!
		;SoundPlay, *48
		}
	else if (t > w)
		Progress, , % SubStr("0" floor((t-w)/60), -1) ":" SubStr("0" mod(t-w,60), -1), count up

;#IfWinActive ahk_class AutoHotkey2

;p:: settimer,label,% (a:=!a) ? "off" : "on"
#IfWinActive Countdown.ahk
s::	goto startover
r:: goto reset
esc:: ExitApp
