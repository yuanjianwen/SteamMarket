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
		font create HeaderFont -family Helvetica -size 18 -weight bold 
		#�����г������frame
		frame $w.frame_Market_Header  -borderwidth 8 -background black -borderwidth 2m
		#������������frame
		frame $w.frame_Main_Content -borderwidth 8 -background SlateBlue -borderwidth 2m
		#�����Ҳ���Ϸ�б�frame
		frame $w.frame_Main_Content.frame_side_bar -borderwidth 8 -background DarkSlateBlue -borderwidth 2m
		#�����������б�frame
		frame $w.frame_Main_Content.frame_popular_list -borderwidth 8 -background DarkCyan -borderwidth 2m
		
		#��װȫ��frame���
		pack $w.frame_Market_Header -fill both -side top
		pack $w.frame_Main_Content -fill both -expand yes 
		#��
		pack $w.frame_Main_Content.frame_popular_list -expand yes -fill both -side left
		#��
		pack $w.frame_Main_Content.frame_side_bar -fill y  -side right 
		
		
		#��������������
		label $w.frame_Market_Header.lable_market_head -text "�����г�   "  -font HeaderFont
		label $w.frame_Market_Header.lable_market_content -text ����������������ǽ�����Ϸ����
		#��װ����������
		pack $w.frame_Market_Header.lable_market_head -side left
		pack $w.frame_Market_Header.lable_market_content -side left
		
		#�����Ҳ�������Ϸlistbox�ͱ���
		label $w.frame_Main_Content.frame_side_bar.label_popular_list -text "������Ϸ�б�"
		frame  $w.frame_Main_Content.frame_side_bar.frame_Game_list 
		
		#��װ�Ҳ�������Ϸlistbox�ͱ���
		pack $w.frame_Main_Content.frame_side_bar.label_popular_list
		pack $w.frame_Main_Content.frame_side_bar.frame_Game_list -fill both -expand yes
		
		#�������������Ʒframe�ͱ���
		label $w.frame_Main_Content.frame_popular_list.lable_items -text ������Ʒ
		frame $w.frame_Main_Content.frame_popular_list.frame_items 
		
		#��װ���������Ʒframe
		pack $w.frame_Main_Content.frame_popular_list.lable_items
		pack $w.frame_Main_Content.frame_popular_list.frame_items -fill both -expand yes 
		
		
		proc add_popular_item {itemName img_path} {
			
			variable  w
			frame $w.frame_Main_Content.frame_popular_list.frame_items.frame_item -borderwidth 2m -bg red
			pack $w.frame_Main_Content.frame_popular_list.frame_items.frame_item -fill x 
			image create photo imgobj{$img_path} -file $img_path -width 120 -height 120
			
			label $w.frame_Main_Content.frame_popular_list.frame_items.frame_item.imgitem_{$itemName}
			$w.frame_Main_Content.frame_popular_list.frame_items.frame_item.imgitem_{$itemName} configure -image imgobj{$img_path} -bg red
			
			label $w.frame_Main_Content.frame_popular_list.frame_items.frame_item.item_{$itemName} -text $itemName
			pack $w.frame_Main_Content.frame_popular_list.frame_items.frame_item.imgitem_{$itemName} -side left 
			pack $w.frame_Main_Content.frame_popular_list.frame_items.frame_item.item_{$itemName} -side left
			
		}
		proc add_game {gameName img_path} {
			
			variable  w
			frame $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game -borderwidth 2m -bg red
			pack $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game -fill x 
			
			image create photo imgobj{$img_path} -file $img_path -width 40 -height 40
			
			label $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game.imgitem_{$gameName}
			$w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game.imgitem_{$gameName} configure -image imgobj{$img_path} -bg red
			
			label $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game.item_{$gameName} -text $gameName
			pack $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game.imgitem_{$gameName} -side left 
			pack $w.frame_Main_Content.frame_side_bar.frame_Game_list.frame_Game.item_{$gameName}  -side left 
			
					
		}
		add_popular_item Key "./item_img/key.png"
		add_game csgo "./game_img/csgo.png"

		
	}

}
showAppWindow
