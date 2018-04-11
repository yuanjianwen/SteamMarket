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
		frame $w.frame_Market_Header  -borderwidth 8 -background black 
		#������������frame
		frame $w.frame_Main_Content -borderwidth 8 -background SlateBlue
		#�����Ҳ���Ϸ�б�frame
		frame $w.frame_Main_Content.frame_side_bar -borderwidth 8 -background DarkSlateBlue
		#�����������б�frame
		frame $w.frame_Main_Content.frame_popular_list -borderwidth 8 -background DarkCyan
		
		#��װȫ��frame���
		pack $w.frame_Market_Header -fill both -side top
		pack $w.frame_Main_Content -fill both -expand yes 
		pack $w.frame_Main_Content.frame_side_bar -fill y  -side right 
		pack $w.frame_Main_Content.frame_popular_list -fill both -expand yes -side left
		
		#��������������
		label $w.frame_Market_Header.lable_market_head -text "�����г�   "  -font HeaderFont
		label $w.frame_Market_Header.lable_market_content -text ����������������ǽ�����Ϸ����
		#��װ����������
		pack $w.frame_Market_Header.lable_market_head -side left
		pack $w.frame_Market_Header.lable_market_content -side left
		
		#������װ�Ҳ�������Ϸlistbox�ͱ���
		label $w.frame_Main_Content.frame_side_bar.label_popular_list -text ������Ϸ�б�
		frame  $w.frame_Main_Content.frame_side_bar.frame_Game_list
		pack $w.frame_Main_Content.frame_side_bar.label_popular_list
		pack $w.frame_Main_Content.frame_side_bar.frame_Game_list -fill both -expand yes
		
		#�������������Ʒframe�ͱ���
		label $w.frame_Main_Content.frame_popular_list.lable_items -text ������Ʒ
		frame $w.frame_Main_Content.frame_popular_list.frame_items 
		
		#��װ���������Ʒtree
		pack $w.frame_Main_Content.frame_popular_list.lable_items
		pack $w.frame_Main_Content.frame_popular_list.frame_items -fill both -expand yes 
		
		proc add_popular_item {} {
			
		}
		proc add_popular_game {} {
					
		}

		
	}

}
showAppWindow
