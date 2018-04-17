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

#�������ݿ�����
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
		#�����г������frame
		frame $w.frame_Market_Header  -borderwidth 8 -background #608339 -borderwidth 1m -relief ridge 
		#������������frame
		frame $w.frame_Main_Content -borderwidth 8 -background #1b2838 -borderwidth 1m
		frame $w.frame_Main_Content_left -borderwidth 8 -background #1b2838 -borderwidth 1m  -width 200 -relief ridge
		frame $w.frame_Main_Content_right -borderwidth 8 -background #1b2838 -borderwidth 1m -width 200 -relief ridge
		label $w.frame_Main_Content_left.blank -width 18 -background #1b2838 
		label $w.frame_Main_Content_right.blank -width 18 -background #1b2838
		#�����Ҳ���Ϸ�б�frame
		frame $w.frame_Main_Content.frame_side_bar -borderwidth 8 -background #101822  -relief ridge 
		#�����������б�frame
		frame $w.frame_Main_Content.frame_popular_list -borderwidth 8 -background #16202d  -relief ridge
		
		#��װȫ��frame���
		pack $w.frame_Market_Header -fill both -side top
		pack $w.frame_Main_Content_left -side left -fill y
		pack $w.frame_Main_Content -fill both -expand yes -side left
		pack $w.frame_Main_Content_right -side right -fill y
		pack $w.frame_Main_Content_left.blank -expand yes -fill both -expand yes
		pack $w.frame_Main_Content_right.blank -expand yes -fill both -expand yes
		
		
		
		
		#��
		pack $w.frame_Main_Content.frame_popular_list -expand yes -fill both -side left
		#��
		pack $w.frame_Main_Content.frame_side_bar -fill y  -side right 
		
		
		#��������������
		label $w.frame_Market_Header.lable_market_head -text "�����г�   "  -font HeaderFont -background #608339 -fg white -height 2
		label $w.frame_Market_Header.lable_market_content -text ����������������ǽ�����Ϸ���� -background #608339 -fg #9dc467
		#��װ����������
		pack $w.frame_Market_Header.lable_market_head -side left
		pack $w.frame_Market_Header.lable_market_content -side left
		
		
		#�����Ҳ�������Ϸlistbox�ͱ���
		label $w.frame_Main_Content.frame_side_bar.label_popular_list -text "������Ϸ�б�" -bg #324965 -fg #929ea7
		frame  $w.frame_Main_Content.frame_side_bar.frame_Game_list -bg #101922
		ttk::scrollbar $w.frame_Main_Content.frame_side_bar.frame_Game_list.vsb -orient vertical   
		#��װ�Ҳ�������Ϸlistbox�ͱ���
		pack $w.frame_Main_Content.frame_side_bar.label_popular_list -fill x 
		pack $w.frame_Main_Content.frame_side_bar.frame_Game_list -fill both -expand yes 
		pack $w.frame_Main_Content.frame_side_bar.frame_Game_list.vsb -fill y -side right
		#�������������Ʒframe�ͱ���
		label $w.frame_Main_Content.frame_popular_list.lable_items -text ������Ʒ -bg #608339 -fg #9dc467
		frame $w.frame_Main_Content.frame_popular_list.frame_items -bg #1b2838 
		ttk::scrollbar $w.frame_Main_Content.frame_popular_list.frame_items.vsb -orient vertical   
		#��װ���������Ʒframe
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
		add_game {PLAYERUNKNOWN��S BATTLEGROUNDS} "./game_img/PUBG.png"
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
	label $w.buy_frame.up.left.item_text{$itemName} -text {��ӭѡ���������������ڴ󽵼�} -bg #242B35 -fg white
	
	grid $w.buy_frame.up.left.imgitem_{$itemName}  -row 0 -column 0 -rowspan 2  -columnspan 2  -padx 3m -pady 3m
	grid $w.buy_frame.up.left.item_{$itemName}  -row 0 -column 2 -padx 3m -pady 3m
	grid $w.buy_frame.up.left.item_text{$itemName} -row 1 -column 2 -padx 3m -pady 3m
	
	label $w.buy_frame.up.right.item_1{$itemName} -text {��Ը����۶���} -bg #1b2838 -fg white	
	entry  $w.buy_frame.up.right.text1{$itemName} 
	label $w.buy_frame.up.right.item_2{$itemName} -text {��Ը�������} -bg #1b2838 -fg white	
	entry  $w.buy_frame.up.right.text2{$itemName} 
	

	grid $w.buy_frame.up.right.item_1{$itemName} -row 0 -column 0 -padx 3m -pady 3m 
	grid $w.buy_frame.up.right.text1{$itemName} -row 0 -column 1 -padx 3m -pady 3m 
	grid $w.buy_frame.up.right.item_2{$itemName} -row 1 -column 0 -padx 3m -pady 3m 
	grid $w.buy_frame.up.right.text2{$itemName} -row 1 -column 1 -padx 3m -pady 3m
	
	#���ڿ�ʼ�°��
	label $w.buy_frame.down.text1 -text {֧����ʽ��} -bg #1D1D1D -fg white	
	label $w.buy_frame.down.text2 -text {�ҵ�Ǯ��} -bg #1D1D1D -fg green
	label $w.buy_frame.down.text3 -text {���������Ʒ��} -bg #1D1D1D -fg white	
	label $w.buy_frame.down.text4 -text {һ���ڲ��ó��������Ʒ} -bg #1D1D1D -fg white
	label $w.buy_frame.down.text5 -text {һ��װ���Ų��˿�} -bg #1D1D1D -fg white
	button $w.buy_frame.down.button -text {�������} -width 100 -height  3
	
	grid $w.buy_frame.down.text1 -row 0 -column 0  -padx 10m -pady 10m 
	grid $w.buy_frame.down.text2 -row 0 -column 1 
	grid $w.buy_frame.down.text3 -row 1 -column 0 
	grid $w.buy_frame.down.text4 -row 1 -column 1 
	grid $w.buy_frame.down.text5 -row 2 -column 1  
	grid $w.buy_frame.down.button -row 3 -column 0 -columnspan 2 -sticky WE     -padx 10m -pady 10m 
	

}


showBuyWindow {MILITIA CRATE} "./item_img/gun1.png"