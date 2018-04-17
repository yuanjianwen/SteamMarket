#!/bin/sh
# Information_of_good_V2.tcl \
exec tclsh "$0" ${1+"$@"}


#Information_of_good
package require Tk  
wm title . "Sign up"
wm minsize . 1024 768
wm maxsize . 3840 2160  

menu .menubar -tearoff 0  
    . config -menu .menubar 
    foreach val { Location Account Cart Favorites About } {    
	set menu($val) [ menu .menubar.m$val -tearoff 0 ]  
	.menubar add cascade -label $val -menu $menu($val) -background #171A21 -underline 0  
    }  
	
#Location
	$menu(Location) add check -label "Automatic Acquisition" -underline 0 -compound left 
    $menu(Location) add cascade -label "China"  -menu $menu(Location).china   
	menu $menu(Location).china -tearoff 0
	#Beijing
    $menu(Location).china add cascade -label "Beijing" -menu $menu(Location).beijing
	menu $menu(Location).beijing -tearoff 0
    $menu(Location).beijing add radio -label "Dongcheng" -underline 0 
	$menu(Location).beijing add radio -label "Xicheng" -underline 0 
	$menu(Location).beijing add radio -label "Xuanwu" -underline 0 
	$menu(Location).beijing add radio -label "Chongwen" -underline 0 
	$menu(Location).beijing add radio -label "Haidian" -underline 0 
	$menu(Location).beijing add radio -label "Chaoyang" -underline 0 
	$menu(Location).beijing add radio -label "Fengtai" -underline 0 
	$menu(Location).beijing add radio -label "Shijingshan" -underline 0 
	$menu(Location).beijing add radio -label "other place" -underline 0 
	#Shanghai
	$menu(Location).china add cascade -label "Shanghai" -menu $menu(Location).shanghai
	menu $menu(Location).shanghai -tearoff 0
    $menu(Location).shanghai add radio -label "Pudong" -underline 0 
	$menu(Location).shanghai add radio -label "Jiading" -underline 0 
	#Guangdong
	$menu(Location).china add cascade -label "Guangdong" -menu $menu(Location).guangdong
	menu $menu(Location).guangdong -tearoff 0
    $menu(Location).guangdong add radio -label "Guangzhou" -underline 0 
	$menu(Location).guangdong add radio -label "Zhuhai" -underline 0 
	#Tianjin
	$menu(Location).china add cascade -label "Tianjin" -menu $menu(Location).tianjin

    $menu(Location) add command -label "Macau(China)"  -underline 0 -compound left 
    $menu(Location) add command -label "Hongkong(China)"  -underline 0 -compound left 
	$menu(Location) add command -label "Taiwan(China)"  -underline 0 -compound left 
	$menu(Location) add command -label "America"  -underline 0 -compound left 
    $menu(Location) add command -label "Canada"  -underline 0 -compound left 
	$menu(Location) add command -label "England"  -underline 0 -compound left 
	$menu(Location) add command -label "Other country or area"  -underline 0 -compound left 

#Account
    $menu(Account) add command -label "Log In" -underline 0 -compound left
    $menu(Account) add command -label "Sign up for free"  -underline 0 -compound left
	$menu(Account) add cascade -label "Password"  -menu $menu(Account).password
	menu $menu(Account).password -tearoff 0
    $menu(Account).password add radio -label "Forget password" -underline 0 
	$menu(Account).password add radio -label "Reset password" -underline 0 
    $menu(Account) add separator  
    $menu(Account) add command -label "Log Out" -command exit -underline 1 -compound left  

#My Cart
    $menu(Cart) add command -label "What I have bought" -underline 0 -compound left
    $menu(Cart) add command -label "What I am willing to buy"  -underline 0 -compound left  
	$menu(Cart) add command -label "What I am recommended"  -underline 0 -compound left 

#Favorites	
    $menu(Favorites) add command -label "Favorite goods" -underline 0  -compound left

#About	
    $menu(About) add command -label "Help" -command "Help" -underline 0 -compound left  
    $menu(About) add separator  
    $menu(About) add command -label "About our website" -command "About" -underline 0 -compound left  

proc Help { } {  
    set msg " \n Please feel free to contract with us if you have any problems to be solved.\n\   
		You can send you problems in details with the following emai, we will deal with it as soon as possible. \n\  
		Email\t: wangyuleinihao@126.com"  
    tk_messageBox -type ok -title "Help"  -message $msg  
} 

proc About { } {  
    set msg " \n The website is designed by Yuan & Wang at the midterm of software engineering\n\  
		Author\t: Jianwen Yuan & Yulei Wang\n\  
				Date\t: 17th,April,2018\n\  
		Version\t: 1.1.0v"  
    tk_messageBox -type ok -title "About"  -message $msg  
} 

frame .mainFrame -relief ridge -borderwidth 2 
frame .mainFrame.subFrame1  -background #171A21
frame .mainFrame.subFrame1.subFrame1_1  -height 100 -width 150 -background #171A21
frame .mainFrame.subFrame1.subFrame1_2  -height 80 -width 80 -background #171A21
#image_logo
label .mainFrame.subFrame1.subFrame1_2.image_logo
frame .mainFrame.subFrame1.subFrame1_3  -height 100 -width 300 -background #171A21
label .mainFrame.subFrame1.subFrame1_3.logolabel -text "The best game market in the world" -foreground white -font {Helvetica -15 bold} -background #171A21
frame .mainFrame.subFrame2 
frame .mainFrame.subFrame2.subFrame2_1  -width 150 -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2  -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_1  -height 60 -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_2  -height 60 -background #1B2838

#label
#label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_2.label_goodofname -text ">> Penta kill: Kell" -foreground white -font {Helvetica -30 bold} -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3  -height 400 -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_1  -height 500 -width 800 -background #1B2838
#image_skin
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_1.image_skin
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_2  -height 500 -width 200 -background #1B2838
#image_information
#label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_2.image_information
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3  -height 500 -width 400 -background #1B2838
#ä»¥ä¸‹é—®å�·åŒºåŸŸ---------------------------------------------------------------------------------------------------------------------
#image_survey
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1  -height 300 -width 500 -background #171A21
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.padding1 -background #171A21
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.create -text "Create a new account:                   " -foreground white -font {Helvetica -30 bold}  -background #171A21
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.padding2 -background #171A21
#label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.image_survey
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2 -background #171A21
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.account -text "Account:" -foreground white -font {Helvetica -30 bold}  -background #171A21
entry .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.accountentry -text "accountentry" -foreground white -font {Helvetica -30 bold} -width 18 -background #1B2838 
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.password -text "Password:" -foreground white -font {Helvetica -30 bold} -background #171A21
entry .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.pswdentry -text "pswdentry" -foreground white -font {Helvetica -30 bold} -width 18 -background #1B2838 -textvariable myvariable -justify left -show "*"
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.repassword -text "Input again:" -foreground white -font {Helvetica -26 bold} -background #171A21 
entry .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.repswdentry -text "pswdentry again" -foreground white -font {Helvetica -30 bold} -width 18 -background #1B2838  -show "*"
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.email -text "Email:" -foreground white -font {Helvetica -30 bold} -background #171A21
entry .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.emaientry -text "emailentry" -foreground white -font {Helvetica -30 bold} -width 18 -background #1B2838
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.code -text "Get a code:" -foreground white -font {Helvetica -26 bold} -background #171A21
entry .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.codeentry -text "codeentry" -foreground white -font {Helvetica -30 bold} -width 10 -background #1B2838
#label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.image_code 
button .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.buttonlogin -text "Sign Up" -foreground white -font {Helvetica -30 bold} -command "sign" -background #171A21
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.padding3 -background #171A21
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.padding4 -background #171A21
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.padding5 -background #171A21

proc sign { } {  
    set msg " \n Sign up successfully, enjoy your time!\n\ "  
    tk_messageBox -type ok -title "Sign Up"  -message $msg  
} 

frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4  -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_01  -width 80 -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_1 -background #1B2838
#button .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_1.buttonbuy -foreground white -font {Helvetica -30 bold} -width 20 -text "Buy" -background #739304
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_2  -background #1B2838
#button .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_2.buttonsell -foreground white -font {Helvetica -30 bold} -width 20 -text "Sell" -background #739304
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_3  -width 300 -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5  -height 150 -background #1B2838
#image_help
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_help -background #1B2838
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_support -background #1B2838
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_about -background #1B2838
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_subscribe -background #1B2838
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_wechat -background #1B2838
frame .mainFrame.subFrame2.subFrame2_3  -width 150 -background #1B2838


pack .mainFrame -side top -fill both -expand yes
pack .mainFrame.subFrame1 -side top -fill x
pack .mainFrame.subFrame1.subFrame1_1 -side left
pack .mainFrame.subFrame1.subFrame1_2 -side left 
#image_logo
pack .mainFrame.subFrame1.subFrame1_2.image_logo -fill both -expand yes
image create photo logo -file "./images/logo.png" -width 80 -height 80
.mainFrame.subFrame1.subFrame1_2.image_logo  configure -image logo
pack .mainFrame.subFrame1.subFrame1_3 -side left
pack .mainFrame.subFrame1.subFrame1_3.logolabel
pack .mainFrame.subFrame2 -side top -fill both -expand yes
pack .mainFrame.subFrame2.subFrame2_1 -side left -fill y
pack .mainFrame.subFrame2.subFrame2_2 -side left -fill both -expand yes
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_1 -side top -fill x 
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_2 -side top -fill x 
#label
#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_2.label_goodofname -side left -fill both
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3 -side top -fill x
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_1 -side left
#image_skin
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_1.image_skin -fill both -expand yes
image create photo skin2 -file "./images/back ground3.png" -width 800 -height 500
.mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_1.image_skin  configure -image skin2
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_2 -side left
#image_information
#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_2.image_information -fill both -expand yes
#image create photo information -file "./images/information.png" -width 400 -height 500
#.mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_2.image_information  configure -image information
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3 -side left
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1 -side top
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.padding1 -row 0 -column 0 
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.create -row 1 -column 0 
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.padding2 -row 2 -column 0 
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2 -side top -fill both -expand yes
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.padding3 -row 0 -column 0 
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.account -row 1 -column 0 
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.accountentry -row 1 -column 1
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.password -row 2 -column 0 
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.pswdentry -row 2 -column 1
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.repassword -row 3 -column 0 
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.repswdentry -row 3 -column 1
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.email -row 4 -column 0 
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.emaientry -row 4 -column 1
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.code -row 5 -column 0 
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.codeentry -row 5 -column 1
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.padding4 -row 6 -column 0 
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.buttonlogin -row 7 -column 1 
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.padding5 -row 8 -column 0 


#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_3 -side top -fill both -expand yes
#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_3.buttonsubmit -side bottom -fill both -expand yes
#image_survey
#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.image_survey -side top -fill both -expand yes
#image create photo question -file "./images/question.png" -width 400
#.mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.image_survey  configure -image question
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4 -side top -fill both -expand yes
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_01 -side left -fill y
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_1 -side left -fill y
#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_1.buttonbuy 
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_3 -side left -fill y
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_2 -side left -fill y
#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_2.buttonsell
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5 -side top -fill x
#image_help
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_help -fill both -expand yes -side left 
image create photo help -file "./images/help.png" -width 120 -height 120
.mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_help  configure -image help
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_support -fill both -expand yes -side left 
image create photo support -file "./images/support.png" -width 120 -height 120
.mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_support  configure -image support
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_about -fill both -expand yes -side left 
image create photo about -file "./images/about.png" -width 120 -height 120
.mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_about  configure -image about
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_subscribe -fill both -expand yes -side left 
image create photo subscribe -file "./images/subscribe.png" -width 120 -height 120
.mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_subscribe  configure -image subscribe
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_wechat -fill both -expand yes -side left 
image create photo wechat -file "./images/wechat.png" -width 120 -height 120
.mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_wechat  configure -image wechat
pack .mainFrame.subFrame2.subFrame2_3 -side left -fill y
