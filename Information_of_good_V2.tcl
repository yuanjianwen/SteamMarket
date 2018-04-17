#!/bin/sh
# Information_of_good_V2.tcl \
exec tclsh "$0" ${1+"$@"}


#Information_of_good
package require Tk  
wm title . "Information of goods"
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
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_2.label_goodofname -text ">> Penta kill: Kell" -foreground white -font {Helvetica -30 bold} -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3  -height 400 -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_1  -height 500 -width 800 -background #1B2838
#image_skin
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_1.image_skin
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_2  -height 500 -width 400 -background #1B2838
#image_information
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_2.image_information
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3  -height 500 -width 400 -background #1B2838
#ä»¥ä¸‹é—®å�·åŒºåŸŸ---------------------------------------------------------------------------------------------------------------------
#image_survey
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.image_survey
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2 
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_3
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question1 -text "Q1. Sex:" -font {Helvetica -15 bold}
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question2 -text "Q2. Age:" -font {Helvetica -15 bold}
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question3 -text "Q3. How long do you play the game?" -font {Helvetica -15 bold}
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question4 -text "Q4. How much can you afford the price?" -font {Helvetica -15 bold}
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question5 -text "Q5. Would you like recommend it to ur friends?" -font {Helvetica -15 bold}
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question6 -text "Q6. Do you play any games else?" -font {Helvetica -15 bold}
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question7 -text "Q7. Leave your advices" -font {Helvetica -15 bold}
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question8
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question9
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.sex_male -text "Male" -font {Helvetica -15 bold}
#.mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.sex_male select
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.sex_female -text "Female"  -font {Helvetica -15 bold}
#.mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.sex_female deselect
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.age_10 -text "<19"  -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.age_19 -text "19-25" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.age_25 -text ">25" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.time_3 -text "<3 months" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.time_6 -text "3 - 6 months" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.time_12 -text "> 6 months" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.price_5 -text "< 5 dollar" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.price_6 -text "5 - 10 dollar" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.price_10 -text "> 10 dollar" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.yes1 -text "Yes" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.no1 -text "No" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.maybe -text "Maybe" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.yes2 -text "Yes" -font {Helvetica -15 bold}
radiobutton .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.no2 -text "No" -font {Helvetica -15 bold}
entry .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.adviceentry -text "Adviceentry" -width 60
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question1 -row 0 -column 0
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.sex_male -row 0 -column 1
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.sex_female -row 0 -column 2
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question2 -row 1 -column 0
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.age_10 -row 1 -column 1
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.age_19 -row 1 -column 2
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.age_25 -row 1 -column 3
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question3 -row 2 -columnspan 4
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.time_3 -row 3 -column 0
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.time_6 -row 3 -column 1
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.time_12 -row 3 -column 2
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question4 -row 4 -columnspan 4
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.price_5 -row 5 -column 0
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.price_6 -row 5 -column 1
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.price_10 -row 5 -column 2
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question5 -row 6 -columnspan 4
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.yes1 -row 7 -column 0
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.no1 -row 7 -column 1
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.maybe -row 7 -column 2
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question6 -row 8 -columnspan 4
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.yes2 -row 9 -column 0
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.no2 -row 9 -column 1
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question7 -row 10 -columnspan 4
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.adviceentry -row 11 -columnspan 4
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question8
grid .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2.question9
button .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_3.buttonsubmit -foreground white -font {Helvetica -30 bold} -text "Submit" -command "submit" -background #739304
#ä»¥ä¸Šé—®å�·åŒºåŸŸ---------------------------------------------------------------------------------------------------------------------

frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4  -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_01  -width 80 -background #1B2838
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_1 -background #1B2838
button .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_1.buttonbuy -foreground white -font {Helvetica -30 bold} -width 20 -text "Buy" -command "buy" -background #739304
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_2  -background #1B2838
button .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_2.buttonsell -foreground white -font {Helvetica -30 bold} -width 20 -text "Sell" -command "sell" -background #739304
frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_3  -width 300 -background #1B2838
proc buy { } {  
    set msg " \n Sorry, Sold out! \n\
	"   
    tk_messageBox -type ok -title "Buy"  -message $msg  
} 

proc sell { } {  
    set msg " \n Sorry, Nobody will buy it, LOL!\n\  
	"
    tk_messageBox -type ok -title "Sell"  -message $msg 
} 

proc submit { } {  
    set msg " \n Submit successfully, thanks a lot, enjoy your time!\n\  
	"
    tk_messageBox -type ok -title "Submit"  -message $msg 
} 

frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5  -height 150 -background #1B2838
#image_help
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_help -background #1B2838
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_support -background #1B2838
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_about -background #1B2838
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_subscribe -background #1B2838
label .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.image_wechat -background #1B2838
#frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.subFrame2_2_5_1 -relief ridge -borderwidth 2 -height 150 -width 350 -background #1B2838
#frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.subFrame2_2_5_2 -relief ridge -borderwidth 2 -height 150 -width 350 -background #1B2838
#frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.subFrame2_2_5_3 -relief ridge -borderwidth 2 -height 150 -width 350 -background #1B2838
#frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.subFrame2_2_5_4 -relief ridge -borderwidth 2 -height 150 -width 350 -background #1B2838
#frame .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.subFrame2_2_5_5 -relief ridge -borderwidth 2 -height 150 -background #1B2838
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
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_2.label_goodofname -side left -fill both
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3 -side top -fill x
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_1 -side left
#image_skin
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_1.image_skin -fill both -expand yes
image create photo skin2 -file "./images/skin2.png" -width 800 -height 500
.mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_1.image_skin  configure -image skin2
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_2 -side left
#image_information
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_2.image_information -fill both -expand yes
image create photo information -file "./images/information.png" -width 400 -height 500
.mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_2.image_information  configure -image information
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3 -side left
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1 -side top
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_2 -side top -fill both -expand yes
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_3 -side top -fill both -expand yes
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_3.buttonsubmit -side bottom -fill both -expand yes
#image_survey
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.image_survey -side top -fill both -expand yes
image create photo question -file "./images/question.png" -width 400
.mainFrame.subFrame2.subFrame2_2.subFrame2_2_3.subFrame2_2_3_3.subFrame2_2_3_3_1.image_survey  configure -image question
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4 -side top -fill both -expand yes
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_01 -side left -fill y
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_1 -side left -fill y
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_1.buttonbuy 
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_3 -side left -fill y
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_2 -side left -fill y
pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_4.subFrame2_2_4_2.buttonsell
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
#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.subFrame2_2_5_1 -side left
#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.subFrame2_2_5_2 -side left 
#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.subFrame2_2_5_3 -side left 
#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.subFrame2_2_5_4 -side left 
#pack .mainFrame.subFrame2.subFrame2_2.subFrame2_2_5.subFrame2_2_5_5 -side left -fill both
pack .mainFrame.subFrame2.subFrame2_3 -side left -fill y
