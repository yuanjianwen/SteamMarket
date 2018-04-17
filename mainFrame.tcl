#!/bin/sh
# mainFrame.tcl \
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

proc showAppWindow {} {
    if {[winfo exists .app]} {
	wm deiconify .app
	return    
    }
	namespace eval MainFrame {
		variable w
		set w [toplevel .app -class AppToplevel]
		
		wm aspect $w 16 9 4 3   
		wm minsize $w 1600 900
		wm maxsize $w 3840 2160
		font create HeaderFont -family Helvetica -size 18 -weight bold 
		#创建市场大标题frame
		frame $w.frame_Market_Header  -borderwidth 8 -background #608339 -borderwidth 1m -relief ridge 
		#创建主体内容frame
		frame $w.frame_Main_Content -borderwidth 8 -background #1b2838 -borderwidth 1m
		frame $w.frame_Main_Content_left -borderwidth 8 -background #1b2838 -borderwidth 1m  -width 200 -relief ridge
		frame $w.frame_Main_Content_right -borderwidth 8 -background #1b2838 -borderwidth 1m -width 200 -relief ridge
		label $w.frame_Main_Content_left.blank -width 18 -background #1b2838 
		label $w.frame_Main_Content_right.blank -width 18 -background #1b2838
		#创建右侧游戏列表frame
		frame $w.frame_Main_Content.frame_side_bar -borderwidth 8 -background #101822  -relief ridge 
		#创建左侧道具列表frame
		frame $w.frame_Main_Content.frame_popular_list -borderwidth 8 -background #16202d  -relief ridge
		
		#安装全套frame组件
		pack $w.frame_Market_Header -fill both -side top
		pack $w.frame_Main_Content_left -side left -fill y
		pack $w.frame_Main_Content -fill both -expand yes -side left
		pack $w.frame_Main_Content_right -side right -fill y
		pack $w.frame_Main_Content_left.blank -expand yes -fill both -expand yes
		pack $w.frame_Main_Content_right.blank -expand yes -fill both -expand yes
		
		
		
		
		#左
		pack $w.frame_Main_Content.frame_popular_list -expand yes -fill both -side left
		#右
		pack $w.frame_Main_Content.frame_side_bar -fill y  -side right 
		
		
		#创建大标题和描述
		label $w.frame_Market_Header.lable_market_head -text "社区市场   "  -font HeaderFont -background #608339 -fg white -height 2
		label $w.frame_Market_Header.lable_market_content -text 可以在这里和朋友们交易游戏道具 -background #608339 -fg #9dc467
		#安装大标题和描述
		pack $w.frame_Market_Header.lable_market_head -side left
		pack $w.frame_Market_Header.lable_market_content -side left
		
		
		#创建右侧热门游戏listbox和标题
		label $w.frame_Main_Content.frame_side_bar.label_popular_list -text "热门游戏列表" -bg #324965 -fg #929ea7
		frame  $w.frame_Main_Content.frame_side_bar.frame_Game_list -bg #101922
		ttk::scrollbar $w.frame_Main_Content.frame_side_bar.frame_Game_list.vsb -orient vertical   
		#安装右侧热门游戏listbox和标题
		pack $w.frame_Main_Content.frame_side_bar.label_popular_list -fill x 
		pack $w.frame_Main_Content.frame_side_bar.frame_Game_list -fill both -expand yes 
		pack $w.frame_Main_Content.frame_side_bar.frame_Game_list.vsb -fill y -side right
		#创建左侧热门商品frame和标题
		label $w.frame_Main_Content.frame_popular_list.lable_items -text 热门物品 -bg #608339 -fg #9dc467
		frame $w.frame_Main_Content.frame_popular_list.frame_items -bg #1b2838 
		ttk::scrollbar $w.frame_Main_Content.frame_popular_list.frame_items.vsb -orient vertical   
		#安装左侧热门商品frame
		pack $w.frame_Main_Content.frame_popular_list.lable_items -fill x
		pack $w.frame_Main_Content.frame_popular_list.frame_items -fill both -expand yes 
		pack $w.frame_Main_Content.frame_popular_list.frame_items.vsb -fill y -side right
		
		
		
		proc add_popular_item {itemName img_path} {
			
			variable  w
			frame $w.frame_Main_Content.frame_popular_list.frame_items.frame_item{$itemName} -borderwidth 2m -bg #161f2d -cursor hand2 
			pack $w.frame_Main_Content.frame_popular_list.frame_items.frame_item{$itemName} -fill x -padx 10 -pady 10
			image create photo imgobj{$img_path} -file $img_path -width 120 -height 120 
			
			label $w.frame_Main_Content.frame_popular_list.frame_items.frame_item{$itemName}.imgitem_{$itemName} -bg #333333
			$w.frame_Main_Content.frame_popular_list.frame_items.frame_item{$itemName}.imgitem_{$itemName} configure -image imgobj{$img_path} 
			
			label $w.frame_Main_Content.frame_popular_list.frame_items.frame_item{$itemName}.item_{$itemName} -text $itemName -bg #161f2d -fg #9098a0
			pack $w.frame_Main_Content.frame_popular_list.frame_items.frame_item{$itemName}.imgitem_{$itemName} -side left 
			pack $w.frame_Main_Content.frame_popular_list.frame_items.frame_item{$itemName}.item_{$itemName} -side left
			
		}
		proc add_game {gameName img_path} {
			
			variable  w
			frame $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName} -borderwidth 2m -bg #2e3237 -cursor hand2 
			pack $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName} -fill x -padx 10 -pady 10
			
			image create photo imgobj{$img_path} -file $img_path -width 460 -height 215
			
			label $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName}.imgitem_{$gameName}
			$w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName}.imgitem_{$gameName} configure -image imgobj{$img_path} -bg #2e3237
			
			label $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName}.item_{$gameName} -text $gameName -bg #2e3237 -fg white
			pack $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName}.imgitem_{$gameName} -side left 
			pack $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName}.item_{$gameName}  -side left 
					
		}
		add_popular_item {RAIDER CRATE} "./item_img/key.png"
		add_popular_item {GAMESCOM INVITATIONAL CRATE} "./item_img/box1.png"
		add_popular_item {MILITIA CRATE} "./item_img/gun1.png"
		
		
		add_game  {Counter-Strike: Global Offensive} "./game_img/csgo.png"
		add_game {PLAYERUNKNOWN’S BATTLEGROUNDS} "./game_img/PUBG.png"
		add_game {Command & Conquer: Red Alert 3} "./game_img/RED3.png"
		add_game {H1Z1} "./game_img/H1Z1.png"
		
		
	}

}

proc showBuyWindow { itemName img_path} {
    if {[winfo exists .app]} {
	wm deiconify .app
	return    
    }
	
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
	label $w.buy_frame.up.left.imgitem_{$itemName} -bg #333333	
	$w.buy_frame.up.left.imgitem_{$itemName} configure -image imgobj{$img_path} 	 
		
	label $w.buy_frame.up.left.item_{$itemName} -text $itemName -bg #242B35 -fg white
	label $w.buy_frame.up.left.item_text{$itemName} -text {欢迎选购，东西不错，正在大降价} -bg #242B35 -fg white
	
	grid $w.buy_frame.up.left.imgitem_{$itemName}  -row 0 -column 0 -rowspan 2  -columnspan 2  -padx 3m -pady 3m
	grid $w.buy_frame.up.left.item_{$itemName}  -row 0 -column 2 -padx 3m -pady 3m
	grid $w.buy_frame.up.left.item_text{$itemName} -row 1 -column 2 -padx 3m -pady 3m
	
	label $w.buy_frame.up.right.item_1{$itemName} -text {您愿意出价多少} -bg #1b2838 -fg white	
	entry  $w.buy_frame.up.right.text1{$itemName} 
	label $w.buy_frame.up.right.item_2{$itemName} -text {您愿意买多少} -bg #1b2838 -fg white	
	entry  $w.buy_frame.up.right.text2{$itemName} 
	

	grid $w.buy_frame.up.right.item_1{$itemName} -row 0 -column 0 -padx 3m -pady 3m 
	grid $w.buy_frame.up.right.text1{$itemName} -row 0 -column 1 -padx 3m -pady 3m 
	grid $w.buy_frame.up.right.item_2{$itemName} -row 1 -column 0 -padx 3m -pady 3m 
	grid $w.buy_frame.up.right.text2{$itemName} -row 1 -column 1 -padx 3m -pady 3m
	
	#现在开始下半段
	label $w.buy_frame.down.text1 -text {支付方式：} -bg #1D1D1D -fg white	
	label $w.buy_frame.down.text2 -text {我的钱包} -bg #1D1D1D -fg green
	label $w.buy_frame.down.text3 -text {购买这件物品后：} -bg #1D1D1D -fg white	
	label $w.buy_frame.down.text4 -text {一周内不得出售这件物品} -bg #1D1D1D -fg white
	label $w.buy_frame.down.text5 -text {一经装备概不退款} -bg #1D1D1D -fg white
	button $w.buy_frame.down.button -text {点击购买} -width 100 -height  3
	
	grid $w.buy_frame.down.text1 -row 0 -column 0  -padx 10m -pady 10m 
	grid $w.buy_frame.down.text2 -row 0 -column 1 
	grid $w.buy_frame.down.text3 -row 1 -column 0 
	grid $w.buy_frame.down.text4 -row 1 -column 1 
	grid $w.buy_frame.down.text5 -row 2 -column 1  
	grid $w.buy_frame.down.button -row 3 -column 0 -columnspan 2 -sticky WE     -padx 10m -pady 10m 
	

}


showBuyWindow {MILITIA CRATE} "./item_img/gun1.png"