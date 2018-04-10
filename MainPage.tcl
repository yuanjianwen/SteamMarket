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
#���ȶ��崰�ڳߴ�,����,͸����
wm maxsize . 2160 1600
wm minsize . 1024 768
wm title . "Game Market"
wm attributes . -alpha ".95" 
wm aspect windowName 16 9 4 3	
#�������ݿ�����
#-host "119.29.54.117" -user "GameMarket" -password "w73194001" -db "GameMarket"
set dbhost 119.29.54.117
set dbuser GameMarket
set dbpassword "w73194001"
set dbank GameMarket

#��½ҳ��
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
    namespace eval ::ttk {
	set w [toplevel .app -class AppToplevel]
	wm title $w "GameMarket: $::conn(username)@$::conn(host)"
	wm protocol $w WM_DELETE_WINDOW {destroy .}
	
	#��������������Frame
	set f [frame $w.main]
	#��װ��Frame����������    
	pack $f -expand true -fill both -padx 10m -pady 5m
	#��������� 
	label $f.markettitle -text "Welcom to GameMarket!"
	#������Ʒ�б� �������
	ttk::treeview .itemtree  -columns "Item Number Price" -displaycolumns "Item Number Price" 
	.itemtree heading Item -text "Item" -anchor center
	.itemtree heading Number -text "Number" -anchor center
	.itemtree heading Price -text "Price" -anchor center
	#��װ��Ʒ�б�
	pack .itemtree
	#��װ�����
	pack $f.markettitle 
	#������Ϸ�б�
	    
	
	    
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
	
	grid $f.markettitle -sticky nsew -pady {1m 0}   
	grid $f.${e}lbl $f.$e $f.${e}vsb  -sticky nsew -pady {1m 0}
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


































#ִ�����ݿ����Ӳ���
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



#
# ��½������Ϊ�������
#

showLoginWindow