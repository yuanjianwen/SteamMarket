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
      label .markettitle -text "Welcom to GameMarket!"
      
	    
	    
	    
	    
	    
	    
	    
    }	
	
}
showAppWindow