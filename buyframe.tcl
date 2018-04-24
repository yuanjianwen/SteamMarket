#!/bin/sh
# buyframe.tcl \
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

#建立数据库链接
#-host "119.29.54.117" -user "GameMarket" -password "w73194001" -db "GameMarket"
set dbhost 119.29.54.117
set dbuser GameMarket
set dbpassword "w73194001"
set dbank GameMarket

proc showBuyWindow { itemName img_path} {
    if {[winfo exists .app]} {
	wm deiconify .app
	return    
    }
	font create Font -family Helvetica -size 20 -weight bold 
	font create Font2 -family Helvetica -size 18 
	set w [toplevel .app -class AppToplevel]
	wm aspect $w 16 9 4 3   
	wm minsize $w 1500 800
	frame $w.buy_frame -borderwidth 8 -background #1b2838 -borderwidth 1m
	pack $w.buy_frame -fill both -expand yes -side left
		
	frame $w.buy_frame.up -background #242B35 -borderwidth 1m
	frame $w.buy_frame.down  -background #1D1D1D -borderwidth 1m -relief ridge
	frame $w.buy_frame.up.right -background #242B35 -borderwidth 1m
	frame $w.buy_frame.up.left  -background #242B35 -borderwidth 1m
	pack $w.buy_frame.up -fill both -expand yes 
	pack $w.buy_frame.down -fill both -expand yes 
	pack $w.buy_frame.up.right  -side right 
	pack $w.buy_frame.up.left   -side left
	image create photo imgobj{$img_path} -file $img_path -width 120 -height 120 	
	label $w.buy_frame.up.left.imgitem_{$itemName} -bg #333333 -relief ridge -borderwidth 8	 
	$w.buy_frame.up.left.imgitem_{$itemName} configure -image imgobj{$img_path} 	 
		
	label $w.buy_frame.up.left.item_{$itemName} -text $itemName -bg #242B35 -fg white -font Font 
	label $w.buy_frame.up.left.item_text{$itemName} -text {欢迎选购，东西不错，正在大降价} -bg #242B35 -fg white -font Font
	
	grid $w.buy_frame.up.left.imgitem_{$itemName}  -row 0 -column 0 -rowspan 2  -columnspan 2  -padx 3m -pady 3m
	grid $w.buy_frame.up.left.item_{$itemName}  -row 0 -column 2 -padx 3m -pady 3m
	grid $w.buy_frame.up.left.item_text{$itemName} -row 1 -column 2 -padx 3m -pady 3m
	
	label $w.buy_frame.up.right.item_1{$itemName} -text {您愿意出价多少} -bg #1b2838 -fg white -font Font 	
	entry  $w.buy_frame.up.right.text1{$itemName} 
	label $w.buy_frame.up.right.item_2{$itemName} -text {您愿意买多少} -bg #1b2838 -fg white -font Font	
	entry  $w.buy_frame.up.right.text2{$itemName} 
	

	grid $w.buy_frame.up.right.item_1{$itemName} -row 0 -column 0 -padx 3m -pady 3m 
	grid $w.buy_frame.up.right.text1{$itemName} -row 0 -column 1 -padx 3m -pady 3m 
	grid $w.buy_frame.up.right.item_2{$itemName} -row 1 -column 0 -padx 3m -pady 3m 
	grid $w.buy_frame.up.right.text2{$itemName} -row 1 -column 1 -padx 3m -pady 3m
	
	#现在开始下半段
	label $w.buy_frame.down.text1 -text {支付方式：} -bg #1D1D1D -fg white -font Font2	
	label $w.buy_frame.down.text2 -text {我的钱包} -bg #1D1D1D -fg green -font Font2	
	label $w.buy_frame.down.text3 -text {购买这件物品后：} -bg #1D1D1D -fg white	 -font Font2	
	label $w.buy_frame.down.text4 -text {一周内不得出售这件物品} -bg #1D1D1D -fg white -font Font2	
	label $w.buy_frame.down.text5 -text {一经装备概不退款} -bg #1D1D1D -fg white -font Font2	
	button $w.buy_frame.down.button -text {点击购买} -width 200 -height 3 -background #739304
	
	grid $w.buy_frame.down.text1 -row 0 -column 0  -padx 10m -pady 10m 
	grid $w.buy_frame.down.text2 -row 0 -column 1 
	grid $w.buy_frame.down.text3 -row 1 -column 0 
	grid $w.buy_frame.down.text4 -row 1 -column 1 
	grid $w.buy_frame.down.text5 -row 2 -column 1  
	grid $w.buy_frame.down.button -row 3 -column 0 -columnspan 2  -padx 10m -pady 10m 

}


showBuyWindow {MILITIA CRATE} "./item_img/gun1.png"