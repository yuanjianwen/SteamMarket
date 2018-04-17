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
		set w [toplevel .app -class AppToplevel]
		wm aspect $w 16 9 4 3   
		wm minsize $w 1600 900
		wm maxsize $w 3840 2160
		font create HeaderFont -family Helvetica -size 28 -weight bold 
		#�����г������frame
		frame $w.frame_Market_Header  -borderwidth 8 -background #608339 -borderwidth 2m
		#������������frame
		frame $w.frame_Main_Content -borderwidth 8 -background #1b2838 -borderwidth 2m
		#�����Ҳ���Ϸ�б�frame
		frame $w.frame_Main_Content.frame_side_bar -borderwidth 8 -background #101822 -borderwidth 2m
		#�����������б�frame
		frame $w.frame_Main_Content.frame_popular_list -borderwidth 8 -background #16202d -borderwidth 2m
		
		#��װȫ��frame���
		pack $w.frame_Market_Header -fill both -side top
		pack $w.frame_Main_Content -fill both -expand yes 
		#��
		pack $w.frame_Main_Content.frame_popular_list -expand yes -fill both -side left
		#��
		pack $w.frame_Main_Content.frame_side_bar -fill y  -side right 
		
		
		#��������������
		label $w.frame_Market_Header.lable_market_head -text "�����г�   "  -font HeaderFont -background #608339 -fg white
		label $w.frame_Market_Header.lable_market_content -text ����������������ǽ�����Ϸ���� -background #608339 -fg #9dc467
		#��װ����������
		pack $w.frame_Market_Header.lable_market_head -side left
		pack $w.frame_Market_Header.lable_market_content -side left
		
		#�����Ҳ�������Ϸlistbox�ͱ���
		label $w.frame_Main_Content.frame_side_bar.label_popular_list -text "������Ϸ�б�" -bg #324965 -fg #929ea7
		frame  $w.frame_Main_Content.frame_side_bar.frame_Game_list -bg #101922
		
		#��װ�Ҳ�������Ϸlistbox�ͱ���
		pack $w.frame_Main_Content.frame_side_bar.label_popular_list -fill x 
		pack $w.frame_Main_Content.frame_side_bar.frame_Game_list -fill both -expand yes 
		
		#�������������Ʒframe�ͱ���
		label $w.frame_Main_Content.frame_popular_list.lable_items -text ������Ʒ -bg #608339 -fg #9dc467
		frame $w.frame_Main_Content.frame_popular_list.frame_items -bg #1b2838
		
		#��װ���������Ʒframe
		pack $w.frame_Main_Content.frame_popular_list.lable_items -fill x
		pack $w.frame_Main_Content.frame_popular_list.frame_items -fill both -expand yes 
		
		
		proc add_popular_item {itemName img_path} {
			
			variable  w
			frame $w.frame_Main_Content.frame_popular_list.frame_items.frame_item{$itemName} -borderwidth 2m -bg #161f2d 
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
			frame $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName} -borderwidth 2m -bg #2e3237
			pack $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName} -fill x -padx 10 -pady 10
			
			image create photo imgobj{$img_path} -file $img_path -width 120 -height 120
			
			label $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName}.imgitem_{$gameName}
			$w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName}.imgitem_{$gameName} configure -image imgobj{$img_path} -bg #2e3237
			
			label $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName}.item_{$gameName} -text $gameName -bg #2e3237 -fg white
			pack $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName}.imgitem_{$gameName} -side left 
			pack $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game{$gameName}.item_{$gameName}  -side left 
			
					
		}
		add_popular_item Key "./item_img/key.png"
		add_popular_item Key2 "./item_img/key.png"
		add_popular_item Key3 "./item_img/key.png"
		add_popular_item Key5 "./item_img/key.png"
		add_popular_item Key6 "./item_img/key.png"
		add_popular_item Key7 "./item_img/key.png"
		add_popular_item Key8 "./item_img/key.png"
		add_game csgo "./game_img/csgo.png"
		add_game pubg "./game_img/csgo.png"
		add_game red3 "./game_img/csgo.png"

		
	}

}
showAppWindow
