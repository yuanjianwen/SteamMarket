#!/bin/sh
# MainPage.tcl \

package require Tk  


#首先定义窗口尺寸,比例,透明度
wm maxsize . 2160 1600
wm minsize . 1024 768
wm title . "Game Market"
wm attributes . -alpha ".95" 
#建立数据库链接
#-host "119.29.54.117" -user "GameMarket" -password "w73194001" -db "GameMarket"
set dbhost 119.29.54.117
set dbuser GameMarket
set dbpassword "w73194001"
set dbank GameMarket

puts stdout [package ifneeded tcom 3.9]