#!/bin/sh
# MainPage.tcl \

foreach {package version} {
    Tk 8.4
    mysqltcl 3.0
    tile 0.7
} {
    if {[catch {package require $package $version} err]} {
	error "couldn't load $package >= $version: $err"
    }
}
#首先定义窗口尺寸,比例,透明度
wm maxsize . 2160 1600
wm minsize . 1024 768
wm title . "Game Market"
wm attributes . -alpha ".95" 
#建立数据库链接
#-host "119.29.54.117" -user "GameMarket" -password "w73194001" -db "GameMarket"
set dbhost 119.29.54.117
set dbuser GameMarket
set dbpassword "w73194001"
set dbank GameMarket

proc showLoginWindow {} {
    if {[winfo exists .login]} {
	wm deiconify .login
	return
    }
    namespace eval ::ttk {
	array set ::conn {
	    username {}
	    password {}
	    host localhost
	    port 3306
	    database mysql
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
    namespace eval ::ttk {
	set w [toplevel .app -class AppToplevel]
	wm title $w "mysqltcl: $::conn(username)@$::conn(host):$::conn(port)"
	wm protocol $w WM_DELETE_WINDOW {destroy .}

	set f [frame $w.main]
	pack $f -expand true -fill both -padx 10m -pady 5m
	label $f.sqllbl -text "SQL:"
	text $f.sql -width 40 -height 4 -font {Courier 10} \
	    -yscrollcommand "$f.sqlvsb set"
	scrollbar $f.sqlvsb -orient vertical -command "$f.sql yview"
	button $f.go -text "Go" -command ::go
	label $f.resultlbl -text "Result:"
	text $f.result -width 40 -height 10 -font {Courier 10} \
	    -yscrollcommand "$f.resultvsb set" \
	    -state disabled -background "#e5e5e5"
	scrollbar $f.resultvsb -orient vertical -command "$f.result yview"
	set e sql
	grid $f.${e}lbl $f.$e $f.${e}vsb -sticky nsew -pady {1m 0}
	grid $f.${e}lbl -sticky ne
	grid x $f.go -sticky ew -pady 10
	set e result
	grid $f.${e}lbl $f.$e $f.${e}vsb -sticky nsew -pady {1m 0}
	grid $f.${e}lbl -sticky ne

	grid columnconfigure $f 1 -weight 1
	grid rowconfigure $f 2 -weight 1

	bind .app.main.sql <Control-Return> {
	    .app.main.go invoke
	    .app.main.sql delete "end - 1 chars"
	}
	bind .app <Control-Shift-C> {console show}
    }
}

proc go {} {
    set f .app.main
    $f.result configure -state normal
    $f.result delete 0.0 end
    $f.result insert end "Executing query ..."
    $f.result configure -state disabled
    update ;# to refresh UI
    $f.result configure -state normal
    $f.result delete 0.0 end
    $f.result configure -state disabled
    set db $::conn(handle)
    set sql [$f.sql get 0.0 end]
    if {[catch {set query [::mysql::query $db $sql]} err]} {
	$f.result configure -state normal
	$f.result insert end $err
	$f.result configure -state disabled
	return
    }
    while {[llength [set row [::mysql::fetch $query]]]} {
	$f.result configure -state normal
	$f.result insert end $row
	$f.result insert end "\n"
	$f.result configure -state disabled
	update ;# to refresh UI
    }
    ::mysql::endquery $query
}

#
# This starts the application, with the login dialog.
#

showLoginWindow