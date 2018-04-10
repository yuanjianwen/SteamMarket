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
	    frame $w.fup -background red
	    frame $w.fleft -background green
	    frame $w.fright -background blue
	    pack $w.fup -side top -fill both -pady 10m
	    pack $w.fleft -side left -fill both -expand yes
	    pack $w.fright -side right -padx 15m
	    
	    pack $w.fleft -side left
	    pack $w.fright -side right
	    
	    label $w.fup.markettitle -text "Welcom to GameMarket!"
	    label $w.fup.balancelbl -text "Balance:"
	    label $w.fup.balance -text $vbalance
	    
	    pack $w.fup.markettitle -side
	    pack $w.fup.balancelbl -side
	    pack $w.fup.balance -side
	    
	    

    }	
	
}
showAppWindow