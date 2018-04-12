#!/bin/sh
# test4.tcl \
exec tclsh "$0" ${1+"$@"}

#﻿wm title . "NS2环境中OLSR协议的研究及模拟"

foreach {package version} {
    Tk 8.4
    mysqltcl 3.0
    tile 0.7
} {
    if {[catch {package require $package $version} err]} {
	error "couldn't load $package >= $version: $err"
    }
}


#!/usr/local/bin/wish8.5
# author: wn0112@gmail.com
package require Tk

set w .
set width 230
set height 200

wm title $w Calculator
set sheight [ winfo screenheight . ]
set swidth [ winfo screenwidth . ]
wm geometry $w +[ format %.0f [ expr {($swidth-$width)/2} ]]+[ format %.0f [ expr {($sheight-$height)*0.382} ]]
wm minsize $w $width $height
wm maxsize $w $width $height
wm resizable $w 0 0

set fra [ frame $w.top -borderwidth 2  -relief ridge ]
pack $fra -side top -pady 5
set fraNum [ frame $w.num -borderwidth 0 -relief ridge ]
pack $fraNum -side top 

set lab [ entry $fra.l -width 32 -justify right -relief flat -vcmd { string is integer 0 } ]
pack $lab -side top -anchor se -ipadx 10 -ipady 1

foreach i { 1 2 3 4 5 6 7 8 9 } {
	button $fraNum.$i -text $i -command "insertNum $i" -relief groove 
	bind $fraNum <Key-$i> "insertNum $i"
}
button $fraNum.0 -text 0 -command "insertZero" -relief groove 
button $fraNum.n -text n! -command "compute2 jc" -relief groove -width 3
button $fraNum.negater -text \ub1 -command "negater" -relief groove -width 3
button $fraNum.plus -text + -command "symbol +" -relief groove
button $fraNum.sub -text - -command "symbol -" -relief groove
button $fraNum.mult -text \ud7 -command "symbol *"  -relief groove
button $fraNum.div -text \uf7 -command "symbol /" -relief groove  
button $fraNum.c -text C -command "click_C"  -relief groove -width 3
button $fraNum.equal -text = -command "compute"  -relief groove
button $fraNum.sqrt -text \u221a -command "compute2 sqrt"  -relief groove
button $fraNum.dot -text . -command "insertDot" -relief groove
button $fraNum.recip -text 1/x -command "compute2 recip"  -relief groove
button $fraNum.square -text x\ub2 -command "compute2 square"  -relief groove
button $fraNum.back -text \u2190 -command "backspace" -relief groove -width 3
button $fraNum.ce -text CE -command "click_CE" -relief groove -width 3
checkbutton $fraNum.ms -text MS -command "MS" -indicatoron 0 -variable calc(MS) -onvalue 1 -offvalue 0 -width 1
button $fraNum.mr -text MR -command "MR" -relief groove
button $fraNum.mc -text MC -command "MC" -relief groove
button $fraNum.mplus -text M+ -command "Mplus" -relief groove
button $fraNum.msub -text M- -command "Msub" -relief groove

grid $fraNum.ms $fraNum.back $fraNum.ce $fraNum.c $fraNum.negater $fraNum.n -sticky nsew -padx 3 -pady 3
grid $fraNum.mr $fraNum.7 $fraNum.8 $fraNum.9 $fraNum.div $fraNum.sqrt -sticky nsew -padx 3 -pady 3
grid $fraNum.mc $fraNum.4 $fraNum.5 $fraNum.6 $fraNum.mult $fraNum.square -sticky nsew -padx 3 -pady 3
grid $fraNum.mplus $fraNum.1 $fraNum.2 $fraNum.3 $fraNum.sub $fraNum.recip -sticky nsew -padx 3 -pady 3
grid $fraNum.msub -sticky nsew -padx 3 -pady 3
grid $fraNum.0 -sticky nsew -padx 3 -pady 3 -row 4 -column 1 -columnspan 2
grid $fraNum.dot -sticky nsew -padx 3 -pady 3 -row 4 -column 3
grid $fraNum.plus -sticky nsew -padx 3 -pady 3 -row 4 -column 4
grid $fraNum.equal -sticky nsew -padx 3 -pady 3 -row 4 -column 5

bind $fraNum <Key-0> "insertZero"
bind $fraNum + "symbol +"
bind $fraNum - "symbol -"
bind $fraNum * "symbol *"
bind $fraNum / "symbol /"
bind $fraNum . "insertDot"
bind $fraNum <Escape> exit
bind $fraNum <Return> "compute"
bind $fraNum <BackSpace> "backspace"
set font [ $fraNum.0 cget -font ]
foreach val [ winfo children $fraNum ] {
	bind $val <Enter> [ list $val configure -relief ridge -activeforeground white -activebackground lightblue -font "$font 9 bold" ]
	bind $val <Leave> [ list $val configure -relief groove -font "$font" ]
}

focus -force $fraNum

set calc(x) ""
set calc(y) ""
set calc(symbol) ""
set calc(MSv) 0
set calc(clear) 0

proc insertDot { } {
	global lab calc
	if {[ string length [ regsub {\.} [ string trimleft [ $lab get ]  0 ] "" ]] == 32 \
		|| [ regexp {[^\d\.]+$]} [ $lab get ]]} {
		return
	}
	if { $calc(clear) == 1 } {
		clear
		Ins 0
	}
	if {[ regexp -all {\.} [ $lab get ]] == 0 } {
		Ins .
		set calc(clear) 0
	}
}

proc insertZero { } {
	global lab calc
	if {[ string length [ regsub {\.} [ string trimleft [ $lab get ]  0 ] "" ]] == 32 \
		|| [ regexp {[^\d\.]+$]} [ $lab get ]]} {
		return
	}
	if { $calc(clear) == 1 } {
		clear
		Ins 0
	}
	if {[ $lab get ] ne 0 } {
		Ins 0
		set calc(clear) 0
	}
}

proc insertNum { value } {
	global lab calc
	if { $calc(clear) == 1 } {
		clear
		Ins 0
	}
	if {[ string length [ regsub {\.} [ string trimleft [ $lab get ]  0 ] "" ]] == 32 \
		|| [ regexp {[^\d\.]+$]} [ $lab get ]] } {
		return
	}

	if {[ $lab get ] eq 0 } {
		clear
		Ins $value
		set calc(clear) 0
	} else {
		Ins $value
		set calc(clear) 0
	}
}

proc symbol { symbol } {
	global calc lab
	set calc(clear) 1
	if { $calc(symbol) != "" && $calc(y) == "" } {
		set calc(y) [ $lab get ]
		compute 0
	} elseif { $calc(symbol) != "" && $calc(y) != "" } {
		set calc(y) ""
	} else {
		set calc(x) [ $lab get ]
	}
	set calc(symbol) $symbol
}

proc click_C { } {
	global calc
	clear
	Ins 0
	set calc(x) ""
	set calc(y) ""
	set calc(symbol) ""
}

proc click_CE { } {
	clear
	Ins 0
}

proc compute2 { value } {
  global lab calc
	if {[ regexp {[^\d]+$} [ $lab get ]]} {
		return
	}
	set calc(clear) 1
    switch $value {
	sqrt {	
				if {[ $lab get ] >= 0 } {
		    set result [ sqrt [ $lab get ] ]
				} else {
					clear
					Ins "Invalid input";
					return 
				}
			}
	recip {	
				if {[ $lab get ] != 0 } {
					set result [ recip [ $lab get ] ]
				} else { 
					clear
					Ins "Denominator can't be zero";
					return 
				}
			}
		square { set result [ X2 [ $lab get ] ]}
		jc { set result [ fact [ $lab get ] ]}
		default { return }
	}
    clear
	set result [ formatStr $result ]
	Ins $result
}

proc compute {{ y 1 }} {
	global calc lab
	set calc(clear) 1
	if { $calc(y) == "" && $y == 1 } {
		set calc(y) [ $lab get ]
	}
    switch $calc(symbol) {
	+ { set result [ plus $calc(x) $calc(y)]}
	- { set result [ sub $calc(x) $calc(y)]}
	* { set result [ mult $calc(x) $calc(y)]}
	/ {if {$calc(y) != 0 } { 
				set result [ div $calc(x) $calc(y) ]
	    } else {
				clear
		Ins "Denominator can't be zero";
				return 
	    }}
	default { return }
	}
	if { $y == 0 } {
		set calc(symbol) ""
		set calc(y) ""
	}
	clear
	set result [ formatStr $result ]
	set calc(x) $result
	Ins $result
	return $result
}

proc Ins { val { pos end}} {
	global lab
	$lab configure -state normal
	$lab insert $pos $val
	$lab configure -state disabled
	return [ $lab get ]
}

proc clear {{ start 0 } { end end }} {
	global lab
	$lab configure -state normal
	$lab delete $start $end
	$lab configure -state disabled
}

proc popErr { str } {
	tk_messageBox -type ok -title "Error" -icon error -message "$str"	
}

proc plus { x y } {
	set x [ re $x ]
	set y [ re $y ]
	regexp {(-)?(\d+)\.?(\d+)?} $x match A(symbol) A(int) A(dec)
	regexp {(-)?(\d+)\.?(\d+)?} $y match B(symbol) B(int) B(dec)
	set A(dec) [ string trimright $A(dec) 0 ]
	set B(dec) [ string trimright $B(dec) 0 ]	
	set length(int) [ expr {[ string length $A(int) ] > [ string length $B(int) ] ? [ string length $A(int) ] : [ string length $B(int) ]}]
	set length(dec) [ expr {[ string length $A(dec) ] > [ string length $B(dec) ] ? [ string length $A(dec) ] : [ string length $B(dec) ]}]
	
	# format string
	set A(dec) [ format %0-$length(dec)s $A(dec) ]
	set B(dec) [ format %0-$length(dec)s $B(dec) ]
	set A(int) [ format %0$length(int)s $A(int) ]
	set B(int) [ format %0$length(int)s $B(int) ]
	
	# connect int and dec without dot
	append A(int) $A(dec)
	append B(int) $B(dec)

	set carry 0 
	if { $A(symbol) == $B(symbol) } {
		foreach Ax [ lreverse [ split $A(int) "" ]] Bx [ lreverse [ split $B(int) "" ]] {
			set tmp [ expr { $Ax + $Bx + $carry } ]
			lappend result [ string index $tmp end ] 
			set carry [ expr { $tmp > 9 ? 1 : 0 }]
		}
		set result [ string reverse [ join [ linsert $result $length(dec) . ] "" ]$carry ]
		set result [ regsub {^0+(\d+)} [ regsub {\.$} [ regsub {0+$} $result {} ] {} ] {\1} ]
		if { $result != 0 } {
			return $A(symbol)$result
		} else {
			return $result
		}
	} else {
		return [ sub $x $A(symbol)[ string trimleft $y - ]]
	}
}

proc sub { x y } {
	set x [ re $x ]
	set y [ re $y ]
	regexp {(-)?(\d+)\.?(\d+)?} $x match A(symbol) A(int) A(dec)
	regexp {(-)?(\d+)\.?(\d+)?} $y match B(symbol) B(int) B(dec)
	set A(dec) [ string trimright $A(dec) 0 ]
	set B(dec) [ string trimright $B(dec) 0 ]

	set length(dec) [ expr {[ string length $A(dec) ] > [ string length $B(dec) ] ? [ string length $A(dec) ] : [ string length $B(dec) ]}]
	set length(int) [ expr {[ string length $A(int) ] > [ string length $B(int) ] ? [ string length $A(int) ] : [ string length $B(int) ]}]
	
	# format string
	set A(dec) [ format %0-$length(dec)s $A(dec) ]
	set B(dec) [ format %0-$length(dec)s $B(dec) ]
	set A(int) [ format %0$length(int)s $A(int) ]
	set B(int) [ format %0$length(int)s $B(int) ]
	
	# connect int and dec without dot
	append A(int) $A(dec)
	append B(int) $B(dec)

	set carry 0
	if { $A(symbol) == $B(symbol) } {
		foreach Ax [ lreverse [ split [ max $A(int) $B(int) ] "" ]] Bx [ lreverse [ split [ min $A(int) $B(int) ] "" ]] {
			if { $Ax < $Bx+$carry } {
				incr Ax 10
				lappend result [ string index [ expr { $Ax - $Bx - $carry }] end ] 
				set carry 1
			} else {
				lappend result [ string index [ expr { $Ax - $Bx - $carry }] end ] 
				set carry 0
			}	
		}
		if { [ max $x $y ] == $x && $A(symbol) == "-" \
				|| [ max $x $y ] == $y && $A(symbol) == "" } {
				set symbol -
			} else {
				set symbol ""
			}
		set result [ string reverse [ join [ linsert $result $length(dec) . ] "" ]$carry ]
		set result [ regsub {^0+(\d+)} [ regsub {\.$} [ regsub {0+$} $result {} ] {} ] {\1} ]
		if { $result != 0 } {
			return $symbol$result
		} else {
			return $result
		}
	} else {
		return [ plus $x $A(symbol)[ string trimleft $y - ]]
	}
}

proc max { x y } {
	set x [ re $x ]
	set y [ re $y ]
	regexp {(-)?(\d+)\.?(\d+)?} $x match A(symbol) A(int) A(dec)
	regexp {(-)?(\d+)\.?(\d+)?} $y match B(symbol) B(int) B(dec)
	set A(dec) [ string trimright $A(dec) 0 ]
	set B(dec) [ string trimright $B(dec) 0 ]
	set length(dec) [ expr {[ string length $A(dec) ] > [ string length $B(dec) ] ? [ string length $A(dec) ] : [ string length $B(dec) ]}]

	# format string
	set A(dec) [ format %0-$length(dec)s $A(dec) ]
	set B(dec) [ format %0-$length(dec)s $B(dec) ]

	# connect int and dec without dot
	append A(int) $A(dec)
	append B(int) $B(dec)

	if {[ string length $A(int) ] > [ string length $B(int) ]} {
		return $x
	} elseif {[ string length $A(int) ] < [ string length $B(int) ]} {
		return $y
	} else {
		foreach Ax [ split $A(int) "" ] Bx [ split $B(int) "" ] {
			if { $Ax > $Bx } {
				return $x
			} elseif { $Ax < $Bx } {
				return $y
			}
		}
		return $x
	}
}

proc min { x y } {
	set x [ re $x ]
	set y [ re $y ]
	regexp {(-)?(\d+)\.?(\d+)?} $x match A(symbol) A(int) A(dec)
	regexp {(-)?(\d+)\.?(\d+)?} $y match B(symbol) B(int) B(dec)
	set A(dec) [ string trimright $A(dec) 0 ]
	set B(dec) [ string trimright $B(dec) 0 ]
	set length(dec) [ expr {[ string length $A(dec) ] > [ string length $B(dec) ] ? [ string length $A(dec) ] : [ string length $B(dec) ]}]

	# format string
	set A(dec) [ format %0-$length(dec)s $A(dec) ]
	set B(dec) [ format %0-$length(dec)s $B(dec) ]

	# connect int and dec without dot
	append A(int) $A(dec)
	append B(int) $B(dec)

	if {[ string length $A(int) ] > [ string length $B(int) ]} {
		return $y
	} elseif {[ string length $A(int) ] < [ string length $B(int) ]} {
		return $x
	} else {
		foreach Ax [ split $A(int) "" ] Bx [ split $B(int) "" ] {
			if { $Ax > $Bx } {
				return $y
			} elseif { $Ax < $Bx } {
				return $x
			}
		}
		return $x
	}
}

proc mult { x y } {
	set x [ re $x ]
	set y [ re $y ]
	regexp {(-)?(\d+)\.?(\d+)?} $x match A(symbol) A(int) A(dec)
	regexp {(-)?(\d+)\.?(\d+)?} $y match B(symbol) B(int) B(dec)
	set A(dec) [ string trimright $A(dec) 0 ]
	set B(dec) [ string trimright $B(dec) 0 ]
	set length(dec) [ expr {[ string length $A(dec) ] + [ string length $B(dec) ]}]

	append A(int) $A(dec)
	append B(int) $B(dec)
	
	set result 0
	for { set i 0; set carry 0 } { $i < [ string length $B(int) ]} { incr i; set carry 0; unset row } {
		set Bx [ string index $B(int) end-$i ]
		foreach Ax [ lreverse [ split $A(int) "" ]] {
			set tmp [ expr { $Bx * $Ax + $carry } ]
			lappend row [ string index $tmp end ]
			set carry [ expr { $tmp > 9 ? [ string index $tmp 0 ] : 0 }]
		}
		
		set row [ join [ lreverse [ lappend row $carry ]] "" ][ format %0$i\s "" ]
		set result [ plus $result $row ]
	}
	set result [ regsub {^\.} [ join [ linsert [ split [ format %0$length(dec)s $result ] "" ] end-$length(dec) . ] "" ] {0.} ]
	set result [ regsub {^0+(\d+)} [ regsub {\.$} [ regsub {0+$} $result {} ] {} ] {\1} ]
	if { $A(symbol) == $B(symbol) } {
		return $result
	} else { 
		return -$result
	}
}

proc div { x y } {
	set x [ re $x ]
	set y [ re $y ]
	set result [ mult $x [ recip $y ]]
	return $result
}

proc fact { x } {
	if { $x == 1 } {
		return 1
	} else {
		return [ mult $x [ fact [ sub $x 1 ]]]
	}
}

proc X2 { x } {
	return [ mult $x $x ]
}

proc recip { a } {
	set a [ re $a ]
	set expect 0.00000000000000000000000000000000001; #35
	regexp {(-)?(\d+)\.?(\d+)?} $a match A(symbol) A(int) A(dec)
	set A(dec) [ string trimright $A(dec) 0 ]
	set length(dec) [ expr {[ string length $A(dec) ]}]
	if { $A(int) == 0 && $A(dec) == "" } {
		return "Cannot divide by zero."
	} 
	set x [ format %.64f [ expr 1.0/$a ]]

	set func [ mult $x [ sub 2 [ mult $a $x ]]]
	set actual [ sub $x $func ]

	while {[ max $actual $expect ] != $expect } {
		set x [ string range $func 0 64 ]
		set func [ mult $x [ sub 2 [ mult $a $x ]]]
		set actual [ sub $x $func ]
	}
	return $func
}

proc sqrt { a } {
	set a [ re $a ]
	set expect 0.00000000000000000000000000000000001; #35
	regexp {(-)?(\d+)\.?(\d+)?} $a match A(symbol) A(int) A(dec)
	set A(dec) [ string trimright $A(dec) 0 ]
	set length(dec) [ expr {[ string length $A(dec) ]}]
	set x [ format %.64f [ expr {sqrt($a)}]]

	set func [ plus [ mult $x 0.5 ] [ mult 0.5 [ div $a $x ]]]
	set actual [ sub $x $func ]

	while {[ max $actual $expect ] != $expect } {
		set x [ string range $func 0 64 ]
		set func [ plus [ mult $x 0.5 ] [ mult 0.5 [ div $a $x ]]]
		set actual [ sub $x $func ]
	}
	return $func
}

proc negater { } {
	global lab
	if {[ regexp {[^\d\.+]} [ $lab get ]]} {
		return
	}
	set tmp [ $lab get ]
	if { $tmp ne 0 } {
		if {[ string index $tmp 0 ] == "-" } {
			clear 0 1
		} else {
			Ins - 0
		}
	}
}

proc backspace { } {
	global lab
	if {[ regexp {(-)?([\d\.]+)e[\-|\+](\d+)} [ $lab get ]] || [ regexp {[^\d\.]+$} [ $lab get ]]} {
		return
	}
	$lab config -state normal
	$lab delete [ expr {[ string length [ $lab get ]]-1} ]
	$lab config -state disabled
	if {[ $lab get ] == "-" || [ $lab get ] == "" } {
		clear
		Ins 0
	}
}

proc MS { } {
	global calc lab
	if {[ regexp {[^\d\.]+$]} [ $lab get ]]} {
		return
	}
	set calc(clear) 1
	if { $calc(MS) == 1 } {
		set calc(MSv) [ $lab get ]
	} else {
		set calc(MSv) 0
	}
}

proc MR { } {
	global calc lab
	set calc(clear) 1
	clear
	Ins $calc(MSv)
}

proc MC { } {
	global calc
	if { $calc(MS) == 1 } {
		set calc(MS) 0
		set calc(MSv) 0
	}
}

proc Mplus { } {
	global calc lab
	if {[ regexp {[^\d\.]+$} [ $lab get ]]} {
		return
	}
	set calc(clear) 1
	if { $calc(MS) != 1 } {
		set calc(MS) 1
	}
	set calc(MSv) [ formatStr [ plus $calc(MSv) [ $lab get ]]]
}

proc Msub { } {
	global calc lab
	if {[ regexp {[^\d\.]+$} [ $lab get ]]} {
		return
	}
	set calc(clear) 1
	if { $calc(MS) != 1 } {
		set calc(MS) 1
	}
	set calc(MSv) [ formatStr [ sub $calc(MSv) [ $lab get ]]]
}

proc formatStr { str } {
	regexp {(-)?([\d\.]+)} $str match symbol A
	regexp {(\d+)\.?(\d+)?} $str match int dec
	if {[ max $str 0.0001 ] eq 0.0001 && [ string length $dec ] > 32 } {
		set str [ split $A "" ]
		set pos [ expr {[ lsearch -regexp $str {[^0\.]} ] + 1 }]
		set str [ string trimleft [ join [ linsert $str $pos . ] "" ] .0 ]
		set e e-[ expr $pos - 2 ]
		set str [ string trimright [ string range $str 0 33-[ string length $e ]] 0. ]$e
	} elseif {[ string length $int ] > 32 } {
		set str [ split $A "" ]
		set str [ join [ linsert [ split $int "" ] 1 . ] "" ]
		set e e+[ expr [ string length $int ] - 1 ]
		set str [ string trimright [ string range $str 0 32-[ string length $e ]] 0. ]$e
	} elseif { $int == 0 && [ string length $A ] > 33 } {
		set str [ string range $A 0 33 ]
		if {[ string index $A 34 ] > 4 } {
			set str [ plus $str 0.[ format %032s 1 ]]
		}
	} elseif {[ string length $A ] > 33 && [ string length $int ] == 32 } {
		set str [ string range $A 0 32 ]
		if {[ string index $A 33 ] > 4 } {
			set str [ plus $str 1 ]
		}
	} elseif {[ string length $A ] > 33 } {
		set str [ string range $A 0 32 ]
		if {[ string index $A 33 ] > 4 } {
			set pos [ lsearch [ split $str "" ] . ]
			set str [ plus $str 0.[ format %0[ expr 32 - $pos ]s 1 ]]
		}
	}
	if { [ regexp {\d+\.(\d+0)?$} $str ] } {
		set str [ string trimright $str .0 ]
	}
	set tmp [ regsub {e[\+|\-]\d+$} $str {}]
	if { [ regexp {e[\+|\-]\d+$} $str e ] && [ regexp {\d\.\d+99999+$} $tmp ]} {
		set str [ regsub {e[\+|\-]\d+$} $str {}]
		regexp {(\d+)\.?(\d+)?} $str match int dec
		set carry 0.[ format %0[ string length $dec ]s 1 ]
		set str [ re [ plus $carry $str ]$e ]
	}
	return $symbol[ string trimleft $str - ]
}

proc re { str } {
	set symbol ""
	if {[ regexp {(-)?([\d\.]+)e\-(\d+)} $str match symbol A B ]} {
		set str [ join [ linsert [ split [ format %0$B\s 0 ][ regsub {\.} $A "" ] "" ] 1 . ] "" ]
	} elseif {[ regexp {([\d\.]+)e\+(\d+)} $str match A B ]} {
		set B [ expr {$B + 1} ]
		set str [ string trimright [ join [ linsert [ split  [ format %0-$B\s [ regsub {\.} $A "" ]] "" ] $B . ] "" ] . ]
	}
	return $symbol$str
}

Ins 0