#!/bin/sh
# test.tcl \
exec tclsh "$0" ${1+"$@"}

foreach {package version} {
    Tk 8.4
    mysqltcl 3.0
    tile 0.7
} {
    if {[catch {package require $package $version} err]} {
	error "couldn't load $package >= $version: $err"
    }
}
proc showLoginWindow {} {
    if {[winfo exists .login]} {
	wm deiconify .login
return
    }
    namespace eval ::ttk {
	array set ::conn {
	    username {GameMarket}
	    password {w73194001}
	    host 119.29.54.117
	    port 3306
	    database GameMarket
	}
	set w [toplevel .login -class LoginToplevel]
	wm title $w "mysqltcl: login"
	wm protocol $w WM_DELETE_WINDOW {destroy .}

	set f [frame $w.main]
	label $f.userlbl -text "Username:"
	entry $f.user -textvariable ::conn(username)
	label $f.passlbl -text "Password:"
	entry $f.pass -textvariable ::conn(password) -show "*"
	label $f.hostlbl -text "Host:"
	entry $f.host -textvariable ::conn(host)
	label $f.portlbl -text "Port:"
	entry $f.port -textvariable ::conn(port)
	label $f.dblbl -text "Database:"
	entry $f.db -textvariable ::conn(database)
	button $f.connect -text "Connect" -command ::connect
	foreach e {user pass host port db} {
	    grid $f.${e}lbl $f.$e -sticky ew -pady {1m 0}
	    grid $f.${e}lbl -sticky e
	}
	grid $f.connect - -sticky ew -pady {5m 0}
	pack $f -expand true -fill both -padx 10m -pady 5m

	set f [frame $w.status]
	pack [label $f.text -relief sunken -borderwidth 2] -fill x -ipady 5
	pack $f -fill x -pady {10 0}

	bind .login <Return> {.login.main.connect invoke}
	bind .login <Control-Shift-C> {console show}

	# This dynamically resizes the status bar's width.
	bind LoginToplevel <Configure> {
	    .login.status.text configure \
		-wraplength [expr {[winfo width %W] - 20}]
	}
    }
}

proc connect {} {
    global conn
    if {[catch {
	set conn(handle) [::mysql::connect \
	    -user $conn(username) -password $conn(password) \
	    -host $conn(host) -port $conn(port) -db $conn(database)]
    } err]} {
	.login.status.text configure -text "could not connect: $err" \
	    -background red
    } else {
	.login.status.text configure -text "Connected!" -background green
	wm withdraw .login
	showAppWindow
    }
}

proc showAppWindow {} {
    if {[winfo exists .app]} {
	wm deiconify .app
	return
    }
}    
#
# This starts the application, with the login dialog.
#

showLoginWindow