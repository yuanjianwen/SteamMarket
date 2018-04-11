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
		set w [toplevel .app -class AppToplevel]
		wm aspect $w 16 9 4 3   
		wm minsize $w 1600 900
		wm maxsize $w 3840 2160
		font create HeaderFont -family Helvetica -size 18 -weight bold 
		#创建市场大标题frame
		frame $w.frame_Market_Header  -borderwidth 8 -background black 
		#创建主体内容frame
		frame $w.frame_Main_Content -borderwidth 8 -background SlateBlue
		#创建右侧游戏列表frame
		frame $w.frame_Main_Content.frame_side_bar -borderwidth 8 -background DarkSlateBlue
		#创建左侧道具列表frame
		frame $w.frame_Main_Content.frame_popular_list -borderwidth 8 -background DarkCyan
		
		#安装全套frame组件
		pack $w.frame_Market_Header -fill both -side top
		pack $w.frame_Main_Content -fill both -expand yes 
		pack $w.frame_Main_Content.frame_side_bar -fill y  -side right 
		pack $w.frame_Main_Content.frame_popular_list -fill both -expand yes -side left
		
		#创建大标题和描述
		label $w.frame_Market_Header.lable_market_head -text "社区市场   "  -font HeaderFont
		label $w.frame_Market_Header.lable_market_content -text 可以在这里和朋友们交易游戏道具
		#安装大标题和描述
		pack $w.frame_Market_Header.lable_market_head -side left
		pack $w.frame_Market_Header.lable_market_content -side left
		
		#创建安装右侧热门游戏listbox和标题
		label $w.frame_Main_Content.frame_side_bar.label_popular_list -text 热门游戏列表
		frame  $w.frame_Main_Content.frame_side_bar.frame_Game_list
		pack $w.frame_Main_Content.frame_side_bar.label_popular_list
		pack $w.frame_Main_Content.frame_side_bar.frame_Game_list -fill both -expand yes
		
		#创建左侧热门商品frame和标题
		label $w.frame_Main_Content.frame_popular_list.lable_items -text 热门物品
		frame $w.frame_Main_Content.frame_popular_list.frame_items 
		
		#安装左侧热门商品tree
		pack $w.frame_Main_Content.frame_popular_list.lable_items
		pack $w.frame_Main_Content.frame_popular_list.frame_items -fill both -expand yes 
		
		proc add_popular_item {} {
			
		}
		proc add_popular_game {} {
					
		}

		
	}

}
showAppWindow
