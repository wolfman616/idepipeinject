;menu,tray,icon,C:\Icon\256\pp0hand.ico
#NoEnv ; #IfTimeout,200 ;* DANGER * : Performance impact if set too low. *think about using this*.
#NoTrayIcon ;ListLines,Off
#SingleInstance,Force
; #notrayicon
; menu,tray,icon
r_pid:= DllCall("GetCurrentProcessId")
if(pip3:= winexist("-AHK-P|p3- ahk_class AutoHotkeyGUI")) { ; Singleton
	winget,pid,pid,ahk_id %pip3%
	if(pid=r_pid)
		return,
	winactivate,ahk_id %pip3%
	loop,20{
		sleep,40
		ifwinactive,ahk_id %pip3%
			exitapp,
	} exitapp,
} ;else,menu,tray,icon
SciLexer:= A_ScriptDir . (A_PtrSize==8? "\SciLexer64.dll" : "\SciLexer32.dll")
if(!LoadSciLexer(SciLexer)) {
	msgbox,0x10,%g_AppName% - Error, % "Failed to load library """ . SciLexer . """.`n`n"
	ifmsgbox,yes
	ExitApp,
} Setworkingdir,% (aHkeXe:= splitpath(A_AhkPath)).dir
#Include <IDropTarget2>
#include <TAB>
#Include <SCIaa>
#include <AERO_LIB>
#Include C:\Script\AHK\- _ _ LiB\OGdip.ahk
#include C:\Script\AHK\- _ _ LiB\GDI+_All.ahk
loop,9
	(bold!="")? bold.=( ".," . a_index) : bold:= "0"
global bold, opAlwaysOnTop:= False ;,R_DPI:= A_ScreenDPI/96
, opaeroglass:= True ;,R_DPI:= A_ScreenDPI/96
, opTaskbarItem:= True, sci, TBhWnd, modkey16held, modkey17held
, varr, gradwnd,ldr_hWnd,thWnd,OGdip ; VarSetCapacity(varr, 0, 30000000 )
, SYSGUI_TBbUTTSZ:= 64 ; toolbar butt-size
, hTab ;, ;rDPI:= A_ScreenDPI/96
, r_Wpos,hpal,tickss,a_scriptstarttime
, rPiD := DllCall("GetCurrentProcessId")
, init_w:=1050, init_H:=706
, hsci,sciinit_x:=3,sciinit_y:=38,sciinit_w:=1064,sciinit_h:=r_Wpos.h -249
DetectHiddenWindows,On
DetectHiddenText,	On
SetTitleMatchMode,	2
SetTitleMatchMode,	Slow
SetBatchLines,		-1
SetWinDelay,		-1
coordMode,	ToolTip,Screen
coordmode,	Mouse,	Screen
a_scriptstarttime:= time4mat()
loop,parse,% "VarZ,MenuZ,INITARRAYS,Main", `,
	 gosub,% A_Loopfield
menu,tray,icon
try,menu,tray,icon,% "HICON:*" ico_hbmp:= b64_2_hicon(b64i)
return,

Main:
TextBackgroundColor:= 0xffff00, opAlwaysOnTop:= False, topmost:= ""
Titlemain:= "-AHK-P|p3-", IcoDir:= "C:\Script\AHK\res\icon"
StartX:= 1, startY:= 615, StartW:= 1044, startH:= 438
bW:= 155, bH:= 33, TabStyle:=0, TC_W:= 1040
scriptraw:= "C:\Script\AHK\- _ _ LiB\class_DragDrop.ahk"
;=-------=====-==========----------=====-==========----------=====-==========----------=====-==========---

gui,Cut0r:New,-dpiscale 0x568F0000 ;+ Create G
gui,Cut0r:+owner +MinSize1106x640 +lastfound +e%TBeXtyle% +resize +hWndldr_hWnd
gui,grad:new, +hwndgradwnd -dpiscale

IconInit(), TabViewInit()
Butts_init(), comboinit(), tickboxinit()
ToolBarInit(), StatusBarInit()

winset,ExStyle,+0x18,ahk_id %ldr_hWnd%
gui,Cut0r:show,hide Center w%init_W% h%init_H%  ,% Titlemain ;-- Show it

Win_Animate(ldr_hWnd,"slide hneg activate",900) ;gui,Cut0r:show,na ;show_upd8()
winget,ui,list,ahk_pid %r_pid%
loop,% ui
	WindowhIconSet(ui%a_index%,ico_hbmp)
Aero_BlurWindow(ldr_hWnd)
(opMount2DTop? Win2DTopTrans(ldr_hWnd,(deskX:= (guipos:= wingetpos(ldr_hWnd)).x),(desky:= guipos.y)))

PaletteInit(), EditViewInit()
	gay2:=setlexerStyle()	;ControlGet,hsci,hWnd,,scintilla1,ahk_id %evhWnd%

win_move(evhWnd,700,"","","","") ;DllCall("SetWindowBand","ptr",hgui,"ptr",0,"uint",4)
winget,uib,List,ahk_pid %rPiD% ;ahk_class #32770
	loop,% uib {
		wingetclass,ldrClass,ahk_id %ldr_hWnd%
		if(ldrClass="AutoHotkeyGUI") {
			ControlGet,h3270,hWnd,,#327701,ahk_id %ldr_hWnd%
			;winset,ExStyle,+0x20,ahk_id %h3270%
			winset,Style,-0x10000000,ahk_id %h3270%
}	}

fileRead,ScriptRaw,% a_scriptfullpath
SeTxT(ScriptRaw)
PaintLexForce:= True
settimer,PaintLexForceOff,-900
; settimer,_Lex,-10
win_move(gradwnd,0,0,a_screenwidth,a_screenheight)
sleep,200
RE2:= DllCall("SetParent","uint",gradwnd,"uint",ldr_hWnd)
sleep,200

win_move(gradwnd,13,42,init_w+20,init_H)
winset,transparent,120,ahk_id %gradwnd%
winset,transparent,5,ahk_id %hipath%
winset,style,+0x4d000000 -0x80000000,aHk_id %gradwnd%
winset,style,+0x4d000000 -0x80000000,aHk_id %hipath%
winset,exstyle,+0x28,aHk_id %gradwnd%
winset,redraw,,aHk_id %gradwnd%
 WindowhIconSet(ldr_hWnd,ico_hbmp)

settimer,onMsgz,-100

settimer,_Lex,-210

gradinit(), GradUpdate(sciinit_w-22,init_h-302) ;tbrepos()
IDT_LV:= IDropTarget_Create(hsci, "_LV", 1)
IDT_LV2:= IDropTarget_Create(hTab,"_LV", 1) ; no format required - for testing.

settimer,OnMInit,-200

EnterSizeMove(), HANDLES_ALLCTL:= RedRawButts()

sendmessage,0X849,4,0,,ahk_id %hsci% ;SCI_GETTABWIDTH-0X849;
tabsz:= errorlevel
guicontrol,,% htabszupdn,% tabsz ;settimer,marginsize,-1000
return,

WindowhIconSet(hWndl, hicon)  {
    SendMessage 0x80, 0, hicon,, ahk_id %hWndl%  ; WM_SETICON, ICON_SMALL
    SendMessage 0x80, 1, hicon,, ahk_id %hWndl%  ; WM_SETICON, ICON_LARGE
    Return ErrorLevel
}


OnMInit:
gosub,dlgtogl
OnMessage(0x0003,"wm_move")
return,

#g::
winget,ui,list,ahk_pid %r_pid%
loop,% ui
	WindowIconSet(ui%a_index%,ico_hbmp)

tt(a_now)
WindowIconSet(ldr_hWnd,"C:\Icon\256\pp0hand.ico")

return,

; ~^#h::
; h:= init_H -300, w:= init_w -20l
; winset,redraw,,ahk_id %gradwnd%
; return,

#y::
RE2:= DllCall("SetParent","uint",gradwnd,"uint",ldr_hwnd)
RE2:= DllCall("SetParent","uint",gradwnd,"uint",ldr_hwnd)
return,

^w:: ;bcnt:= wingetpos(TBhWnd) ;SetWindowPos(bcnt.X,bcnt.Y,bcnt.W,bcnt.H,0,0x4014) ;SWP_NOACTIVATE|SWP_NOZORDER
win_move(htb,4,r_Wpos.h-98,w,w,"")
return,

!^w::
SetWindowPos(TBhWnd,1,1,1120,30,0,0x4014) ; SWP_NOACTIVATE|SWP_NOZORDER ;
return, ; DllCall("SetWindowBand","ptr",hgui,"ptr",0,"uint",BandIncr++) ;tt(BandIncr); return,

; ~#H::
; tt(r:= SCI.sETUSETABS(True))
; sci.SCI_SETTABWIDTH(1)
; return,

#z:: ;testing injection to gain access to the scripts threads
code =
(LTrim
	msgb0x(SYSGUI_TBbUTTSZ,"is father")
)
dllFile:= 	FileExist("C:\Program Files\Autohotkey\Lib\AutoHotkey.dll")
	? "C:\Program Files\Autohotkey\Lib\AutoHotkey.dll"
	:  (A_PtrSize=8)? "C:\Program Files\Autohotkey\Lib\AutoHotkey.dll"
	:	"C:\Program Files\Autohotkey\LiB\minhook\x32\x32\AutoHotkey.dll"
rThread:= InjectAhkDll(ppidd,dllFile,"") ;rThread.Exec(code)
return,

GradUpdate(w,h) {
	global
	pathEllipse:= new OGdip.Path()
	pathEllipse.AddEllipse(0,0,w,h)
	pathSquare:= new OGdip.Path()
	pathSquare.AddRectangle(0,0, w,h)
	bmpILinear.G.Clear(0x0)
	bmpIPath.G.TransformReset()
	bmpIPath.G.Clear(CC.Black)
	bmpIPath.G.Brush:= pathBrush:= new OGdip.Brush.PathBrush(pathSquare)
	pathBrush.SetSurroundColors(brushFourColors)
	pathBrush.SetMode("Smooth", 1, 1)
	pathBrush.SetCenterColor(CC.cyan)
	pathBrush.UseGamma:= 1
	pathBrush.SetCenterPoint(W*.5,H*.5)
	bmpILinear.G.DrawRectangle(0,0,W,H)
	bmpIPath.G.DrawPath(pathSquare)
	bmpIPath.SetToControl(hipath)
	bmpIPath.SetToControl(thWnd)
	winSet,Region,1-0 w%w% h%h% R20-20,ahk_id %hipath%
	if(g_dlgframe)
		win_move(gradwnd,sciinit_x,sciinit_y,w,h,1)
	else,win_move(gradwnd,sciinit_x+15,sciinit_y,w,h,1)
	winSet,Region,1-0 w%w% h%h% R20-20,ahk_id %gradwnd%
	return,
}

Palactivate:
if(Palactive)
	return,
else,if(initpal) {
	LPos:="", LPos:= wingetPos(ldr_hWnd) ;gui,APCBackMain:Show,% " x" (LPos.x+LPos.W+5) " y" (LPos.y+(78)),Palette
	LPos:= wingetPos(ldr_hWnd), Palactive:= True	;win_move(hpal,LPos.x+LPos.W+5,LPos.y+(78),"","","")
	win_move(hpal,LPos.x+LPos.W+5,LPos.y+(78),"","","")
	Win_Animate(hpal,"activate slide hpos", 210)
	if(!opAlwaysOnTop)
		gui,APCBackMain:-alwaysontop
	winset,transparent,247,ahk_id %hpal%
	return,
} LPos:= wingetPos(ldr_hWnd)
gui,APCBackMain:Show,% " na hide x" (LPos.x+LPos.W) " y" (LPos.y+(78)),Palette
gui,APCBackMain:+lastfound +alwaysontop
(opaeroglass?Aero_BlurWindow(hpal))
winset,ExStyle,+0x08000000,ahk_id %hpal%
winset,transparent,240,ahk_id %hpal%
gui,APCBackMain:-SysMenu -Caption
LPos:= wingetPos(ldr_hWnd), Palactive:= initpal:= True
win_move(hpal,LPos.x+LPos.W+5,LPos.y+(78),"","","")
win_move(hpal,LPos.x+LPos.W+5,LPos.y+(78),"","","")
Win_Animate(hpal,"activate slide hpos",210)
if(!opAlwaysOnTop)
	gui,APCBackMain:-alwaysontop
winset,transparent,247,ahk_id %hpal%
return,

palahide:
if(!Palactive)
	return,
gui,APCBackMain:+lastfound +alwaysontop
winset,transcolor,000000,ahk_id %hpal%
Win_Animate(hpal,"hide slide hneg",150), Palactive:= False
winset,transparent,off,ahk_id %$%
return,

PalTopp4:
if(!Palactive) {
		gui,APCBackMain:hide
		gui,APCBackMain:show,% "hide x" (r_Wpos.x+r_Wpos.W) " y" (r_Wpos.y+(78)),
} else {
	LPos:= wingetPos(ldr_hWnd)
	win_move(hpal,LPos.x+LPos.W+5,LPos.y+(78),"","","")
	settimer,PalTopp5,-1
} return,

PalTopp5:
if(Palactive) {
	if(!palmovtrig) {
		gui,APCBackMain:+lastfound
		gui,APCBackMain:+alwaysonTop
		if(!opAlwaysOnTop)
			gui,APCBackMain:-alwaysonTop
		palmovtrig:= True
	} ;else,win_move(hpal,r_Wpos.x+r_Wpos.W+12,r_Wpos.y+(78),"","","")
} else if(!Palactive) {
	gui,APCBackMain:hide
	gui,APCBackMain:show,% "hide x" (r_Wpos.x+r_Wpos.W) " y" (r_Wpos.y+(78)),
} return,

tickboxinit() {
	global cn1, cn2, hTab, hchk1, hchk2
	gui,Cut0r:Add,Radio,Checked x464 y8 vcn1 gcn1 +hWndhchk1,% "Persist"
	gui,Cut0r:Add,Checkbox,check3 x555 y8 vcn2 gcn2 +hWndhchk2,% "Dbg"
	guicontrol,,% hchk2,-1
	RE2:= DllCall("SetParent","uint",hchk1,"uint",hTab)
	RE2:= DllCall("SetParent","uint",hchk2,"uint",hTab)
}

cn1:
cn2:
if(!(%a_thislabel%:=!%a_thislabel%)) {
	Guicontrol,,% a_thislabel,1
} else,Guicontrol,,% a_thislabel,0
return,
;---=--=-==\---=--=-==\---=--=-==\---=--=-==\---=--=-==\---=--=-==\---=--=-==\---=--=-==\---=--=-==\---=--=-==\==-

pip3Exec:
gui,Cut0r:Submit,nohide ; FileReadLine, line,% (%pipen%)name, %A_Index%
script.=scriptraw
dllcall("WriteFile",ptr,pipe,"str",Script,"uint",(StrLen(Script)+1)*char_size,"uint*",0,ptr,0)
return,

Run1:	; Wait for AutoHotkey to connect to pipe_ga via GetFileAttributes().
Run2:	; This pipe is not needed, so close it now. (The pipe instance will not be fully
Run3:	; destroyed until AutoHotkey also closes its handle.)
Run4:	; Wait for AutoHotkey to connect to open the "file".
Run5:	; Standard AHK needs a UTF-8 BOM to work via pipe. If we're running on
Run6:	; Unicode AHK_L, 'Script' contains a UTF-16 string so add that BOM instead:
TT("Launching " ahk_portable:= ((%A_ThisLabel%).pkg),"tray",1)
pipe(A_ThisLabeL)
return,

EnterSizeMove(wParam="") {
	global
	ControlGetPos,,,W,,,ahk_id %TBhWnd% ;;SWP_NOACTIVATE|SWP_NOZORDER
	r_Wpos:= wingetpos(ldr_hWnd)
	if( r_Wpos.w ) {
		r_Wpos.w < 1118? r_Wpos.w:= 1018 : r_Wpos.w:= r_Wpos.w -14
		r_Wpos.h < 586? r_Wpos.h:= 586  : r_Wpos.h:= r_Wpos.h -49
		if(g_dlgframe)
			guiControl,Move,% hTab,% "x3 y" 0 " w" r_Wpos.w-4 " h" r_Wpos.h-153
		else,guiControl,Move,% hTab,% "x18 y" 0 " w" r_Wpos.w-35 " h" r_Wpos.h-163
		settimer,TBRePos,-1
		loop,5
			GuiControl,move,% (run%a_index%).hWnd,% "y" _:=(g_dlgframe? r_Wpos.h-40-SYSGUI_TBbUTTSZ:h-120-SYSGUI_TBbUTTSZ)
		loop,8
			win_move(b_%a_index%hWnd,"",r_Wpos._:=(g_dlgframe? r_Wpos.h-75-SYSGUI_TBbUTTSZ:h-155-SYSGUI_TBbUTTSZ),"","")
		win_move(hcheckdlg,"",r_Wpos._:=(g_dlgframe? r_Wpos.h-70-SYSGUI_TBbUTTSZ:h-150-SYSGUI_TBbUTTSZ),"","")
		win_move(htabszupdntxt,"",r_Wpos._:=(g_dlgframe? r_Wpos.h-40-SYSGUI_TBbUTTSZ:h-120-SYSGUI_TBbUTTSZ),"","")
		win_move(htabszupdn,"",r_Wpos._:=(g_dlgframe? r_Wpos.h-40-SYSGUI_TBbUTTSZ:h-120-SYSGUI_TBbUTTSZ),"","")
		win_move(htabszupdntxt2,"",r_Wpos._:=(g_dlgframe? r_Wpos.h-40-SYSGUI_TBbUTTSZ:h-120-SYSGUI_TBbUTTSZ),"","")
		
		offset:= 18
		loop,parse,% "110,110,100,103",`,
			offset+=a_loopfield +18, win_move(drop%a_index%,r_Wpos.w-offset,"","","")
		offset:= 0
		loop,2
			win_move(hchk%a_index%,r_Wpos.w-600-offset,"","",""), offset+= 60
	} settimer,test,-1
}

TBRePos() {
	global
	r_Wpos:=wingetpos(ldr_hWnd), win_move(hpal,r_Wpos.x+r_Wpos.W+12,r_Wpos.y+(78),"","","")
	wingetPos,,,W,H,ahk_id %ldr_hWnd% ;SWP_NOACTIVATE | SWP_NOZORDER
	SendMessage,0x421,,,,ahk_id %hTB% ;\TB_AUTOSIZE ;winset,Redraw,,ahk_id %hTab%
	(DTopDocked? win_move(htb,1,h-96,"","","") : win_move(htb,9,(g_dlgframe? h-107:h-145),"",70,""))
	ypos:= r_Wpos.h -200 ; winset,style,-0x100,ahk_id %hTB% ; winset,exstyle,+0x2000000,ahk_id %hTB%
		GuiControl,,+e0x -0x100,% hTB,
	g_dlgframe? win_move(hsci,2,43,r_Wpos.w-25,r_Wpos.h -245 ,""):(win_move(hsci,6,43,r_Wpos.w-60,r_Wpos.h -255 ,""))
	SendMessage,0x454,0,0x90,,ahk_id %hTB% ;only dblbuff;
	return,0
}	oldw:= w:=p.w-48, oldh:= h:=p.h-255	;win_move(htab,"", 0,w,	p.h-250,"") 	;guiControl,move, HIPath, w%W% h%H%	;winSet,Region,% "1-1 W" p.w " H" p.h " R20-20",ahk_id %HIPath%


TabUpdate() {
	global
	loop,4 {
		ControlGet,h3270%a_index%,hWnd,,#32770%a_index%,ahk_id %hTab%
		if(!h3270%a_index%)
			ControlGet,h3270%a_index%,hWnd,,#32770,ahk_id %hTab%
		winset,ExStyle,+0x20,% "ahk_id " h3270%a_index%
		winset,Style,-0x10000000,% "ahk_id " h3270%a_index%
	} sleep,100
	TabSelected:= TAB_GetCurSel(hTab), SBText:= ""
	.	"There are " . TAB_GetItemCount(hTab) . " tabs. "
	.	(TabSelected? "Tab " . TabSelected . " (""" . TAB_GetText(hTab,TabSelected) . """) is selected.":"No tab is selected.")
	ControlGet,h3270,hWnd,,#32770%TabSelected%,ahk_id %hTab%
	if(!h3270)
		ControlGet,h3270,hWnd,,#32770,ahk_id %hTab%
	winset,ExStyle,+0x20,ahk_id %h3270%
	winset,Style,-0x10000000,ahk_id %h3270%
	SB_Settext(SBText,1)
	winget,uib,List,ahk_pid %rPiD% ; ahk_class #32770 ;
	loop,% uib {
		wingetclass,ldrClass,ahk_id %ldr_hWnd%
		if(ldrClass="AutoHotkeyGUI") {
			ControlGet,h3270,hWnd,,#327701,ahk_id %ldr_hWnd%
			winset,ExStyle,+0x20,ahk_id %h3270%
			winset,Style,-0x10000000,ahk_id %h3270%
}	}	}

gettext() {
	global (%obj%) ;for,i,v in (%obj%);msgbox,%i"`n" v
	return,byref (%obj%).getlength(txt,txtt) ;bum:= (%obj%).txt ;msgbox,% txtt " txt " txt
}

InitArrays:
if(!SavedColours)
	gosub,initdCols
gosub,DixInit
return,

InitdCols:
defColz:="", colm1:= 0xffc010, colm2:= 0xffc010, colz:= []
loop,16 ;Dix[a_index].push({"IDNum" :,"Colour" : ,"Font":,"Size":,"Italic":,"Bold":,"Underline":, })
	defColz.=((colz[ a_index ]:= (colm1:=col_mult(colm1,".95"))) . ",")
return,

DixInit:
Dix:= [{}], Flows:="Comments,Multiline,Directives,Punctuation,Numbers,Strings,Builtins,Flow,Commands,Functions,Keywords,Keynames,Functions2,Descriptions,Plain"
loop,parse,% Flows,`,
	Dix[a_index]:= ({ "IDNum" : a_index, "Title" : a_loopfield, "Colour" : colz[ a_index ]})
return,

TB_Handla(lParam,wParam) { ;tt("dfgfdggfg" lParam " " wParam)
	if(A_GuiControlEvent&&(A_GuiControlEvent!="N"))
		msgb0x(A_GuiControlEvent)
}

Toolbar_SetButtSize(hCtrl,W,H="") {
	static TB_SETBUTTONSIZE=0x41F
	IfEqual,H,,SetEnv,H,% W
	SendMessage,TB_SETBUTTONSIZE,,(H<<16)|W,,ahk_id %hCtrl%
	SendMessage,0x421,,,,ahk_id %hCtrl%	;autosize
}

WM_COMMAND(wParam,lParam,uMsg,hWnd) {
	global ButtPressNum
	DetectHiddenWindows,On
	WinGetClass, vWinClass, % "ahk_id " lParam
	if(vWinClass="ToolbarWindow32") {
		if(uMsg=273)
			ButtHandl4(ButtPressNum:= wParam +1)
		return,
	}
}

ButtonCancel:
return,

GUIClose:
GUIEscape:
gui,Cut0r:Destroy
ExitApp,

Add: ;Remove!;
gui,Cut0r:+OwnDialogs
FileSelectFile,IconFile,1,%IcoDir%\,Icon,Icons (*.ico)
(!ErrorLevel=""? Return : ())
SplitPath,IconFile,,,,TabName
TAB_InsertItem(hTab,,TabName,IL_Add(hIL1,IconFile))
TabUpdate()
return,

ModifyName:
(!iTab:= TAB_GetCurSel(hTab)? return())
tabDelete:
gui,Cut0r: +OwnDialogs
(!iTab:= TAB_GetCurSel(hTab)? return())
TAB_DeleteItem(hTab,iTab)
, TabUpdate()
return,

tabDeleteAll:
TAB_DeleteAllItems(hTab)
, TabUpdate()
return,

Tab_Icon_Set:
(!iTab:= TAB_GetCurSel(hTab)? return())
gui,Cut0r:+OwnDialogs
FileSelectFile,IconFile,1,%IcoDir%\,Icon,Icons (*.ico)
(ErrorLevel? return())
TAB_SetIcon(hTab,iTab,IL_Add(hIL1,IconFile))
, TabUpdate()
return,

TabSelected:
gui,Cut0r: Submit,NoHide
GUIControl,,Scintilla1,% (Scriptnew?Scriptnew : ScriptRAW)
TabUpdate()
return,

;*******************;
;*                 *;
;*    Functions    *;
;*                 *;
;*******************;

Paletteinit() {
	global
;	local lexcoL_arr had to remove all of this as it somehow causes gdi to go crazy and not do gradients
;	lexcoL_arr:=[]
;	SetBatchLines,		10
;
;lexcoL_arr["col_IDENTIFIER"]	:="0xFFA044", 
;lexcoL_arr["col_COMMENTBLOCK"]	:="0x701530", 
;lexcoL_arr["col_STRINGOPTS"]	:="0x00EEEE", 
;lexcoL_arr["col_LABEL"]			:="0x0000DD", 
;lexcoL_arr["col_HOTSTRINGOPT"]	:="0x990099", 
;lexcoL_arr["col_VAR"]			:="0xFF9000", 
;lexcoL_arr["col_USERFUNCTION"]	:="0x0000DD", 
;lexcoL_arr["col_PARAM"]			:="0x0085DD", 
;lexcoL_arr["col_BUILTINVAR"]	:="0xEE00ff", 
;lexcoL_arr["col_USERDEFINED2"]	:="0x00FF00", 
; lexcoL_arr["col_COMMENTLINE"]		:="0x701530"
; lexcoL_arr["col_STRING"]			:="0xA2A2A2"
; lexcoL_arr["col_STRINGCOMMENT"]	:="0xFF0000"
; lexcoL_arr["col_HOTSTRING"]		:="0x00BBBB"
; lexcoL_arr["col_DECNUMBER"]		:="0xFF9000"
; lexcoL_arr["col_OBJECT"]			:="0x008888"
; lexcoL_arr["col_COMMAND"]			:="0x0000DD"
; lexcoL_arr["col_BUILTINFUNCTION"]	:="0xDD00DD"
; lexcoL_arr["col_USERDEFINED1"]	:="0xFF0000"
; lexcoL_arr["col_ERROR"]			:="0xFF0000"
;lexcoL_arr["col_COMMENTDOC"]		:="0x008888"
;lexcoL_arr["col_COMMENTKEYWORD"]	:="0xA50000"
;lexcoL_arr["col_STRINGBLOCK"]		:="0x66A2ff"
;lexcoL_arr["col_HOTKEY"]			:="0x00AADD"
;lexcoL_arr["col_HEXNUMBER"]		:="0x880088"	
;lexcoL_arr["col_VARREF"]			:="0x990055"
;lexcoL_arr["col_DIRECTIVE"]		:="0x4A0000"	
;lexcoL_arr["col_CONTROLFLOW"]		:="0x0000DD"
;lexcoL_arr["col_KEY"]				:="0xA2A2A2"
;lexcoL_arr["col_ESCAPESEQ"]		:="0x660000"
;		SetBatchLines,		-1
							  
	gui,APCBackMain:New,-DPIScale +Toolwindow +Owner -SysMenu +AlwaysOnTop -0x4000000  +HWNDhPal,Palette
	gui,APCBackMain: Font, s9 cblack,Continuum Light ;gui,APCBackMain:font, csilver bold
	gui,APCBackMain: -Resize -Caption +lastfound
	gui,APCBackMain:Margin,0,0
	gui,APCBackMain:Color,000000
	n:= 10,	y:=0
	For,RowNum,ColorName In ColorList {
		For,ColNum,ColorHex In Colors[ColorName] {
			gui,Add,Text,% "x" (n *ColNum-5) -n " y" (11 *RowNum) -n " w" n+2 " h" n+2 " +0x4E +HWNDhColor" A_Index, % ColorName " - #" ColorHex
			CtlColor(ColorHex, hColor%A_Index%)
		}
		((RowNum<10)? floor((n+=0.05*RowNum)) : floor((n-=0.011*(RowNum/1))))
	}
	loop,parse,% Flows,`,
	{
		gui,Add,Radio,% "+hwndb" a_index " cBlack y" (-20+20 * a_index) " x128 v" a_loopfield " gpalbutthandla",% a_loopfield
		nog:= bgrRGB(nog:= substr(dix[a_index].colour,3,6))
		gui,APCBackMain: Font,c%nog%
		Guicontrol,font,% a_loopfield
		global (%a_loopfield%), ("b" , a_index)
	}
	for,i,am in gay {
		if(a_index>40) {
		  nigger:= 480, youcunt:=700+8
		} else,if a_index between 20 and 30
		{ nigger:= 320, youcunt:=480+8
		} else,if a_index between 10 and 20
		{ nigger:= 190, youcunt:=240+8
		} else,if a_index between 0 and 10
		{ nigger:= 18, youcunt:=30
				;msgbox % agh:=strreplace(am, "sce_ahkl_", "col_")
	;	msgbox % gay2[agh]
	;	msgbox % "c" . strreplace(gay2[strreplace(am, "sce_ahkl_", "col_")],"0x")
		} gui,Add,Text,%  " x" nigger  " y" (i*24+326)-youcunt " cred",% strreplace(am, "sce_ahkl_")
}	}

Gradinit() {
	global
	OGdip.Startup()

OnExit(ObjBindMethod(OGdip, "Shutdown"))
OGdip.autoGraphics:= True
	gui,grad:+lastfound +E0x02080000 -border -caption +owndialogs +alwaysontop +resize -0xC0000
	Gui,grad:Add,Picture,x0 y0 vhipathz w%init_w% h500 HwndHIPath +0x800000
	CC:= {Base:{__Get:OGdip.GetColor}}
	brushFourColors:= [ CC.60a, CC.f09, CC.C0F, CC.50f ]
	bmpILinear:= new OGdip.Bitmap(a_screenwidth, a_screenheight)
	bmpIPath  := new OGdip.Bitmap(a_screenwidth, a_screenheight)
	bmpILinear.G.SetOptions( {smooth:1} )
	bmpIPath.G.SetOptions( {smooth:1} )
	pathEllipse:= new OGdip.Path()
	pathEllipse.AddEllipse(0,0,init_w,500)
	pathSquare:= new OGdip.Path()
	pathSquare.AddRectangle(0,0,init_w,500)
	h:=a_screenwidth,	w:=a_screenheight
	winset,transparent,18,ahk_id %gradwnd%
	gui,grad:show, w%init_w% h%init_h% center
	winSet,Region,1-0 w%init_w% h%init_h% R20-20,ahk_id %gradwnd%
	GradUpdate(init_w,init_h)
}

TabViewinit() {
	global
	gui,Cut0r:Add,Tab3,xm w%TC_W% y0 h%startH% -Wrap %TabStyle% hWndhTab gTabSelected vMyTab +e0x2080000
	winset,ExStyle,&e0x2000000,ahk_id %hTab% 	; composited
	TAB_SetImageList(hTab,hIL1)
	TAB_GetPos(hTab,MyTabPosX,MyTabPosY,MyTabPosW,MyTabPosH) ;-- Get the position of the tab control and the display area
	TAB_GetDisplayArea(hTab,DisplayAreaX,DisplayAreaY,DisplayAreaW,DisplayAreaH)
	EditY:= DisplayAreaY -6
	TAB_DeleteAllItems(hTab) 					;-- Delete the dummy tab
	by:= (360 +(bH:= 34) +(margY:= 40))
	for,i,f in tabicons_init 					;-- Add the tabs and assign an icon
		TAB_InsertItem(hTab,i,f,i) 				;-- End of tabs	;LPos:= wingetPos(ldr_hWnd)
	;gui,Cut0r: Add,Slider,% "x" . (a:=init_w-500) . " y" . (b:=init_H-250) . " vTabHeightSlider gTabHeightSlider AltSubmit NoTicks Range" . MinTabHeight . "-" . MaxTabHeight . " Vertical"
	;,% TAB_GetItemHeight(hTab)
}

TabHeightSlider:
gui Submit,NoHide
TAB_SetItemSize(hTab,,TabHeightSlider)
GUIControl,,%hTab%
GUIControl,,TabHeightDisplay,% TAB_GetItemHeight(hTab)
return

Comboinit(){
	global
	gui,Cut0r:Add,DropDownList,vCombo1 x626 y4 w110 +hWnddrop1,x64 || x86 |
	gui,Cut0r:Add,DropDownList,vCombo2 x749 y4 w110 +hWnddrop2,UNICODE ||ANSI |'UiA'
	gui,Cut0r:Add,DropDownList,vCombo3 x873 y4 w100 +hWnddrop3,UiA || Unsigned
	gui,Cut0r:Add,DropDownList,vCombo4 x988 y4 w103 +hWnddrop4,UTF-8 || UTF-16 | ANSI
	loop,4
		RE2:= DllCall("SetParent","uint",drop%a_index%,"uint",hTab)
}

StatusBarinit() {
	global ;gui,Add,StatusBar,y700 +0x100, sb 1 ;-- Status bar ;-- Misc.
	static inc:= round(1118*0.25)
	gui,Cut0r:Add,StatusBar,+hWndSbarhWnd +0x100
	return,SB_SetParts(inc,inc,inc,inc), SB_Settext(SBText,4)
}

Butts_init() {
	global
	by +=83
	gui,Cut0r:Tab
	gui,Cut0r:-dpiscale +lastfound
	gui,Cut0r:Add,Button,hWndb_1hWnd y%by% x10 h34 w100 gpip3exec vpip3exec,%A_Space%Add%A_Space%
	gui,Cut0r:Add,Button,y%by% x+8 h34 w99 gAdd vAdd +hWndb_2hWnd,%A_Space%Add%A_Space%
	gui,Cut0r:Add,Button,y%by% x+8 h34 w99 gModifyName vModifyName +hWndb_3hWnd,Modify Name
	gui,Cut0r:Add,Button,y%by% x+8 h34 w99 gtab_icon_set vtab_icon_set +hWndb_4hWnd,Modify Icon
	gui,Cut0r:Add,Button,y%by% x+8 h34 w99 gtabDelete vtabDelete +hWndb_5hWnd,	Delete
	gui,Cut0r:Add,Button,y%by% x+8 h34 w99 gtabDeleteAll vtabDeleteAll +hWndb_6hWnd, Delete All
	gui,Cut0r:Add,Button,y%by% x+8 h34 w99 gbuttoncancel vbuttoncancel +hWndb_7hWnd w70 yp,% "&Cancel"
	gui,Cut0r:Add,Button,y%by% x+8 h34 w99 gr3load vr3load +hWndb_8hWnd,	%A_Space%r3load...%A_Space%
	by +=54
	loop,5 {
		global ("b" . a_index . "hWnd")
		bx:= a_index>1?"+12":"8", by
		gui,Cut0r:Add,Button
		,	x%bx% y%by% w%bW% h%bH% gRun%a_index% +hWndb%a_index%hWnd
		,%	("Run" . a_index . ".btn")
		switch,a_index {
		   ;case   1:global (Run%a_index%:= {}, Run%a_index%
				; , := {"EXE"	 : quote(_ "U64_UIA.exe")
					; , "hWnd" :	B%a_index%hWnd
					; , "PKG"	 : "Unicode x64 UserIntAface"
					; , "btn"	 : "U64-UiA"})
			case "1":global (Run%a_index%:= {}, Run%a_index%
				, := {"EXE"	 : quote(_ ".exe")
					, "hWnd" :	B%a_index%hWnd
					, "PKG"	 : "Unicode x64 UserIntAface"
					, "btn"	 : "U64-UiA"})
			case "2": global (Run%a_index%:= {}, Run%a_index%
				, := {"EXE"  : quote(_ "U64_UIA - admin.exe")
					, "hWnd" :	B%a_index%hWnd
					, "PKG"	 : "Unicode x64 UserIntAface (Admin)"
					, "btn"	 : "Ux64-UiA(AdM)" })
			case "3": global (Run%a_index%:= {}, Run%a_index%
				, := {"EXE"	 : quote(_ "orig.exe")
					, "hWnd" :	B%a_index%hWnd
					, "PKG"  : "Unicode x64"
					, "btn"	 : "Ux64-Base"})
			case "4": global (Run%a_index%:= {}, Run%a_index%
				, := {"EXE"	 : quote(_ "U32_UIA.exe")
					, "hWnd" :	B%a_index%hWnd
					, "PKG"  : "Unicode x64 UserIntAface"
					, "btn"  : "Ux86-UiA"})
			case "5": global (Run%a_index%:= {}, Run%a_index%
				, := {"EXE"	 : quote(_ "A32_UIA - admin.exe")
					, "hWnd" :	B%a_index%hWnd
					, "PKG"  : "Unicode x64 UserIntAface"
					, "btn"  : "Ansi-x86-UiA"})
			case "6": global (Run%a_index%:= {}, Run%a_index%
				, := {"EXE"	 : quote(_ "A32.exe")
					, "hWnd" :	B%a_index%hWnd
					, "PKG"  : "Unicode x64 UserIntAface"
					, "btn"  : "Ansi-x86"})
		} GuiControl,text,% (run%a_index%).hWnd,% (run%a_index%).btn ;(run%a_index%).hWnd "`n" (run%a_index%).btn
	} bY-=18
	gui,Cut0r:Add,CheckBox,% "+hwndhcheckdlg Gdlgtogl check3 vg_dlgframe x845 y580" ,% "&dlgframe"
	gui,Cut0r:Add,text, x845 y600  hwndhtabszupdntxt 
	gui,Cut0r:Add,UpDown,% "+hwndhtabszupdn Gtabsz vtabsz x845 y600"
	gui,Cut0r:Add,text, x885 y600  hwndhtabszupdntxt2, tab_chrs
}

tabsz:
sendmessage,2036,tabsz,0,,ahk_id %hsci% ;SCI_SETTABWIDTH-2036;
return,

dlgtogl:
if(g_dlgframe:=!g_dlgframe) {
	P:=wingetpos(ldr_hwnd)
	winset,style,-0x400000,ahk_id %ldr_hWnd%
	winset,style,+0x40000,ahk_id %ldr_hWnd%
	guicontrol,,% hcheckdlg,-1
} else {
	winset,style,+0x400000,ahk_id %ldr_hWnd%
	guicontrol,,% hcheckdlg,0
}
sleep(600)
redraw()
return,

~#f::
loop,parse,HANDLES_ALLCTL,`,
	controls[ a_index ]:= A_loopfield
	, controlsmaxi:= a_index
	msgbox % controlsmaxi
if(bbounce:=!bbounce) {
;	settimer,bbb,1
	settimer,bb,1
} else {
	settimer,bb,off
	settimer,bbb,off
	sleep,100
	SendMessage,0x448,-1,0,,ahk_id %htb%
} return,

bb:
buttbounce(htb,17,250)
return,
		bbb:
		buttbounce2()

		return,
buttbounce2() {
	butts_up:
	loop,% controlsmaxi {
		SendMessage,0xF3,1,0,,% "ahk_id " controls[a_index] ;BM_SETSTATE
		sleep,45
	} 		;return,
	butts_dn:
	loop,% controlsmaxi {
		SendMessage,0xF3,0,0,,% "ahk_id " controls[controlsmaxi+1-a_index] ;BM_SETSTATE 
		sleep,45
	}		;return,
}
	
ButtBounce(tbhandle="",butts="",hilt_ms=199) {
	global
	;loop,1 {
		loop,% butts {
			(!bbounce? return())
			SendMessage,0x448,a_index-1,0,,ahk_id %tbhandle% ;TB_SETIMAGELIST:=0x430 ;TB_ADDBUTTONSA:= 0x414 TB_SETHOTITEM-0x448
			sleep,% hilt_ms
		} loop,% butts {
			(!bbounce? return())
			SendMessage,0x448,butts-a_index,0,,ahk_id %tbhandle% ;TB_SETIMAGELIST:=0x430 ;TB_ADDBUTTONSA:= 0x414
			sleep,% hilt_ms
		}
	;} 
}

ToolbarInit() {
	global ;TBStyle_TOOLTIPS-0x100|TBStyle_LIST-0x1000 ;Txt-@-side-of-buttons
	((!SYSGUI_TBbUTTSZ)? SYSGUI_TBbUTTSZ:= 64)
	gui,Cut0r:Add,Custom,w1 x1 y%by% ClassToolbarWindow32 +hWndTBhWnd +0x810
	ControlGet,hTB,hWnd,,ToolbarWindow321,ahk_id %ldr_hWnd%
	SendMessage,0x2007,0x5,0,,ahk_id %hTB% ;CCM_SETVERSION-0x2007
	winset,Style,-0x1,ahk_id %hTB% ;winset,Style,+0x800,ahk_id %hTB%
	SendMessage,0x43C,0,0,,ahk_id %hTB%	;TB_SETMAXTEXTROWS ;text omitted from buttons; ;note: if more than one button has the same idCommand, then only the last button with that idCommand will have make the call.
	SendMessage,0x2007,5,0,,ahk_id %hTB% ;CCM_SETVERSION-0x2007
	SendMessage,0x430,0,hIL2,,ahk_id %hTB% ;TB_SETIMAGELIST-0x430 ;TB_ADDBUTTONSA-0x414
	SendMessage,0x434,0,hIL3,,ahk_id %hTB% ;TB_SETHotIMAGELIST-0x434
	SendMessage,0x468,0,hIL4,,ahk_id %hTB% ;TB_SETPRESSEDIMAGELIST-0x468

	vMsg:= A_IsUnicode? 0x444 : 0x414
	SendMessage,vMsg,vCount,&TBBUTTON,,% "ahk_id " hTB ;TB_ADDBUTTONSW|TB_ADDBUTTONSA|TB_ADDBUTTONSW:= 0x444
	Toolbar_SetButtSize(hTB,SYSGUI_TBbUTTSZ,SYSGUI_TBbUTTSZ)
	SendMessage,0x454,0,0x90,,ahk_id %hTB% ; TB_SETEXTENDEDSTYLE-0x454 truncate partial-butts && dblbuffd
	SendMessage,0x421,,,,ahk_id %hTB%	;TB_AUTOSIZE-0x421; winset,exstyle,+0x2080000,ahk_id %hTB%
}

IconInit() {
	global
	icona:= "C:\Icon\256\homeinv.ico,C:\Icon\64\SnipSketch64.ico,C:\Icon\- Icons\256\Foursquare One.ico,C:\Icon\- Icons\256\X (30).ico,C:\Icon\256\Untitl44sdsdexxadaedddded.ico,C:\Icon\- Icons\256\Flick Learning Wizard.ico,C:\Icon\256\Floppy - sDisk (15).ico,C:\Icon\256\progRe55752_2.ico,C:\Icon\256\inj4.ico,C:\Icon\256\tabsearc5h.ico,C:\Icon\256\reshackerdddn4.ico,C:\Icon\256\#1444.ico,C:\Icon\256\#1952.ico,C:\Icon\- Icons\256\Windows (26).ico,C:\Icon\64\HAND64.ICO,C:\Icon\64\tism64.ico,C:\Icon\256\IconGroup104.ico"
	iconb:= "C:\Icon\256\home.ico,C:\Icon\64\SnipSketch64i.ico,C:\Icon\256\home.ico,C:\Icon\- Icons\256\Foursquare One.ico,C:\Icon\256\Untitl44sdsdexxadaedddded.ico,C:\Icon\- Icons\256\Flick Learning Wizard.ico,C:\Icon\256\Floppy - sDisk (15).ico,C:\Icon\256\progRe55752_2.ico,C:\Icon\256\inj4.ico,C:\Icon\256\tabsearc5h.ico,C:\Icon\256\reshackerdddn4.ico,C:\Icon\256\#1444.ico,C:\Icon\256\#1952.ico,C:\Icon\- Icons\256\Windows (26).ico,C:\Icon\64\HANDi64.ICO,C:\Icon\256\Clipboarder.2022.10.12-002.ico,C:\Icon\64\pisseri64.ico"
	iconc:= "C:\Icon\256\home.ico,C:\Icon\64\SnipSketch64i.ico,C:\Icon\256\home.ico,C:\Icon\- Icons\256\Foursquare One.ico,C:\Icon\256\Untitl44sdsdexxadaedddded.ico,C:\Icon\- Icons\256\Flick Learning Wizard.ico,C:\Icon\256\Floppy - sDisk (15).ico,C:\Icon\256\progRe55752_2.ico,C:\Icon\256\inj4.ico,C:\Icon\256\tabsearc4h.ico,C:\Icon\256\reshackerdddn4.ico,C:\Icon\256\#1444.ico,C:\Icon\256\#1952.ico,C:\Icon\- Icons\256\Windows (26).ico,C:\Icon\64\HANDi64.ICO,C:\Icon\256\Clipboarder.2022.10.12-002.ico,C:\Icon\64\pisseri64.ico"
	loop,3
		icona.= ",C:\Icon\256\pinhead.ico", iconb.= ",C:\Icon\256\pinhead.ico", iconc.= ",C:\Icon\256\pinhead.ico"
	loop,parse,% icona,`,
		icon_array[max_i:= A_index]:= A_loopfield
	loop,parse,% iconb,`,
		icon_array2[max_i:= A_index]:= A_loopfield
	loop,parse,% iconc,`,
		icon_array3[max_i:= A_index]:= A_loopfield
	vCount:= max_i>48?  48 : max_i
	hIL2:= IL_Create(vCount,2,64), hIL3:= IL_Create(vCount,2,64), hIL4:= IL_Create(vCount,2,64)
	vSize:= A_PtrSize=8? 32:20
	VarSetCapacity(TBBUTTON,vCount*vSize, 0)
	Loop,% vCount {
		switch a_index {
			case 1: (vTxt%A_Index%):= "Home is where the fart is..."
			default: (vTxt%A_Index%):= "       Cut-em-up!!`nI-can-dance-all-day!!!"
		} vOffset:= (A_Index -1) *vSize
		NumPut(A_Index-1,		TBBUTTON,vOffset,  "Int")
		NumPut(A_Index-1,		TBBUTTON,vOffset+4,"Int")
		NumPut(0x4,				TBBUTTON,vOffset+8,"UChar")
		NumPut(&vTxt%A_Index%,	TBBUTTON,vOffset+(A_PtrSize=8? 24:16),"Ptr") ;iString; hIL2:= IL_Create(5, 2, 64)
	} for,i,icopath in icon_array	;	iBitmap
		IL_Add(hIL2,icopath,0) 		;	idCommand
	for,i,icopath in icon_array2
		IL_Add(hIL3,icopath,0)
	for,i,icopath in icon_array3
		IL_Add(hIL4,icopath,0)

	tabicons_init:= []			;fsState	;	TBSTATE_ENABLED:= 4
	loop,4									; str=tabicons_init.push("ahk" . a_index)
		tabicons_init.push("ahk" . a_index)	; loop(6,str)
	hIL1:= TAB_CreateImageList(32) ;-- Create and populate image list
	for,i,f in tabicons_init
		IL_Add(hIL1,IcoDir . "\" . f . ".ico")
	return,
}

Show_Upd8() {
	return, TabUpdate(), TBRePos()
}

EditViewInit() {
	global
	gui,Add,Edit,vScriptRaw +0x6000000 +hWndevhWnd +E0x8 ;+E0x00200008; ;TCS_FIXEDWIDTH|TCS_TOOLTIPS;
	sci:= new scintilla(ldr_hWnd), hsci:= sci.hwnd
	sci.SetCodePage(65001) ; UTF-8 ;
	sci.SetWrapMode(True) ; Set default-font ;Style_DEFAULT:= 32
	winset,ExStyle,+0x30,ahk_id %hsci%
	RE2:= DllCall("SetParent","uint",hsci,"uint",hTab) ; edit-frame.edge-light remove
	win_move(hsci,sciinit_x:=3,sciinit_y:=38,sciinit_w:=1064,sciinit_h:=r_Wpos.h -249,"")
	winset,ExStyle,+0x20,ahk_id %hTab% ; edit-frame.edge-light remove '
}

SCI_NOTIFY(a="",b="",c="",d="") { ;if(c!=78)
	if(a!=49374) ;not yet understood.;
	msgbox,% "notify a:" a "`nb:" b  "`nc:" c  "`nd:" d
}

OnMsgz:
wm_allow()
OnExit("quit")	;loop,parse,% "0x007C,0x007D,0x31E,0x31F,0x320,0x15",`.
;OnMessage(a_loopfield,"TBRePos")	; 0x007D WM_StyleCHANGED ; attempt to handle events which require a wm_paint post, Style changing unable to find see below
;OnMessage(0x007D,"TBRePos") ; 0x007D WM_StyleCHANGED deosnt proc when change Styles?
;OnMessage(0x031E,"TBRePos") ; 0x007C WM_StyleCHANGing
OnMessage(0x004A,"Receive_WM_COPYDATA")	; WM_DWMNCRENDERINGCHANGED:= 0x31F
OnMessage(0x0404,"AHK_NOTIFYICON")		; WM_DWMCOLORIZATIONCOLORCHANGED:= 0x320
;OnMessage(0x0233,"GuiDropFiles")		; WM_DWMCOMPOSITIONCHANGED:= 0x31E
OnMessage(0x0100,"WM_KEYDN")
OnMessage(0x0101,"WM_KEYUP") ;onmessage(0x047,"moved")
OnMessage(2170,"cs") ;OnMessage(0x231, "wm_movest")
OnMessage(0x0232,"wm_moveend")
OnMessage(0x0233,"wm_dropfile")
OnMessage(0x0111,"WM_COMMAND")
OnMessage(0x0231,"EnterSizeMove")
OnMessage(0x200,"OnWM_MOUSEMOVE")
OnMessage(0x0005,"EnterSizeMove")
OnMessage(0x0006,"wm_activate")
OnMessage(0x015,"WM_DPICHANGED") ;WM_SYSCOLORCHANGE seems to be  cause of relog gfx issue banner2
;OnMessage(0x20A,"wheel") ;WM_MOUSEWHEEL 522 0x20A
return,



wm_dropfile(wParam="",lParam="",msg="",hwnd="") {
for,i,file in lParam
		msgbox % "File " i " is:`n" file
msgbox % wParam "`n" lParam  "`n" msg  "`n" hwnd
}

; wm_dropfile(GuiHwnd, FileArray, CtrlHwnd,X,Y) {
	; for,i,file in FileArray
		; MsgB0x("File " i " is:`n" file)
; }

WM_DPICHANGED() {
	global
	Toolbar_SetButtSize(hTB,SYSGUI_TBbUTTSZ,SYSGUI_TBbUTTSZ)
	winset,Style,-0x1,ahk_id %hTB%
	SendMessage,0x454,0,0x90,,ahk_id %hTB% ;truncate partial-butts && dblbuffd
	SendMessage,0x421,,,,ahk_id %hTB%
}

Receive_WM_COPYDATA(byref wParam,byref lParam) {
	StringAddress:=	NumGet(lParam+(2*A_PtrSize))
	CopyOfData	 :=	StrGet(StringAddress)
	gosub,% CopyOfData
	return,True
}

WM_KEYDN(wParam="",lParam="",msg="",hwnd="") {
	global modkeyheld
	switch,wParam {   
		case,"16","17": (modkey%wParam%held):=true
	} return,
}

WM_KEYUP(wParam,lParam,msg="",hwnd="") {
	global ;global hWnd_Par, scriptraw ;% Format("{:#x}",hwnd)
	static txtl,txtlold,textold,textnew
	switch,hwnd {
		case,hsci: txtlold:= txtl
		default: return,
	} switch,wParam {
		case,"17","16": modkey%wParam%held:= false
		case,"27"	: settimer,guiclose,-1	;Esc;
		case,"20"	: return
	;	case,"13"	: ;enter
	;		gui,par	: submit,nohide
	;		send,{tab}
	;		return
		default : 		tooltip, dda

		if(modkey16held&&modkey17held) { ;tooltip % ("negated"),,,2
				return,
			} settimer,_Lex,-19
	return,
}	}

wm_activate() {
	gui,APCBackMain:+lastfound +alwaysontop
	if(!opAlwaysOnTop)
	gui,APCBackMain:-alwaysontop
	return,
}

WM_LBUTTONDOWN(wParam,lParam,Msg,Hwnd) {
	Global
	Static Init:= OnMessage(0x0201,"WM_LBUTTONDOWN")
		MouseGetPos,,,,MouseCtl
	GuiControlGet,ColorVal,,% MouseCtl
	if(!instr(MouseCtl,"static") || (!RegExMatch(ColorVal,"#(.*)", ClipColor))
	||(!(SelCol_Butt))) ;filter *.* except the color-grid
		return,
	vfg:= strreplace(SelCol_Butt,"butt")
	, (%vfg%):= bgr:= "0x" substr(ClipColor1,5,2) . substr(ClipColor1,3,2) . substr(ClipColor1,1,2)
	loop,parse,% Flows,`,
	{
		if(a_loopfield=vfg) {
			vfg:=%vfg%, dix[a_index].colour:= vfg
			, nog:= bgrrgb(nog:= strreplace(vfg, "0x"),False)
			gui,APCBackMain: Font,c%nog%
			Guicontrol,font,% a_loopfield
			break,
	}	} tt("set colour " dix[a_index].colour " to " vfg)
	PaintLexForce:= True	;settimer,PaintLexForceoff,-900
	settimer,_Lex,-19 ;msgbox,% dix[a_index].colour " sdfsf " dix[a_index].title
	return,
}

WM_lrBUTTONDOWN(wParam,lParam,mDC) {
	global lbutton_cooldown, lbd, STrigga:= True
	static init, RECT
	(!init? VarSetCapacity(RECT,16,0))
	xs:= lParam &0xffff, ys:= lParam>>16
	((ys<42)? wm_move())
	While(LbD:= GetKeyState("lbutton","P")||lbd:= GetKeyState("lbutton","P")) {
		DllCall("GetCursorPos","Uint",&RECT)
		win_move(hgui,(NumGet(&RECT,0,"Int")-xs),(NumGet(&RECT,4,"Int") -ys),CURRENT_W,CURRENT_H,0x4001)
		ssleep(4)
		TBRePos() ;DllCall("MoveWindow","Uint",hWnd1,"int",vWinX,"int",vWiny,"int",rw,"int",rh,"Int",2)
		if(STrigga)
			settimer,grace,-400
		if(!lbd){
			settimer,WM_lrBUTTONup,-150
			return,0
	}	}
	grace:
	disgrace:
	(instr(a_thislabel,"dis")? STrigga:= False : STrigga:= True)
}

WM_lrBUTTONup(wParam="",lParam="") { ;Toggle Maximise & fill;
	global STrigga, LbD:= ""
	if(!STrigga) {
		settimer,MenuGuiShow,-1
}	}

WM_MOVEEND() {
	global palmovtrig, Palactive ;if(!Palactive)winset,transparent,240,ahk_id %hpal%
settimer,redraw,-900
	return,	 palmovtrig:= False
}

WM_MOVE(wParam="",lParam="",msg="",hWnd="") {
	global
	critical
	try, {
		if(!Palactive) {
			gui,APCBackMain:hide
			gui,APCBackMain:show,% "hide x" (r_Wpos.x+r_Wpos.W) " y" (r_Wpos.y+(78)),
		} else {
			LPos:= wingetPos(ldr_hWnd)
			win_move(hpal,LPos.x+LPos.W,LPos.y+(78),"","","")
			settimer,PalTopp5,-1
		}	return,
	} ;settimer, wm_moveend,-100 ;gui,APCBackMain:Show,% "hide x" (LPos.x+LPos.W) " y" (LPos.y+(78)),Palette
}

OnWM_MOUSEMOVE(wParam="",lParam="",msg="",hWnd2="") {
	global CurChanged,HANDLES_ALLCTL
hWnd3:= Format("{:#x}",hWnd2)
;msgbox % hWnd3 "`n" HANDLES_ALLCTL
	switch,hWnd3 {
		case,htb : (!CurChanged? (SetSystemCursor("C:\Script\AHK\GUi\hand84-nq8.cur",84,84), CurChanged:= true))
		default :  instr(HANDLES_ALLCTL,hWnd3)? (!CurChanged? (SetSystemCursor("C:\Script\AHK\GUi\hand84-nq8.cur",84,84), CurChanged:= true)) : (CurChanged? (DllCall("SystemParametersInfo","uInt",0x57,"uInt",0,"uInt",0,"uInt",0), CurChanged:= false))
	}
}

gCursor(cursor="C:\Script\AHK\GUi\hand84-nq8.cur") {
 return,CurSet(cursor,84,84)
}


RedRaw() { ;return
 	static init, HandlesAll
	if(!init) {
		loop,parse,% "ldr_hWnd,SbarhWnd,htb,htab,hsci",`,
			HandlesAll.= %a_loopfield% ","
		loop,8
			HandlesAll.= b_%a_index%hWnd ","
		loop,5
			HandlesAll.= (run%a_index%).hWnd ","
		loop,4
			HandlesAll.= drop%a_index% ","
		loop,2
			HandlesAll.=  hchk%a_index% ","
		HandlesAll.= hcheckdlg ","
		HandlesAll.= htabszupdn ","
		HandlesAll.= htabszupdntxt ","
		HandlesAll.= htabszupdntxt2
		
		init:=True ;sci.GrabFocus()
	}	loop,parse,HandlesAll,`,
			winset,redraw,,ahk_id %a_loopfield%
	return,HandlesAll
}

RedRawButts() {
	static init, Handles_All_Butts
	if(!init) {
		loop,8
			Handles_All_Butts.= b_%a_index%hWnd ","
		loop,5
			Handles_All_Butts.= (run%a_index%).hWnd ","
		loop,4
			Handles_All_Butts.= drop%a_index% ","
		loop,2
			Handles_All_Butts.= hchk%a_index% ","
		Handles_All_Butts.= hcheckdlg  ","
		Handles_All_Butts.= htabszupdn ","
		Handles_All_Butts.= htabszupdntxt ","
		Handles_All_Butts.= htabszupdntxt2
		init:= True
	}	loop,parse,handles_all_butts,`,
			winset,redraw,,ahk_id %a_loopfield%
	return,Handles_All_Butts
}

TEST() {
	global gradwnd, HIPath, ldr_hWnd
	static oldw, oldh ;global gradwnd
	p:= wingetpos(ldr_hWnd)
	s:= wingetpos(hsci)	; winSet,Region,% "1-0 W" p.w " H" p.h " R" (p.w+ p.h) *.05 "-" (p.w+ p.h) *.05 ,ahk_id %gradwnd%
	if(p.w=oldw && p.h=oldh)
		return,
	oldw:= w:=p.w-48, oldh:= h:=p.h-241	;win_move(htab,"", 0,w,	p.h-250,"") 	;guiControl,move, HIPath, w%W% h%H%	;winSet,Region,% "1-1 W" p.w " H" p.h " R20-20",ahk_id %HIPath%
	if(g_dlgframe) {
		GradUpdate(p.w-19,h+2)
	} else,GradUpdate(w-3,h-22)
}

_Lex(){
	 ; return,
	global ldr_hWnd,sci,scihwnd,r_pid
	static p1d,hw,init:=0	;static textnew, textold	;, txtlold, txtl
	static phwn,sciname
	if (init=0) {
		phwn:= ldr_hWnd, sciname:= "scintilla1", pid:="", init:= 1
	}
	return,searchrep(Textnew:= sci_getall(hw,p1d))
}

Glass(thisColor=0x11402200,thisAlpha="",hWnd="") {
	Static init, accent_state:= 4
	,pad:= A_PtrSize=8? 4:0, WCA_ACCENT_POLICY:= 19
	NumPut(accent_state,ACCENT_POLICY,0,"int")
	NumPut(thisColor,ACCENT_POLICY,8,"int")
	VarSetCapacity(WINCOMPATTRDATA,4 +pad +A_PtrSize +4 +pad,0)
	&& NumPut(WCA_ACCENT_POLICY,WINCOMPATTRDATA,0,"int")
	&& NumPut(&ACCENT_POLICY,WINCOMPATTRDATA,4 +pad,"ptr")
	&& NumPut(64,WINCOMPATTRDATA,4 +pad +A_PtrSize,"uint")
	if(!DllCall("user32\SetWindowCompositionAttribute","ptr",hWnd,"ptr",&WINCOMPATTRDATA))
		return,
	accent_size:= VarSetCapacity(ACCENT_POLICY,16,0)
	return,
}

CreateNamedPipe(Name,OpenMode=3,PipeMode=0,MaxInstances=255) {
	return,dllcall("CreateNamedPipe","str","\\.\pipe\" Name,"uint",OpenMode
	,"uint",PipeMode,"uint",MaxInstances,"uint",0,"uint",0,"uint",0,"uint",0)
}

getPipePiD(byref pipe_n) {
	Sleep(3000), hw:= winexist(ad:= ("\\.\pipe\" . pipe_n))
	winget,pid,PID,Ahk_id %hw%
	return,pid
}

Pipe(bLabel) {
	global
	pipe_ga:= ""
	static pipe:= A_Tickcount
	, pip2:= pipe . 1
	r_:= (%bLabel%) ".exe"
	, indx:= SubStr(bLabel,0,1)
	gui,Cut0r:Submit,nohide
	local pipe_name:= a_now
	if(aca:= winexist(ad:= "\\.\pipe\" . pipe_nAME))
	loop, ;pipe_name:= "'" MyTab . "'" . " - " .AHK_Portable;
		if(aca:= winexist(ad:= "\\.\pipe\" .  pipe_nAME .  A_index))
			msgbox,% result "`n" pipe_name "`n" aca " taken"
		else,break,
	pipe_nAME .= A_index
	GI:= (r_ . " " . CHR(34) . "\\.\pipe\" . pipe_name .  CHR(34))
	(%pip2%):= CreateNamedPipe(pipe_name,2) ;"PIPE-Name" ; AHK calls GetFileAttributes();
	, (%pipe%):= CreateNamedPipe(pipe_name,2) ;<=>=> So,Closepipe,& Create 2nd pipe.;
	if(!((%pipe%)=-1||(%pip2%)=-1)) {
		run,% GI,"C:\Program Files\Autohotkey",,ppidd
		dllcall("ConnectNamedPipe",ptr,pipe_ga,ptr,0)
		dllcall("CloseHandle",ptr,pipe_ga)
		dllcall("ConnectNamedPipe",ptr,(%pipe%),ptr,0)
		, Script:= (A_IsUnicode? chr(0xfeff) : chr(239) chr(187) chr(191)) "#persistent`n" . textnew
		, char_size:= (A_IsUnicode? 2:1), ssleep(400) ;Crucial;
		(!dllcall("WriteFile",ptr, %pipe%,"str",Script,"uint",(StrLen(Script)+1)*char_size,"uint*",0,ptr,0)
		? MsgB0x("WriteFile failed: " ErrorLevel "/" A_LastError)
		: Pipes.push({ "name" : a:=pipe_name, "hWnd" : b:=(ppidd)}))
		dllcall("CloseHandle",ptr,(%pipe%))
		, ppid:= getPipePiD(pipe_name)
		return,
	} else,exitapp(msgB0x("Fail","CreateNamedPipe failed.",4))
}

palbutthandla(){
	global SelCol_Butt
	gui,APCBackMain:submit,nohide
	SelCol_Butt := A_GuiControl . "butt"
}

Win2DTopTrans(Child="",DX="",DY="") {
	global ; global ldr_hWnd
	DTopDocked:= True
	(!Child)? Child:= ldr_hWnd : (child<3800? dy:=dx, dx:=child, Child:=ldr_hWnd)
	WinGetPos,ChildX,ChildY,Child_W,Child_H,ahk_id %Child%
	win_move(ldr_hWnd,0,600)
	winminimize,ahk_id %ldr_hWnd%
	winset,Transparent,255,ahk_id %ldr_hWnd%
	loop,6
		sleep,10
	CoordMode,mouse,Window
	winrestore,ahk_id %ldr_hWnd%
	RE2:= DllCall("SetParent","uint",ldr_hWnd,"uint",DesktoP())
	, LdrPos:= WinGetPos(ldr_hWnd)
	winset,Style,-0x00440000,ahk_id %ldr_hWnd% ;SendMessage,0x421,,,,ahk_id %hTB%;
	Win_Move(ldr_hWnd,0,(a_screenheight-LdrPos.h)-10,LdrPos.w+45,LdrPos.h,"")
	;try,win_move(htb,1,(r_Wpos.h-95),(r_Wpos.w-10),70,70) ;SWP_NOACTIVATE|SWP_NOZORDER=0x4014;
	winset,ExStyle,+0x30,ahk_id %hTab% ;winset,Transparent,off,ahk_id %ldr_hWnd%;
	winget,uib,List,ahk_pid %rPiD% ;ahk_class #32770;
	loop,% uib {
		wingetClass,ldrClass,% "ahk_id " uib%a_index%
		if(ldrClass="AutoHotkeyGUI") {
			ControlGet,h3270,hWnd,,#327701,% "ahk_id " uib%a_index%
			winset,ExStyle,+0x20,ahk_id %h3270%
			winset,Style,-0x10000000,ahk_id %h3270%
	}	}	win_move(ldr_hWnd,acs.x+2,acs.y-2,acs.w-1,acs.h+1)
	, d2pos:= WinGetPos(ldr_hWnd)	;guiControl,Move,TBhWnd,% "x1 y2"
	, show_upd8() ; ToolbarInit() ;guiControl,Move,Cut0r:,TBhWnd,y500 ;sleep,300
	, bcnt:= wingetpos(TBhWnd), ssleep(20)
	ControlGetPos,X,Y,W,H,,ahk_id %TBhWnd% ;SetWindowPos(bcnt.X,bcnt.Y,bcnt.W,bcnt.H,0,0x4014
	ssleep(10)
	win_move(htb,1,d2pos.h-98,w,70,"") ;SWP_NOACTIVATE|SWP_NOZORDER=0x4014;
	ssleep(10), ssleep(10)
	return, ;win_move(htb,1,d2pos.h-98,w,70,"");
}

Win2DTopOpaque(Child="",DX="",DY="") { ;SWP_NOACTIVATE|SWP_NOZORDER
	global ;SetWindowPos(bcnt.X,bcnt.Y,bcnt.W,bcnt.H,0,0x4014)
	ControlGetPos,,,W,,,ahk_id %TBhWnd%
	winset,Style,-0x00400000,ahk_id %ldr_hWnd%
	LdrPos:= WinGetPos(ldr_hWnd)
	SendMessage,0x421,,,,ahk_id %hTB%
	Win_Move(ldr_hWnd,0,(a_screenheight-LdrPos.h)-10,LdrPos.w-11,LdrPos.h,"")
	winset,Transparent,off,ahk_id %ldr_hWnd%
	winset,ExStyle,+0x30,ahk_id %hTab%
	winget,uib,List,ahk_pid %rPiD% ;ahk_class #32770
	loop,% uib {
		wingetclass,ldrClass,ahk_id %ldr_hWnd%
		if(ldrClass="AutoHotkeyGUI") {
			ControlGet,h3270,hWnd,,#327701,ahk_id %ldr_hWnd%
			winset,ExStyle,	+0x20		,ahk_id %h3270%
			winset,Style,	-0x10000000	,ahk_id %h3270%
	}	}
	DTopDocked:= True
}

IDropTargetOnDrop_LV(TargetObject,pDataObj,KeyState,X,Y,DropEffect) {
	global SbarhWnd	;-- DragDrop flags
	Static DRAGDROP_S_DROP:= 0x40100 ; 262400
	,DRAGDROP_S_CANCEL:= 0x40101 ; 262401
;-- DROPEFFECT flags
	,DROPEFFECT_NONE:= 0 ;-- Drop target cannot accept the data.
	,DROPEFFECT_COPY:= 1 ;-- Drop results in a copy. The original data is untouched by the drag source.
	,DROPEFFECT_MOVE:= 2 ;-- Drag source should remove the data.
	,DROPEFFECT_LINK:= 4 ;-- Drag source should create a link to the original data.
	;-- Key state values (grfKeyState parameter)
	,MK_LBUTTON:= 0x01   ;-- The left mouse button is down.
	,MK_RBUTTON:= 0x02   ;-- The right mouse button is down.
	,MK_SHIFT  := 0x04   ;-- The SHIFT key is down.
	,MK_CONTROL:= 0x08   ;-- The CTRL key is down.
	,MK_MBUTTON:= 0x10   ;-- The middle mouse button is down.
	,MK_ALT    := 0x20   ;-- The ALT key is down.
	;	MK_BUTTON:= ?    ;-- Not documented.
	Static CF:= {15: "CF_HDROP"} ; Standard clipboard formats
	, TM:= {1:  "HGLOBAL"}	; TYMED enumeration
	, CF_NATIVE:= A_IsUnicode ? 13 : 1 ; CF_UNICODETEXT  : CF_TEXT
	, CF_PRIVATEFIRST:= 0x0200	;"Private" formats don't get GlobalFree()'d
	, CF_PRIVATELAST := 0x02FF
	, CF_GDIOBJFIRST:= 0x0300	;"GDIOBJ" formats do get DeleteObject()'d
	, CF_GDIOBJLAST := 0x03FF
	, CF_REGISTEREDFIRST:= 0xC000 ;"Registered" formats
	, CF_REGISTEREDLAST := 0xFFFF ;gui,+OwnDialogs;IDataObject_SetPerformedDropEffect(pDataObj,DropEffect)
	If(pEnumObj:= IDataObject_EnumFormatEtc(pDataObj)) { ;LV_Delete();GuiControl,-Redraw,LV
		While,IEnumFORMATETC_Next(pEnumObj,FORMATETC) {
			IDataObject_ReadFormatEtc(FORMATETC,Format,Device,Aspect,Index,Type)
			TYMED:= "NONE"
			If(Format >= CF_PRIVATEFIRST) && (Format <= CF_PRIVATELAST)
				Name:= "*PRIVATE" ; Example for getting values out of the returned binary Data
			IDataObject_GetData(pDataObj, FORMATETC, Size, Data)
			If(instr("1,15",Format))	{
				If(IDataObject_GetDroppedFiles(pDataObj,Files))
					For,Each,File In Files
					{
						if(f:= splitpath(file)).ext in ahk,txt
						{
							FileRead,Scriptnew,% file
							global fil3:= file
							SBtext:= file . ".. loaded: "
							SB_Settext(SBText,1)
							SB_Settext(SBText,2)
							SB_Settext(SBText,3)
							gosub,TabSelected ; LV_Add("", "", "", "", "", "", File)
							SeTxT(Scriptnew)
							sleep,400 ;_Lex()
							settimer,_Lex,-10
						} Scriptnew:= ""
					} Continue,
		}	} ;LV_Add("", A_Index, Format, Name, TYMED, Size, Value)
		ObjRelease(pEnumObj)
	} Loop,% LV_GetCount("Column")
		LV_ModifyCol(A_Index, "AutoHdr")
	GuiControl,+Redraw,LV
	Effect:= {0: "NONE", 1: "COPY", 2: "MOVE", 4: "LINK"}[DropEffect]
	Return,DropEffect
}

Col_Mult(col,operand:=0) {
	static 0x:="0x"
	b := 0x . (SubStr(col,3,2))
	,g := 0x . (SubStr(col,5,2))
	, r := 0x . (SubStr(col,7,2))
	loop,parse,% "b,g,r",`,
	{
		hex:= Format("{:#x}",(%a_loopfield%)* operand)
		loop,2
			(strlen(hex)<4? hex:= strReplace(hex,0x,"0x0"))
		(%a_loopfield%):= (SubStr(hex,3,2))
	} return,bgrout:= (0x . b . g . r)
}

Col_Add(Col,operator:= 0) {
	static 0x:= "0x"
	b:= 0x . (SubStr(col,3,2))
	,g:= 0x . (SubStr(col,5,2))
	, r:= 0x . (SubStr(col,7,2))
	loop,parse,% "b,g,r",`,
	{
		hex:= Format("{:#x}",(%a_loopfield%)+ operator)
		loop,2
			if(strlen(hex)<4)
				hex:= strreplace(hex,0x, "0x0")
		(%a_loopfield%):= (SubStr(hex,3,2))
	} return,bgrout:= (0x . b . g . r)
}

bgrRGB(bgr,hex=True) {
	static 0x:="0x"
	(instr(bgr,0x)? Hex0:= True)
	b:= (SubStr(bgr,(Hex0? 3:1),2))
	,g:= (SubStr(bgr,(Hex0? 5:3),2))
	, r:= (SubStr(bgr,(Hex0? 7:5),2))
	return,((hex? 0x . r . g . b : r . g . b))
}

CtlColor(Color, Handle) {
	Static CtlColorDB := {}
	((CtlColorDB[Handle])? hBM:= CtlColorDB[Handle]	: hBM:= DllCall("Gdi32.dll\CreateBitmap"
	,"Int",1,"Int",1,"UInt",1,"UInt", 24,"Ptr",0,"Ptr")	, hBM:= DllCall("User32.dll\CopyImage"
	,"Ptr",hBM,"UInt",0,"Int",0,"Int",0,"UInt",0x2008,"Ptr"), CtlColorDB[Handle]:= hBM)
	VarSetCapacity(BMBITS,4,0), Numput("0x" . Color,&BMBITS,0,"UInt")
	DllCall("Gdi32.dll\SetBitmapBits","Ptr",hBM,"UInt",3,"Ptr",&BMBITS)
	DllCall("User32.dll\SendMessage","Ptr",Handle,"UInt",0x172,"Ptr",0,"Ptr",hBM)
}

TimeScriptStart() {
	global a_scriptstarttime,tickss
	tooltip,% a_tickcount -tickss " Ms"
}

Time4mat(time="",pattern="") {
	FormatTime,out,time=""? A_now : time,% pattern=""? "H:m:ss" : pattern
	return,out
}

SetWindowPos(hWnd,x,y,w,h,hWndInsertAfter:= 0,uFlags:= 0x40) { ;SWP_SHOWWINDOW
	return,DllCall("SetWindowPos","Ptr",hWnd,"Ptr",hWndInsertAfter,"Int"
	,x,"Int",y,"Int",w,"Int",h,"UInt",uFlags)
}

EndTask(hWnd,fShutDown,fForce) {
	return,DllCall("EndTask","int",hWnd,"int",fShutDown,"int",fForce)
}

PaintLexForceoff:
PaintLexForce:= False
return,

Marginsize:
;msgbox,% "not called during init see."
sendmessage,0X868,1,1,,ahk_id %hsci%
FirstVisibleLine:= errorlevel
if(!LinesOnScreen) {
	sendmessage,0X942,1,1,,ahk_id %hsci%
	LinesOnScreen:= errorlevel ;tooltip,% LinesOnScreen " - " FirstVisibleLine
} if linesonscreen +firstvisibleline<100
	sci.SetMarginWidthN(0,20)
else,if linesonscreen +firstvisibleline>1019
	sci.SetMarginWidthN(0,38)
else,sci.SetMarginWidthN(0,28)
;tooltip %a_thishotkey%
return,

~wheelup::
~wheeldown::
settimer,marginsize,-100
return,

setlexerStyle() {
global
gay2:={}
;gosub,marginsize
sci.SetMarginWidthN(0,32) ; Show line numbers
sci.SetMarginMaskN(1,SC_MASK_FOLDERS) ; Show folding symbolsSC_MASK_FOLDERS
;sci.SetMarginSensitiveN(1,true) ; Catch Margin click notifications
sci.MarkerDefine(SC_MARKNUM_FOLDER,SC_MARK_BOXPLUS) ; Set up Margin Symbols
sci.MarkerDefine(SC_MARKNUM_FOLDEROPEN,SC_MARK_BOXMINUS)
sci.MarkerDefine(SC_MARKNUM_FOLDERSUB,SC_MARK_VLINE)
sci.MarkerDefine(SC_MARKNUM_FOLDERTAIL,SC_MARK_LCORNER)
sci.MarkerDefine(SC_MARKNUM_FOLDEREND,SC_MARK_BOXPLUSCONNECTED)
sci.MarkerDefine(SC_MARKNUM_FOLDEROPENMID,SC_MARK_BOXMINUSCONNECTED)
sci.MarkerDefine(SC_MARKNUM_FOLDERMIDTAIL,SC_MARK_TCORNER)
sci.MarkerSetFore(SC_MARKNUM_FOLDER,0x000000) ; Change margin symbols colors
sci.MarkerSetBack(SC_MARKNUM_FOLDER,0x5A0099)
sci.MarkerSetFore(SC_MARKNUM_FOLDEROPEN,0x000000)
sci.MarkerSetBack(SC_MARKNUM_FOLDEROPEN,0x5A5A5A)
sci.MarkerSetFore(SC_MARKNUM_FOLDERSUB,0xFFFFFF)
sci.MarkerSetBack(SC_MARKNUM_FOLDERSUB,0x5A5A5A)
sci.MarkerSetFore(SC_MARKNUM_FOLDERTAIL,0xFFFFFF)
sci.MarkerSetBack(SC_MARKNUM_FOLDERTAIL,0x5A5A5A)
sci.MarkerSetFore(SC_MARKNUM_FOLDEREND,0x0000FF)
sci.MarkerSetBack(SC_MARKNUM_FOLDEREND,0x5A5A5A)
sci.MarkerSetFore(SC_MARKNUM_FOLDEROPENMID,0xFF0000)
sci.MarkerSetBack(SC_MARKNUM_FOLDEROPENMID,0x5A5A5A)
sci.MarkerSetFore(SC_MARKNUM_FOLDERMIDTAIL,0x000000)
sci.MarkerSetBack(SC_MARKNUM_FOLDERMIDTAIL,0x00FF00)
sci.SetFoldFlags(SC_FOLDFLAG_LEVELNUMBERS)
sci.SetReadOnly(False)
 sci.StyleSetback(STYLE_BRACEBAD,		0xFFeeff)
 sci.StyleSetFore(SCE_AHKL_STRINGOPTS,	0x0022EE)
 sci.StyleSetFore(SCE_AHKL_STRINGBLOCK,	0xA2A2A2) 
 sci.StyleSetFore(SCE_AHKL_STRINGCOMMENT,0xFF0000)
 sci.StyleSetFore(STYLE_BRACELIGHT,		0xFFff00)
 sci.StyleSetback(STYLE_BRACELIGHT,		0xFFff00)
 sci.StyleSetFore(STYLE_BRACEBAD,		0x5554ff)
 sci.StyleSetFont(Style_DEFAULT,"monospaced","monospaced")
sci.Stylesetsize(Style_DEFAULT,10)
sci.StyleSetFore(Style_DEFAULT,0x9900ff)
sci.StyleSETBACK(Style_DEFAULT,0x000000)
sci.SETWHITESPACEback(Style_DEFAULT,0x000000)
sci.StyleSetBold(Style_DEFAULT,False)
sci.SetLexer(Style_DEFAULT)
;sci.SETUSETABS(True) 
;sci.SCI_SETTABINDENTS(1)
sci.DELETEBACK()
sci.SetLexer(SCLEX_AHKL)
;sci.SCI_SETTABWIDTH(1)
sci.SetcaretFore(0x664433)
sci.SETselectionback(Style_DEFAULT,0x00aaff)
sci.SETSELBACK(Style_DEFAULT,0x400580)
sci.SetLexer(SCLEX_AHKL) ;sci.SCI_SETTABWIDTH(1)
sci.Notify := "SCI_NOTIFY" ; Command list
Dir=
(
#allowsamelinecomments #clipboardtimeout #commentflag #errorstdout #escapechar #hotkeyinterval
#hotkeymodifiertimeout #hotstring #if #iftimeout #ifwinactive #ifwinexist #include #includeagain
#installkeybdhook #installmousehook #keyhistory #ltrim #maxhotkeysperinterval #maxmem #maxthreads
#maxthreadsbuffer #maxthreadsperhotkey #menumaskkey #noenv #notrayicon #persistent #singleinstance
#usehook #warn #winactivateforce
)
Com=
(
autotrim blockinput clipwait control controlclick controlfocus controlget controlgetfocus
controlgetpos controlgettext controlmove controlsend controlsendraw controlsettext coordmode
critical detecthiddentext detecthiddenwindows drive driveget drivespacefree edit endrepeat envadd
envdiv envget envmult envset envsub envupdate fileappend filecopy filecopydir filecreatedir
filecreateshortcut filedelete filegetattrib filegetshortcut filegetsize filegettime filegetversion
fileinstall filemove filemovedir fileread filereadline filerecycle filerecycleempty fileremovedir
fileselectfile fileselectfolder filesetattrib filesettime formattime getkeystate groupactivate
groupadd groupclose groupdeactivate gui guicontrol guicontrolget hideautoitwin hotkey if ifequal
ifexist ifgreater ifgreaterorequal ifinstring ifless iflessorequal ifmsgbox ifnotequal ifnotexist
ifnotinstring ifwinactive ifwinexist ifwinnotactive ifwinnotexist imagesearch inidelete iniread
iniwrite input inputbox keyhistory keywait listhotkeys listlines listvars menu mouseclick
mouseclickdrag mousegetpos mousemove msgbox outputdebug pixelgetcolor pixelsearch postmessage
process progress random regdelete regread regwrite reload run runas runwait send sendevent
sendinput sendmessage sendmode sendplay sendraw setbatchlines setcapslockstate setcontroldelay
setdefaultmousespeed setenv setformat setkeydelay setmousedelay setnumlockstate setscrolllockstate
setstorecapslockmode settitlematchmode setwindelay setworkingdir shutdown sort soundbeep soundget
soundgetwavevolume soundplay soundset soundsetwavevolume splashimage splashtextoff splashtexton
splitpath statusbargettext statusbarwait stringcasesense stringgetpos stringleft stringlen
stringlower stringmid stringreplace stringright stringsplit stringtrimleft stringtrimright
stringupper sysget thread tooltip transform traytip urldownloadtofile winactivate winactivatebottom
winclose winget wingetactivestats wingetactivetitle wingetclass wingetpos wingettext wingettitle
winhide winkill winmaximize winmenuselectitem winminimize winminimizeall winminimizeallundo winmove
winrestore winset winsettitle winshow winwait winwaitactive winwaitclose winwaitnotactive
fileencoding
)
Param=
(
ltrim rtrim join ahk_id ahk_pid ahk_class ahk_group processname minmax controllist statuscd
filesystem setlabel alwaysontop mainwindow nomainwindow useerrorlevel altsubmit hscroll vscroll
imagelist wantctrla wantf2 vis visfirst wantreturn backgroundtrans minimizebox maximizebox
sysmenu toolwindow exstyle check3 checkedgray readonly notab lastfound lastfoundexist alttab
shiftalttab alttabmenu alttabandmenu alttabmenudismiss controllisthwnd hwnd deref pow bitnot
bitand bitor bitxor bitshiftleft bitshiftright sendandmouse mousemove mousemoveoff
hkey_local_machine hkey_users hkey_current_user hkey_classes_root hkey_current_config hklm hku
hkcu hkcr hkcc reg_sz reg_expand_sz reg_multi_sz reg_dword reg_qword reg_binary reg_link
reg_resource_list reg_full_resource_descriptor caret reg_resource_requirements_list
reg_dword_big_endian regex pixel mouse screen relative rgb low belownormal normal abovenormal
high realtime between contains in is integer float number digit xdigit alpha upper lower alnum
time date not or and topmost top bottom transparent transcolor redraw region id idlast count
list capacity eject lock unlock label serial type status seconds minutes hours days read parse
logoff close error single shutdown menu exit reload tray add rename check uncheck togglecheck
enable disable toggleenable default nodefault standard nostandard color delete deleteall icon
noicon tip click show edit progress hotkey text picture pic groupbox button checkbox radio
dropdownlist ddl combobox statusbar treeview listbox listview datetime monthcal updown slider
tab tab2 iconsmall tile report sortdesc nosort nosorthdr grid hdr autosize range xm ym ys xs xp
yp font resize owner submit nohide minimize maximize restore noactivate na cancel destroy
center margin owndialogs guiescape guiclose guisize guicontextmenu guidropfiles tabstop section
wrap border top bottom buttons expand first lines number uppercase lowercase limit password
multi group background bold italic strike underline norm theme caption delimiter flash style
checked password hidden left right center section move focus hide choose choosestring text pos
enabled disabled visible notimers interrupt priority waitclose unicode tocodepage fromcodepage
yes no ok cancel abort retry ignore force on off all send wanttab monitorcount monitorprimary
monitorname monitorworkarea pid base useunsetlocal useunsetglobal localsameasglobal str astr wstr
int64 int short char uint64 uint ushort uchar float double int64p intp shortp charp uint64p uintp
ushortp ucharp floatp doublep ptr
)
Flow=
(
break continue else exit exitapp gosub goto loop onexit pause repeat return settimer sleep
suspend static global local byref while until for
)
Fun=
(
abs acos asc asin atan ceil chr cos dllcall exp fileexist floor getkeystate numget numput
registercallback il_add il_create il_destroy instr islabel isfunc ln log lv_add lv_delete
lv_deletecol lv_getcount lv_getnext lv_gettext lv_insert lv_insertcol lv_modify lv_modifycol
lv_setimagelist mod onmessage round regexmatch regexreplace sb_seticon sb_setparts sb_settext
sin sqrt strlen substr tan tv_add tv_delete tv_getchild tv_getcount tv_getnext tv_get tv_getparent
tv_getprev tv_getselection tv_gettext tv_modify varsetcapacity winactive winexist trim ltrim rtrim
fileopen strget strput object isobject objinsert objremove objminindex objmaxindex objsetcapacity
objgetcapacity objgetaddress objnewenum objaddref objrelease objclone _insert _remove _minindex
_maxindex _setcapacity _getcapacity _getaddress _newenum _addref _release _clone comobjcreate
comobjget comobjconnect comobjerror comobjactive comobjenwrap comobjunwrap comobjparameter
comobjmissing comobjtype comobjvalue comobjarray
)
BIVar=
(
a_ahkpath a_ahkversion a_appdata a_appdatacommon a_autotrim a_batchlines a_caretx a_carety
a_computername a_controldelay a_cursor a_dd a_ddd a_dddd a_defaultmousespeed a_desktop
a_desktopcommon a_detecthiddentext a_detecthiddenwindows a_endchar a_eventinfo a_exitreason
a_formatfloat a_formatinteger a_gui a_guievent a_guicontrol a_guicontrolevent a_guiheight
a_guiwidth a_guix a_guiy a_hour a_iconfile a_iconhidden a_iconnumber a_icontip a_index a_ipaddress1
a_ipaddress2 a_ipaddress3 a_ipaddress4 a_isadmin a_iscompiled a_issuspended a_keydelay a_language
a_lasterror a_linefile a_linenumber a_loopfield a_loopfileattrib a_loopfiledir a_loopfileext
a_loopfilefullpath a_loopfilelongpath a_loopfilename a_loopfileshortname a_loopfileshortpath
a_loopfilesize a_loopfilesizekb a_loopfilesizemb a_loopfiletimeaccessed a_loopfiletimecreated
a_loopfiletimemodified a_loopreadline a_loopregkey a_loopregname a_loopregsubkey
a_loopregtimemodified a_loopregtype a_mday a_min a_mm a_mmm a_mmmm a_mon a_mousedelay a_msec
a_mydocuments a_now a_nowutc a_numbatchlines a_ostype a_osversion a_priorhotkey a_programfiles
a_programs a_programscommon a_screenheight a_screenwidth a_scriptdir a_scriptfullpath a_scriptname
a_sec a_space a_startmenu a_startmenucommon a_startup a_startupcommon a_stringcasesense a_tab a_temp
a_thishotkey a_thismenu a_thismenuitem a_thismenuitempos a_tickcount a_timeidle a_timeidlephysical
a_timesincepriorhotkey a_timesincethishotkey a_titlematchmode a_titlematchmodespeed a_username
a_wday a_windelay a_windir a_workingdir a_yday a_year a_yweek a_yyyy clipboard clipboardall comspec
programfiles a_thisfunc a_thislabel a_ispaused a_iscritical a_isunicode a_ptrsize errorlevel
true false
)
Keys=
(
shift lshift rshift alt lalt ralt control lcontrol rcontrol ctrl lctrl rctrl lwin rwin appskey
altdown altup shiftdown shiftup ctrldown ctrlup lwindown lwinup rwindown rwinup lbutton rbutton
mbutton wheelup wheeldown xbutton1 xbutton2 joy1 joy2 joy3 joy4 joy5 joy6 joy7 joy8 joy9 joy10 joy11
joy12 joy13 joy14 joy15 joy16 joy17 joy18 joy19 joy20 joy21 joy22 joy23 joy24 joy25 joy26 joy27
joy28 joy29 joy30 joy31 joy32 joyx joyy joyz joyr joyu joyv joypov joyname joybuttons joyaxes
joyinfo space tab enter escape esc backspace bs delete del insert ins pgup pgdn home end up down
left right printscreen ctrlbreak pause scrolllock capslock numlock numpad0 numpad1 numpad2 numpad3
numpad4 numpad5 numpad6 numpad7 numpad8 numpad9 numpadmult numpadadd numpadsub numpaddiv numpaddot
numpaddel numpadins numpadclear numpadup numpaddown numpadleft numpadright numpadhome numpadend
numpadpgup numpadpgdn numpadenter f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15 f16 f17 f18 f19
f20 f21 f22 f23 f24 browser_back browser_forward browser_refresh browser_stop browser_search
browser_favorites browser_home volume_mute volume_down volume_up media_next media_prev media_stop
media_play_pause launch_mail launch_media launch_app1 launch_app2 blind click raw wheelleft
wheelright
)
	sci.SetLexer(SCLEX_AHKL)  
	sci.Stylesetsize(SCLEX_AHKL,10)
	sci.StyleClearAll()
	sci.StyleSetBold(SCLEX_AHKL,False)
	sci.SetWrapMode(True)
	; Set Autohotkey Lexer and default options
	sci.StyleSetFont(STYLE_DEFAULT,"Courier New"), sci.StyleSetSize(STYLE_DEFAULT,10)
	sendmessage,2036,4,0,,ahk_id %hsci% ;SCI_GETTEXT:=2182;
	sendmessage,2353,0,0,,ahk_id %hsci% ;SCI_BRACEMATCH
	sendmessage,2352,1,1,,ahk_id %hsci% ;
	sendmessage,2351,1,1,,ahk_id %hsci% ;
	sendmessage,2373,-3,-3,,ahk_id %hsci% ;SCI_SETZOOM:=

  sci.StyleSetFore(SCE_AHKL_IDENTIFIER,			gay2["col_IDENTIFIER"]:=0xFF0000) ;Set Style Colors
  sci.StyleSetFore(SCE_AHKL_COMMENTDOC,			gay2["col_COMMENTDOC"]:= 0x000088)
  sci.StyleSetFore(SCE_AHKL_COMMENTLINE,		gay2["col_COMMENTLINE"]:= 0x701530)
  sci.StyleSetFore(SCE_AHKL_COMMENTBLOCK,		gay2["col_COMMENTBLOCK"]:= 0x701530), sci.StyleSetBold(SCE_AHKL_COMMENTBLOCK,False)
  sci.StyleSetFore(SCE_AHKL_COMMENTKEYWORD,		gay2["col_COMMENTKEYWORD"]:= 0xA50000), sci.StyleSetBold(SCE_AHKL_COMMENTKEYWORD,False)
  sci.StyleSetFore(SCE_AHKL_STRING,				gay2["col_STRING"]:= 0xaaaa00)
 ; sci.StyleSetFore(SCE_AHKL_STRINGOPTS,	0x0022EE)
 ; sci.StyleSetFore(SCE_AHKL_STRINGBLOCK,	0xA2A2A2)
  sci.StyleSetFore(SCE_AHKL_STRINGCOMMENT,		0xFF0000)
  sci.StyleSetFore(STYLE_BRACELIGHT,		0xFFff00)
  sci.StyleSetback(STYLE_BRACELIGHT,		0xFFff00)
  sci.StyleSetFore(STYLE_BRACEBAD,		0x5554ff)
  sci.StyleSetback(STYLE_BRACEBAD,		0xFFeeff)
  sci.StyleSetFore(SCE_AHKL_LABEL,				gay2["col_LABEL"]:= 0x0000DD)
  sci.StyleSetFore(SCE_AHKL_HOTKEY,				gay2["col_HOTKEY"]:= 0x00AADD)
  sci.StyleSetFore(SCE_AHKL_HOTSTRING,			gay2["col_HOTSTRING"]:= 0x0000BB)
  sci.StyleSetFore(SCE_AHKL_HOTSTRINGOPT,		0x990099)
  sci.StyleSetFore(SCE_AHKL_HEXNUMBER,			gay2["col_HEXNUMBER"]:= 0x880088)
  sci.StyleSetFore(SCE_AHKL_DECNUMBER,			gay2["col_DECNUMBER"]:= 0xFF9000)
  sci.StyleSetFore(SCE_AHKL_VAR,				gay2["col_VAR"]:= 0xFF9000)
  sci.StyleSetFore(SCE_AHKL_VARREF,				gay2["col_VARREF"]:= 0x990055)
  sci.StyleSetFore(SCE_AHKL_OBJECT,				gay2["col_OBJECT"]:= 0x008888)
  sci.StyleSetFore(SCE_AHKL_USERFUNCTION,		gay2["col_USERFUNCTION"]:= 0x0000DD)
  sci.StyleSetFore(SCE_AHKL_DIRECTIVE,			gay2["col_DIRECTIVE"]:= 0x4A0000), sci.StyleSetBold(SCE_AHKL_DIRECTIVE,False)
  sci.StyleSetFore(SCE_AHKL_COMMAND,			gay2["col_COMMAND"]:= 0x0000DD), sci.StyleSetBold(SCE_AHKL_COMMAND,False)
  sci.StyleSetFore(SCE_AHKL_PARAM,				gay2["colPARAM_"]:= 0x0085DD)
  sci.StyleSetFore(SCE_AHKL_CONTROLFLOW,		gay2["col_CONTROLFLOW"]:= 0x0000DD)
  sci.StyleSetFore(SCE_AHKL_BUILTINFUNCTION,	gay2["col_BUILTINFUNCTION"]:= 0xDD00DD)
  sci.StyleSetFore(SCE_AHKL_BUILTINVAR,			gay2["col_BUILTINVAR"]:= 0xEE00ff), sci.StyleSetBold(SCE_AHKL_BUILTINVAR,False)
  sci.StyleSetFore(SCE_AHKL_KEY,				gay2["col_KEY"]:= 0xA2A2A2), sci.StyleSetBold(SCE_AHKL_KEY,False), sci.StyleSetItalic(SCE_AHKL_KEY,true)
;sci.SCI_SETTABINDENTS(1)
 ;; sci.StyleSetFore(SCE_AHKL_USERDEFINED1,		0xFF0000)
;;  sci.StyleSetFore(SCE_AHKL_USERDEFINED2,		0x00FF00)
  sci.StyleSetFore(SCE_AHKL_ESCAPESEQ,			0x660000)
sci.StyleSetItalic(SCE_AHKL_ESCAPESEQ,			true)
  sci.StyleSetFore(SCE_AHKL_ERROR,				0xFF0000)
;  sci.SetLexer(SCLEX_AHKL)
; ; Put some text in the control (optional); FileRead, text, Highlight Test.txt; sci.SetText(unused, text), sci.GrabFocus()
; Set up keyword lists, the variables are set at the beginning of the code
;	Loop,9 {
;		lstN:=a_index-1
;		sci.SetKeywords(lstN, ( lstN = 0 ? Dir
;							: lstN = 1 ? Com
;							: lstN = 2 ? Param
;							: lstN = 3 ? Flow
;							: lstN = 4 ? Fun
;							: lstN = 5 ? BIVar
;							: lstN = 6 ? Keys
;							: lstN = 7 ? UD1
;							: lstN = 8 ? UD2
;							: null))
;	} sci.GrabFocus()
 return,gay2
}

#h::
gayinc++
g:=gay[gayinc]
_g:=gay[gayinc-1]
sci.StyleSetBold(%g%,true)
sci.StyleSetBold(%_g%,false)
sci.StyleSetFore(%g%,0x990099)
sci.StyleSetFore(%_g%,0x444444)
tt(g "dsds " %g% )
return,

^#h::
gayinc--
g:=gay[gayinc]
g_:=gay[gayinc+1]
sci.StyleSetBold(%g%,true)
sci.StyleSetBold(%g_%,false)
sci.StyleSetFore(%g%,		0x990099)
sci.StyleSetFore(%g_%,		0x444444)
tt(g "dsds " %g% )
return,

SeTxT(byref txt,byref obj="sci") {
	global (%obj%)
	static needle:= "[ \t]*(?!(if\(|while\(|for\())([\w#!^+&<>*~$])+\d*(\([^)]*\)|\[[^]]*\])([\s]|(/\*.*?\*)/|((?<=[\s]);[^\r\n]*?$))*?[\s]*\{|^[ \t]*(?!(if\(|while\(|for\())([\w#!^+&<>*~$])+\d*:(?=([\s]*[\r\n]|[\s]+;.*[\r\n]))|^[ \t]*(?!(;|if\(|while\(|for\())([^\r\n\t])+\d*(?&lt;![\s])" ;text3:= txt
	SBtext:= fil3 . ": loaded..."
	SB_Settext(SBText,1), SB_Settext(SBText,2), SB_Settext(SBText,3)
	(%obj%).SeTtexT(unused,txt,0xff00fff)
	return,
}

SearchRep(byref txt="",byref obj="",byref dicX="") {
	global ;(%obj%),textnew PaintLexForce
	static textnew,txtlengthold,txtlength
	,Flow:= "break|byref|catch|class|continue|else|exit|exitapp|finally|for|global|gosub|goto|if|ifequal|ifexist|ifgreater|ifgreaterorequal|ifinstring|ifless|iflessorequal|ifmsgbox|ifnotequal|ifnotexist|ifnotinstring|ifwinactive|ifwinexist|ifwinnotactive|ifwinnotexist|local|loop|onexit|pause|return|settimer|sleep|static|suspend|throw|try|until|var|while"
	,Commands:= "autotrim|blockinput|clipwait|control|controlclick|controlfocus|controlget|controlgetfocus|controlgetpos|controlgettext|controlmove|controlsend|controlsendraw|controlSeTxT|coordmode|critical|detecthiddentext|detecthiddenwindows|drive|driveget|drivespacefree|edit|envadd|envdiv|envget|envmult|envset|envsub|envupdate|fileappend|filecopy|filecopydir|filecreatedir|filecreateshortcut|filedelete|fileencoding|filegetattrib|filegetshortcut|filegetsize|filegettime|filegetversion|fileinstall|filemove|filemovedir|fileread|filereadline|filerecycle|filerecycleempty|fileremovedir|fileselectfile|fileselectfolder|filesetattrib|filesettime|formattime|getkeystate|groupactivate|groupadd|groupclose|groupdeactivate|gui|guicontrol|guicontrolget|hotkey|imagesearch|inidelete|iniread|iniwrite|input|inputbox|keyhistory|keywait|listhotkeys|listlines|listvars|menu|mouseclick|mouseclickdrag|mousegetpos|mousemove|msgbox|outputdebug|pixelgetcolor|pixelsearch|postmessage|process|progress|random|regdelete|regread|regwrite|reload|run|runas|runwait|send|sendevent|sendinput|sendlevel|sendmessage|sendmode|sendplay|sendraw|setbatchlines|setcapslockstate|setcontroldelay|setdefaultmousespeed|setenv|setformat|setkeydelay|setmousedelay|setnumlockstate|setregview|setscrolllockstate|setstorecapslockmode|settitlematchmode|setwindelay|setworkingdir|shutdown|sort|soundbeep|soundget|soundgetwavevolume|soundplay|soundset|soundsetwavevolume|splashimage|splashtextoff|splashtexton|splitpath|statusbargettext|statusbarwait|stringcasesense|stringgetpos|stringleft|stringlen|stringlower|stringmid|stringreplace|stringright|stringsplit|stringtrimleft|stringtrimright|stringupper|sysget|thread|tooltip|transform|traytip|urldownloadtofile|winactivate|winactivatebottom|winclose|winget|wingetactivestats|wingetactivetitle|wingetclass|wingetpos|wingettext|wingettitle|winhide|winkill|winmaximize|winmenuselectitem|winminimize|winminimizeall|winminimizeallundo|winmove|winrestore|winset|winsettitle|winshow|winwait|winwaitactive|winwaitclose|winwaitnotactive"
	,Functions:= "abs|getkeyname"
	,Keynames:= "alt|altdown|altup|appskey|backspace|blind|browser\_back|browser\_favorites|browser\_forward|browser\_home|browser\_refresh|browser\_search|browser\_stop|bs|capslock|click|control|ctrl|ctrlbreak|ctrldown|ctrlup|del|delete|down|end|enter|esc|escape|f1|f10|f11|f12|f13|f14|f15|f16|f17|f18|f19|f2|f20|f21|f22|f23|f24|f3|f4|f5|f6|f7|f8|f9|home|ins|insert|joy1|joy10|joy11|joy12|joy13|joy14|joy15|joy16|joy17|joy18|joy19|joy2|joy20|joy21|joy22|joy23|joy24|joy25|joy26|joy27|joy28|joy29|joy3|joy30|joy31|joy32|joy4|joy5|joy6|joy7|joy8|joy9|joyaxes|joybuttons|joyinfo|joyname|joypov|joyr|joyu|joyv|joyx|joyy|joyz|lalt|launch\_app1|launch\_app2|launch\_mail|launch\_media|lbutton|lcontrol|lctrl|left|lshift|lwin|lwindown|lwinup|mbutton|media\_next|media\_play\_pause|media\_prev|media\_stop|numlock|numpad0|numpad1|numpad2|numpad3|numpad4|numpad5|numpad6|numpad7|numpad8|numpad9|numpadadd|numpadclear|numpaddel|numpaddiv|numpaddot|numpaddown|numpadend|numpadenter|numpadhome|numpadins|numpadleft|numpadmult|numpadpgdn|numpadpgup|numpadright|numpadsub|numpadup|pause|pgdn|pgup|printscreen|ralt|raw|rbutton|rcontrol|rctrl|right|rshift|rwin|rwindown|rwinup|scrolllock|shift|shiftdown|shiftup|space|tab|up|volume\_down|volume\_mute|volume\_up|wheeldown|wheelleft|wheelright|wheelup|xbutton1|xbutton2"
	,Builtins:= "base|clipboard|clipboardall|comspec|errorlevel|False|programfiles|True"
	,Keywords:= "abort|abovenormal"
	,Needle:="
	(LTrim Join Comments
		ODims)
		((?:\s);[\n]+)							; Comments
		|(\s*\/\*.+?\s*\*\/)					; Multiline comments
		|((?:^|\s)#[^ \t\r\n,]+)				; Directives
		|([+*!~&\/\\<>^|=?:().```%{}\[\]\-]+)	; Punctuation
		|\b(0x[0-9a-fA-F]+|[0-9]+)				; Numbers
		|(""[^""\r\n]*"")						; Strings
		|\b(" Builtins ")\b						; A_Builtins
		|\b(" Flow ")\b							; Flow
		|\b(" Commands ")\b						; Commands
		|\b(" Functions ")\b					; Functions (builtin)
		|\b(" Keywords ")\b						; Other keywords
		|\b(" Keynames ")\b						; Keynames
		|(([a-zA-Z_$]+)(?=\())					; Functions
		|(^\s*[A-Z()-\s]+\:\N)					; Descriptions
	)"
	dicX:= dix, (obj=""? obj:="sci")
	if(!txt) ;ControlGetText,Textnew,scintilla1,ahk_id %ldr_hWnd%
		Txt:= sci_getall(hsci,r_pid)
	sci.SetTargetRange(0,(txtlength:=strlen(Txt))+1)
	if(txtlengthold=txtlength) {
		if(!PaintLexForce)
			return,
	} txtlengthold:= txtlength
	,c:= 0, FoundPos:= 0. Pos:= 1
	critical
	TickSS:= a_tickcount
	while(FoundPos:= regexmatch(txt,Needle,Match,pos)) {
		loop,12  ;if(MatchVal(Pos,Len,a_index,colz[ a_index ])) { ;if(MatchVal(FoundPos,Match.Len(),a_index,Dix[ a_index ].Colour,Dix[ a_index ].Font, Dix[ a_index ].Size, Dix[ a_index ].Italic, Dix[ a_index ].Bold, Dix[ a_index ].Underline)) {
			if(Match.Value(a_index))
				MatchVal(FoundPos,Match.Len(),a_index,dix[ a_index ].Colour,Match) ;continue
		Pos:= FoundPos +Match.Len()+1 ;continue
	} ;
	
	
	
	
	
	
	
	tooltip,% a_tickcount -tickss " Ms" ;TimeScriptStart()
	;gosub,marginsize

}

MatchVal(Pos="",Len="",IDNum="",Colour="",byref match="") {
	static obj:="sci"
	critical
	(IDNum=16)? sci_style:= "Style_DEFAULT" : sci_style:= "SCE_AHKL_USERDEFINED" . IDNum
	; ((Font!=""?)	(%obj%).StyleSetFont(sci_style, Font , Font ))
	; (Size!=""?	(%obj%).StyleSetSize(sci_style, Size ))
	; (Italic!=""?	(%obj%).StyleSetItalic(sci_style,(( Italic ="off")? False : (Italic="on"?True))))
	; (Bold!=""?	(%obj%).StyleSetBold(sci_style,(( Bold ="off")? False : (Bold="on"?True))))
	; (Underline!=""? (%obj%).STYLESETUNDERLINE(sci_style,(( Underline ="off")? False : (Underline="on"?True))))
	return,((colour)? sci.StyleSetFore((%sci_style%),dix[IDNum].colour):())
				,sci.StartStyling(Pos-1)
			,sci.SetTargetRange(Pos,Pos+Len)
		,sci.SetStyling(Len,(%sci_style%))
}

sci_getall(scihwnd="",scipid="") {
	global ;static ticket
	if(scihwnd="") {
		hwnd:= winexist("A")
		ControlGetFocus,cname,ahk_id %hwnd%
		if(eRRORlEVEL)
			return,
		ControlGet,scihwnd,Hwnd,,% cname,ahk_id %hwnd%
	} hwnd:= scihwnd
	if(scipid="")
		winget,scipid,pid,ahk_id %hwnd%
	sendmessage,2006,"","",,ahk_id %scihwnd% ;SCI_GETLENGTH:=2006
	VarSetCapacity(ticket,(len:= errorlevel)+1,0)
	Address:= DllCall("VirtualAllocEx","Ptr",(hProc:= DllCall("OpenProcess","UInt",0x438,"Int",False,"UInt"
	,scipid,"Ptr")),"Ptr",0,"UPtr",len+1,"UInt",0x1000,"UInt",4,"Ptr")
	sendmessage,2182,len-1,Address,,ahk_id %scihwnd% ;SCI_GETTEXT:=2182;
	if success:= DllCall("ReadProcessMemory","Ptr",hProc,"Ptr",Address,"Ptr",&ticket,"UPtr",len-1,"uint","","uint")
	;msgbox,% Byte2Str("ticket") " " len " " _:= Byte2Str("ticket")
	return,Byte2Str("ticket")
}

custOverlay() {
	global ; Desired image>> ;>>;
	gui,pwn: -Caption -DPIScale -SysMenu +alwaysontop +toolwindow +0x8000000 +E0x080008 +hWndhGui +parentCut0r
	gui,pic_:-Caption -SysMenu +alwaysontop +parentpwn +HwndthWnd	;+E0x080008
	imghWnd:= 1mgdr4w(ImgFilePath:= "C:\Script\AHK\GDI\images\uu.png",80,0,-16,-10)
	return,byref hGui
}

Byte2Str(bytes_var_name="",CodePg="CP936") {
	static cp:="CP936"
	(CodePg!="CP936"? Cp:= CodePg)
	return,ret:= strget(&(%bytes_var_name%),len-1,Cp)
}

ButtHandl4(butt) {
	global
	switch,butt {
		case "1":
		case "2":
		case "3":
		case "4":
		case "5":
		case "6":
		case "7":
		case "8":
		case "9":
		case "10":
		case "11":
		case "12":
		case "13":
		case "14":
		case "15":
		case "16":
		case "17":
		if(!Palactive) {
			settimer,Palactivate,-1
			return,
		} else,if(Palactive) {
			settimer,palahide,-1
			return,
		}
		case "18":
		case "19":
	}
}

MenHandlr(isTarget="") {
	global
	switch,nus:= a_thismenuitem {
		case "Open Containing": TT("Opening "   a_scriptdir "..." Open_Containing(A_scriptFullPath),1)
		case "edit","SUSPEND","pAUSE": MenuPost(%a_thismenuitem%)
		case "Open Vars" : tt()
			PostMessage,0x0111,65407,,,% A_ScriptName " - AutoHotkey"
		case "r3load" : r3load()
		case "exit" : exitApp,
		case "mount-2-desktop(Trans)": Win2DTopTrans(ldr_hWnd,(deskX:= (guipos:=wingetpos(ldr_hWnd)).x),(desky:=guipos.y))
		case "mount-2-desktop(AeroG)","mount-2-desktop(Opaque)":
			Win2DTopOpaque(ldr_hWnd,(deskX:= (guipos:=wingetpos(ldr_hWnd)).x),(desky:=guipos.y))
		case "mount-2-desktop(FrostGlass)": glass(0x70441133,240,ldr_hWnd), Aero_BlurWindow(hpal)
			sleep,1100
			glass(0x90280411,240,ldr_hWnd)
		Win2DTopOpaque(ldr_hWnd,(deskX:= (guipos:=wingetpos(ldr_hWnd)).x),(desky:=guipos.y))
		;default: settimer,%a_thismenuitem%,-10 : ())
}	}

MenuGuiShow() {
	menu,New,Add,Testmenu,Donothing
	menu,New,Show
}

MenuTrayShow() {
	Menu,Tray,Show
}

MenuPost(wMsgEnum) {
	PostMessage,0x0111,% wMsgEnum,,,% A_ScriptName " - AutoHotkey"
}

AHK_NOTIFYICON(byref wParam="",byref lParam="") {
	switch,lParam {
		; case 0x0204: return,timer("MenuTrayShow",-20) ;WM_RBUTTONDN-0x0204l;
		case 0x0204 : return,MenuTrayShow() ;WM_RBUTTONDN-0x0204l;
		case 0x0203 : _:="", wParam:=""
			PostMessage,0x0111,65407,,,% A_ScriptName " - AutoHotkey"
			Sleep(80),lParam:= (Sleep(11),tt("Loading...","tray",1))
	;	case 0x0206: ; WM_RBUTTONDBLCLK	;	case 0x020B: ; WM_XBUTTONDOWN
	;	case 0x0201: ; WM_LBUTTONDOWN	;	case 0x0202: ; WM_LBUTTONUP
	return,
}	} ; WM_DoubleClick	;	ID_VIEW_VARIABLES:= 65407

Menuz:
menu,Tray,NoStandard
menu,Tray,Add,% (an:= splitpath(A_scriptFullPath)).fn,% "do_nothing"
menu,Tray,icon,% an.fn,% "D:\Documents\My Pictures\- Icons\256\Alien (11).ico",,32
menu,Tray,disable,% an.fn
menu,Tray,Add,% "Always on top",% "MenHandlr"
(opAlwaysOnTop? icon:= ico_tick : icon:= ico_cross)
menu,Tray,icon,% "Always on top",% icon,,32
menu,Tray,Add,% "taskbar item",% "MenHandlr"
(opTaskbarItem? icon:= ico_tick : icon:= ico_cross)
menu,Tray,icon,% "taskbar item",% icon,,32
menu,Tray,Add,% "tray icon",% "MenHandlr"
menu,Tray,Icon,% "tray icon",% icon:= ico_tick,,32
menu,Tray,Add,% "mount-2-desktop(Trans)",%	"MenHandlr"
menu,Tray,icon,% "mount-2-desktop(Trans)",%	"D:\Documents\My Pictures\- Icons\256\Ice (2).ico",,32
menu,Tray,Add,% "mount-2-desktop(FrostGlass)",%	"MenHandlr"
menu,Tray,Icon,% "mount-2-desktop(FrostGlass)",%	"D:\Documents\My Pictures\- Icons\256\Desktop (10).ico",,32
menu,Tray,Add,% "mount-2-desktop(AeroG)",%	"MenHandlr"
menu,Tray,Icon,% "mount-2-desktop(AeroG)",%	"D:\Documents\My Pictures\- Icons\256\Ice.ico",,32
menu,Tray,Add,% "mount-2-desktop(Opaque)",%	"MenHandlr"
menu,Tray,Icon,% "mount-2-desktop(Opaque)",% "D:\Documents\My Pictures\- Icons\256\Fire (3).ico",,32
menu,Tray,Add,% "Open Vars",% "MenHandlr"
menu,Tray,Icon,% "Open Vars",% "D:\Documents\My Pictures\- Icons\256\Abacus (3).ico",,32
menu,Tray,Add,% "Open Containing",%	 "MenHandlr"
menu,Tray,Icon,% "Open Containing",% "C:\Icon\24\explorer24.ico",,32
menu,Tray,Add,% "Edit",% "MenHandlr"
menu,Tray,Icon,% "Edit",% "C:\Icon\24\explorer24.ico",,32
menu,Tray,Add,% "r3load",% "MenHandlr"
menu,Tray,Icon,% "r3load",% "C:\Icon\24\eaa.bmp",,32
menu,Tray,Add,% "Suspend",% "MenHandlr"
menu,Tray,Icon,% "Suspend",% "C:\Icon\24\head_fk_a_24_c1.ico",,32
menu,Tray,Add,% "Pause",% "MenHandlr"
menu,Tray,Icon,% "Pause",% "C:\Icon\24\head_fk_a_24_c2b.ico",,32
menu,Tray,Add,% "Exit",% "MenHandlr"
menu,Tray,Icon,% "Exit",% "C:\Icon\24\head_fk_a_24_c2b.ico",,32
menu,Tray,Tip,% splitpath(A_scriptFullPath).fn "`nRunning, Started @`n" a_scriptStartTime
do_nothing:
return,

Varz:
global opAlwaysOnTop, topmost, opTaskbarItem, tbitem, TBeXtyle, ico_tick, ico_cross, hchk1, hchk2, htabszupdn, htabszupdntxt, hcheckdlg
, deskY, Scriptnew, scriptraw, textnew, ayboi, TBhWnd, DTopDocked, aHkeXe, fil3:= a_scriptname, controlsmaxi
, evhWnd, ldr_hWnd, HTB, TabSelected, Pipes, vcount, icon_array, ppidd, SYSGUI_TBbUTTSZ, g_dlgframe, hcheckdlg
, PtrP,Ptr, colour1:= 0xEE0000, KeyNames:= "Lctrl,", BandIncr:= 0, match, r_pid, initpal, ChangeToIcon, CurChanged
, ico_tick:="C:\Icon\256\ticAMIGA.ico", ico_cross:="C:\Icon\256\Oxygeclose.ico"
, _:= "C:\Program Files\Autohotkey\AutoHotkey", File, Titlemain, h3270, deskX, PaintLexForce, bbounce, bb
, EDIT:= 65304, open:= 65407, Suspend:= 65305, PAUSE:= 65306, exit:= 6530, gradwnd, hgui, HANDLES_ALLCTL, controls:=[]
, TBeXtyle:= 0x40110, InitH, IcoDir, ldr_hWnd, char_size, r_Wpos, colz, Palactive, palmovtrig, hil2, hil3, hil4
, linesonscreen, firstvisibleline, ico_hBmp
loop,8
	global (b_%a_index%hWnd):= "" 
loop,4
	global (drop%a_index%)
global _needl:= "[ \t]*(?!(if\(|while\(|for\())([\w#!^+&<>*~$])+\d*(\([^)]*\)|\[[^]]*\])([\s]|(/\*.*?\*)/|((?<=[\s]);[^\r\n]*?$))*?[\s]*\{|^[ \t]*(?!(if\(|while\(|for\())([\w#!^+&<>*~$])+\d*:(?=([\s]*[\r\n]|[\s]+;.*[\r\n]))|^[ \t]*(?!(;|if\(|while\(|for\())([^\r\n\t])+\d*(?&lt;![\s])"
,Dix,
global SelCol_Butt
,Colors := {"Red": ["FF9999","FF6666","FF3333","FF0000","D90000","B20000","8C0000","660000","400000"], "Flame": ["FFB299","FF8C66","FF6633","FF4000","D93600","B22D00","8C2300","661A00","401000"], "Orange": ["FFCC99","FFB266","FF9933","FF8000","D96C00","B25900","8C4600","663300","402000"], "Amber": ["FFE599","FFD966","FFCC33","FFBF00","D9A300","B28600","8C6900","664D00","403000"], "Yellow": ["FFFF99","FFFF66","FFFF33","FFFF00","D9D900","B2B200","8C8C00","666600","404000"], "Lime": ["E5FF99","D9FF66","CCFF33","BFFF00","A3D900","86B200","698C00","4D6600","304000"], "Chartreuse": ["CCFF99","B2FF66","99FF33","80FF00","6CD900","59B200","468C00","336600","204000"], "Green": ["99FF99","66FF66","33FF33","00FF00","00D900","00B200","008C00","006600","004000"], "Sea": ["99FFCC","66FFB2","33FF99","00FF80","00D96C","00B259","008C46","006633","004020"], "Turquoise": [ "99FFE5","66FFD9","33FFCC","00FFBF","00D9A3","00B286","008C69","00664D","004030"], "Cyan": ["99FFFF","66FFFF","33FFFF","00FFFF","00D9D9","00B2B2","008C8C","006666","004040"], "Sky": ["99E5FF","66D9FF","33CCFF","00BFFF","00A3D9","0086B2","00698C","004D66","003040"], "Azure": ["99CCFF","66B2FF","3399FF","0080FF","006CD9","0059B2","00468C","003366","002040"], "Blue": ["9999FF","6666FF","3333FF","0000FF","0000D9","0000B2","00008C","000066","000040"], "Han": ["B299FF","8C66FF","6633FF","4000FF","3600D9","2D00B2","23008C","1A0066","100040"], "Violet": ["CC99FF","B266FF","9933FF","8000FF","6C00D9","5900B2","46008C","330066","200040"], "Purple": ["E599FF","D966FF","CC33FF","BF00FF","A300D9","8600B2","69008C","4D0066","300040"], "Fuchsia": ["FF99FF","FF66FF","FF33FF","FF00FF","D900D9","B200B2","8C008C","660066","400040"], "Magenta": ["FF99E5","FF66D9","FF33CC","FF00BF","D900A3","B20086","8C0069","66004D","400030"], "Pink": ["FF99CC","FF66B2","FF3399","FF0080","D9006C","B20059","8C0046","660033","400020"], "Crimson": ["FF99B2","FF668C","FF3366","FF0040","D90036","B2002D","8C0023","66001A","400010"], "Gray": ["DEDEDE","BFBFBF","9E9E9E","808080","666666","4D4D4D","333333","1A1A1A","000000"], "Sepia": ["DED3C3","BFAB8F","9E8664","806640","665233","4D3D26","33291A","1A140D","000000"]}
,ColorList := ["Red","Flame","Orange","Amber","Yellow","Lime","Chartreuse","Green","Sea","Turquoise","Cyan","Sky","Azure","Blue","Han","Violet","Purple","Fuchsia","Magenta","Pink","Crimson","Gray","Sepia"]
,Flows:="Comments,Multiline,Directives,Punctuation,Numbers,Strings,Builtins,Flow,Commands,Functions,Keywords,Keynames,Functions2,Descriptions,Plain"
 	; Tab control Styles ;
(!PtrP? PtrP:= A_IsUnicode?	"UPtr*" : "UInt*")
 (!Ptr?	Ptr:=  A_IsUnicode?	"Ptr"	: "UInt")
  char_size:=  A_IsUnicode? 	  2 : 1
global TextBackgroundBrush:= dllcall("CreateSolidBrush","UInt"
,	TextBackgroundColor:= 0x060915)
,	Icon_Array:= [] ,	Icon_Array2:= [] ; Toolbar/Tab-icons ;
,	Pipes:= {} ; All (trouserless) pipes. :
(opAlwaysOnTop? topmost:=" +Alwaysontop ")
(opTaskbarItem? TBeXtyle |= 0x40000)
global gayinc:=0 , gay:=[], gay2:=[]
fag:="SCE_AHKL_IDENTIFIER,SCE_AHKL_COMMENTDOC,SCE_AHKL_COMMENTLINE,SCE_AHKL_COMMENTBLOCK,SCE_AHKL_COMMENTKEYWORD,SCE_AHKL_STRING,SCE_AHKL_STRINGOPTS,SCE_AHKL_STRINGBLOCK,SCE_AHKL_STRINGCOMMENT,SCE_AHKL_LABEL,SCE_AHKL_HOTKEY,SCE_AHKL_HOTSTRING,SCE_AHKL_HOTSTRINGOPT,SCE_AHKL_HEXNUMBER,SCE_AHKL_DECNUMBER,SCE_AHKL_VAR,SCE_AHKL_VARREF,SCE_AHKL_OBJECT,SCE_AHKL_USERFUNCTION,SCE_AHKL_DIRECTIVE,SCE_AHKL_COMMAND,SCE_AHKL_PARAM,SCE_AHKL_CONTROLFLOW,SCE_AHKL_BUILTINFUNCTION,SCE_AHKL_BUILTINVAR,SCE_AHKL_KEY,SCE_AHKL_USERDEFINED1,SCE_AHKL_USERDEFINED2,SCE_AHKL_ESCAPESEQ,SCE_AHKL_ERROR"
loop, parse,fag,`,
	gay.push(a_loopfield)
global lexables:=[], 
lexable:="SCE_AHKL_IDENTIFIER,SCE_AHKL_COMMENTDOC,SCE_AHKL_COMMENTLINE,SCE_AHKL_COMMENTBLOCK,SCE_AHKL_COMMENTKEYWORD,SCE_AHKL_STRING,SCE_AHKL_STRINGOPTS,SCE_AHKL_STRINGBLOCK,SCE_AHKL_STRINGCOMMENT,SCE_AHKL_LABEL,SCE_AHKL_HOTKEY,SCE_AHKL_HOTSTRING,SCE_AHKL_HOTSTRINGOPT,SCE_AHKL_HEXNUMBER,SCE_AHKL_DECNUMBER,SCE_AHKL_VAR,SCE_AHKL_VARREF,SCE_AHKL_OBJECT,SCE_AHKL_USERFUNCTION,SCE_AHKL_DIRECTIVE,SCE_AHKL_COMMAND,SCE_AHKL_PARAM,SCE_AHKL_CONTROLFLOW,SCE_AHKL_BUILTINFUNCTION,SCE_AHKL_BUILTINVAR,SCE_AHKL_KEY,SCE_AHKL_USERDEFINED1,SCE_AHKL_USERDEFINED2,SCE_AHKL_ESCAPESEQ,SCE_AHKL_ERROR"

;loop, parse,lexable,`,
;	lexables.push(a_loopfield)
b64i:= "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"
return,

b64_2_hBitmap(B64in,NewHandle:= False) {
	Static hBitmap:= 0
	(NewHandle? hBitmap:= 0)
	If(hBitmap)
		Return,hBitmap
	VarSetCapacity(B64,3864 <<!!A_IsUnicode)
	If(!DllCall("Crypt32.dll\CryptStringToBinary","Ptr",&B64in,"UInt",0,"UInt", 0x01,"Ptr",0,"UIntP",DecLen,"Ptr",0,"Ptr",0))
		Return,False
	VarSetCapacity(Dec,DecLen,0)
	If(!DllCall("Crypt32.dll\CryptStringToBinary","Ptr",&B64in,"UInt",0,"UInt",0x01,"Ptr",&Dec,"UIntP",DecLen,"Ptr",0,"Ptr",0))
		Return,False
	hData:= DllCall("Kernel32.dll\GlobalAlloc","UInt",2,"UPtr",DecLen,"UPtr"), pData:= DllCall("Kernel32.dll\GlobalLock","Ptr",hData,"UPtr")
	DllCall("Kernel32.dll\RtlMoveMemory","Ptr",pData,"Ptr",&Dec,"UPtr",DecLen), DllCall("Kernel32.dll\GlobalUnlock","Ptr",hData)
	DllCall("Ole32.dll\CreateStreamOnHGlobal","Ptr",hData,"Int",True,"PtrP",pStream)
	hGdip:= DllCall("Kernel32.dll\LoadLibrary","Str","Gdiplus.dll","UPtr"), VarSetCapacity(SI,16,0), NumPut(1,SI,0,"UChar")
	DllCall("Gdiplus.dll\GdiplusStartup","PtrP",pToken,"Ptr",&SI,"Ptr",0)
	, DllCall("Gdiplus.dll\GdipCreateBitmapFromStream","Ptr",pStream,"PtrP",pBitmap)
	, DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap","Ptr",pBitmap,"PtrP",hBitmap,"UInt",0)
	, DllCall("Gdiplus.dll\GdipDisposeImage","Ptr",pBitmap), DllCall("Gdiplus.dll\GdiplusShutdown","Ptr",pToken)
	DllCall("Kernel32.dll\FreeLibrary","Ptr",hGdip), DllCall(NumGet(NumGet(pStream +0,0,"UPtr") +(A_PtrSize *2),0,"UPtr"),"Ptr",pStream)
	Return,hBitmap
}

b64_2_hicon(B64in,NewHandle:= False) {
	Static hBitmap:= 0
	(NewHandle? hBitmap:= 0)
	If(hBitmap)
		Return,hBitmap
	VarSetCapacity(B64,3864 <<!!A_IsUnicode)
	If(!DllCall("Crypt32.dll\CryptStringToBinary","Ptr",&B64in,"UInt",0,"UInt", 0x01,"Ptr",0,"UIntP",DecLen,"Ptr",0,"Ptr",0))
		Return,False
	VarSetCapacity(Dec,DecLen,0)
	If(!DllCall("Crypt32.dll\CryptStringToBinary","Ptr",&B64in,"UInt",0,"UInt",0x01,"Ptr",&Dec,"UIntP",DecLen,"Ptr",0,"Ptr",0))
		Return,False
	hData:= DllCall("Kernel32.dll\GlobalAlloc","UInt",2,"UPtr",DecLen,"UPtr"), pData:= DllCall("Kernel32.dll\GlobalLock","Ptr",hData,"UPtr")
	DllCall("Kernel32.dll\RtlMoveMemory","Ptr",pData,"Ptr",&Dec,"UPtr",DecLen), DllCall("Kernel32.dll\GlobalUnlock","Ptr",hData)
	DllCall("Ole32.dll\CreateStreamOnHGlobal","Ptr",hData,"Int",True,"PtrP",pStream)
	hGdip:= DllCall("Kernel32.dll\LoadLibrary","Str","Gdiplus.dll","UPtr"), VarSetCapacity(SI,16,0), NumPut(1,SI,0,"UChar")
	DllCall("Gdiplus.dll\GdiplusStartup","PtrP",pToken,"Ptr",&SI,"Ptr",0)
	, DllCall("Gdiplus.dll\GdipCreateBitmapFromStream","Ptr",pStream,"PtrP",pBitmap)
	, DllCall("gdiplus\GdipCreateHICONFromBitmap", "UPtr", pBitmap, "UPtr*", hIcon)
	, DllCall("Gdiplus.dll\GdipDisposeImage","Ptr",pBitmap), DllCall("Gdiplus.dll\GdiplusShutdown","Ptr",pToken)
	DllCall("Kernel32.dll\FreeLibrary","Ptr",hGdip), DllCall(NumGet(NumGet(pStream +0,0,"UPtr") +(A_PtrSize *2),0,"UPtr"),"Ptr",pStream)
	Return,hIcon
}

CreateHICONFromBitmap(pBitmap) {
	hIcon := 0
	gdipLastError := DllCall("gdiplus\GdipCreateHICONFromBitmap","UPtr",pBitmap,"UPtr*",hIcon)
	return,byref hIcon
}

r3load() {
	reload,
	sleep,1000
	exitapp,
	r3load:
	reload,
	sleep,1000
	return,
}

Quit() {
	global
	OGdip.shutdown(), IDT_LV.RevokeDragDrop(), IDT_LV2.RevokeDragDrop()
	, IDT_LV3.RevokeDragDrop(), IL_Destroy(hIL2), IL_Destroy(hIL3)
	CurChanged? (DllCall("SystemParametersInfo","uInt",0x57,"uInt",0,"uInt",0,"uInt",0), CurChanged:= false)
	for,index in Pipes
	{
		nm:= (Pipes[index].name), pid:= (Pipes[index].hWnd)
		postMessage,0x0111,65307,,,% (nm " - AutoHotkey")
		sleep,100 ;EndTask(id,0,1);
	} exitapp,
	loop,3
		sleep,200
}

b64i:=
; WM_MOUSEMOVE(wParam,lParam,Msg,Hwnd) {
	; Global ; Assume-global mode ;Static Init:= OnMessage(0x0200,"WM_MOUSEMOVE") ;,init2:=0,TME
	; if(init2=0) {
		; VarSetCapacity(TME,16,0)
		; init2:=1
		; NumPut(16,TME,0)
		; NumPut(2,TME,4) ; TME_LEAVE
		; NumPut(hColorPalette,TME,8)
		; DllCall("User32.dll\TrackMouseEvent","UInt",&TME)
	; } MouseGetPos,,,,MouseCtl
	; GuiControlGet,ColorVal,,% MouseCtl
; }

; WM_MOUSELEAVE(wParam, lParam, Msg, Hwnd) {
	; Global ; Assume-global mode
	; Static Init:= OnMessage(0x02A3,"WM_MOUSELEAVE")
; }

; ~#f::
; bb:=func("buttbounce").bind(htb,17,250)
; if (bbounce:=!bbounce)
; settimer,% bb,1
; else bb:=""
; settimer,ButtBounce,off
; return,

; redraw() { ;return
	; winset,redraw,,Ahk_id %ldr_hWnd%
	; winset,redraw,,Ahk_id %htab%
	; winset,redraw,,Ahk_id %hsci% ;sci.GrabFocus() 	;settimer test,-70
; }

;"TCS_RIGHTJUSTIFY,0x0,TCS_SINGLELINE,0x0,TCS_EX_FLATSEPARATORS,0x1,TCS_SCROLLOPPOSITE,0x1,TCS_RIGHT,0x2,TCS_BOTTOM,0x2,TCS_MULTISELECT,0x4,TCS_FLATBUTTONS,0x8,TCS_FORCEICONLEFT,0x10,TCS_FORCELABELLEFT,0x20,TCS_HOTTRACK,0x40,TCS_VERTICAL,0x80,TCS_BUTTONS,0x100,TCS_MULTILINE0x200,TCS_FIXEDWIDTH,0x400,TCS_RAGGEDRIGHT,0x800,TCS_FOCUSONBUTTONDOWN,0x1000,TCS_OWNERDRAWFIXED,0x2000,TCS_TOOLTIPS,0x4000,TCS_FOCUSNEVER,0x8000"
