#!/bin/sh
# test2.tcl \
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
#µÇÂ½Ò³Ãæ
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
	wm title $w "GameMarket: login"
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
	foreach e {user pass } {
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

proc showAppWindow {} {
    if {[winfo exists .app]} {
	wm deiconify .app
	return    
    }
    namespace eval MainFrame {
	    set w [toplevel .app -class AppToplevel]
	    wm aspect $w 16 9 4 3   
	    wm minsize $w 1024 768
	    wm maxsize $w 3840 2160
	    set vbalance 100
	    frame $w.fup  -borderwidth 8
	    frame $w.fleft -borderwidth 8
	    frame $w.fright -borderwidth 8
	    pack $w.fup -side top -fill x
	    pack $w.fleft  -fill both -expand yes
	    pack $w.fright -side right -fill y
	    
	    pack $w.fleft -side left
	    pack $w.fright -side right
	    
	    label $w.fup.markettitle -text "Welcom to GameMarket!"
	    label $w.fup.balancelbl -text "Balance:"
	    label $w.fup.balance -text $vbalance
	    
	    pack $w.fup.markettitle -expand no -fill none 
	    pack $w.fup.balancelbl -expand no -fill none 
	    pack $w.fup.balance -expand no -fill none 

	    proc makeGameButton {gameName} {
		    variable  w
		    button $w.fright.{$gameName} -text $gameName -command {MainFrame::insertTree PUBG} 
		    pack $w.fright.{$gameName}
		    #return $w.fright.butGame
	    }
	    proc makeGameTree {} {
		    variable  w
		    ttk::treeview $w.fleft.tree -columns "itemName Number Price" -displaycolumns "itemName Number Price" 
		    $w.fleft.tree heading itemName -text "itemName" -anchor center
		    $w.fleft.tree heading Number -text "Number" -anchor center
		    $w.fleft.tree heading Price -text "Price" -anchor center
		    #$w.fleft.tree insert {} end -id Languages -text "Languages"
		    #$w.fleft.tree insert Languages end -text C -values [list "Dennis Ritchie" "1990"]
		    pack $w.fleft.tree -fill both -expand yes    
	    }
	    proc insertTree {gameName} {
		    variable  w
		    $w.fleft.tree insert {} end -id $gameName -text $gameName
		    $w.fleft.tree insert $gameName end -values [list "test item" "10" "10.5"]
		    
	    }
	    
	    makeGameButton PUBG 
	    #makeGameButton FIFA {MainFrame::insertTree FIFA} 
	    #makeGameButton CDO14 {MainFrame::insertTree CDO14} 
	    #makeGameButton RED3 {MainFrame::insertTree RED3} 
	    
	    makeGameTree 
	    
	    

    }	
	
}
showLoginWindow