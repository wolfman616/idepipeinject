;ListLines,Off
#NoEnv ; #IfTimeout,200 ;* DANGER * : Performance impact if set too low. *think about using this*.
#NoTrayIcon
#SingleInstance,Force
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
	}
	exitapp,
} else,menu,tray,icon
SciLexer:= A_ScriptDir . (A_PtrSize == 8 ? "\SciLexer64.dll" : "\SciLexer32.dll")
if(!LoadSciLexer(SciLexer)) {
	msgbox,0x10,%g_AppName% - Error
	, % "Failed to load library """ . SciLexer . """.`n`n"
	ifmsgbox,yes
	ExitApp,
}
Setworkingdir,% (aHkeXe:= splitpath(A_AhkPath)).dir
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
OGdip.Startup()
OnExit(ObjBindMethod(OGdip, "Shutdown"))
OGdip.autoGraphics := True
try,menu,tray,icon,% "C:\Icon\24\Gterminal_24_32.ico"
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
return,

INITARRAYS:
if(!SavedColours)
	gosub,initdCols
gosub,DixInit
return,

initdCols:
defColz:="", colm1:= 0xffc010,colm2:= 0xffc010, colz:= []
loop,16 ;Dix[a_index].push({"IDNum" :,"Colour" : ,"Font":,"Size":,"Italic":,"Bold":,"Underline":, })
	defColz.=((colz[ a_index ]:= (colm1:=col_mult(colm1,".95"))) . ",")
return,

DixInit:
Dix:= [{}]
dicks:="Comments,Multiline,Directives,Punctuation,Numbers,Strings,Builtins,Flow,Commands,Functions,Keywords,Keynames,Functions2,Descriptions,Plain"
loop,parse,% Dicks,`,
	Dix[a_index]:= ({ "IDNum" : a_index, "Title" : a_loopfield, "Colour" : colz[ a_index ]})
return,

Main:
TextBackgroundColor:= 0xffff00, opAlwaysOnTop:= False, topmost:= ""
Titlemain:= "-AHK-P|p3-",	IcoDir:= "C:\Script\AHK\res\icon"
StartX:= 1,	startY:= 615,	StartW:= 1044,	startH:= 438
	bW:= 155,	bH:= 33,	TabStyle:=0,	TC_W:= 1040
	scriptraw:="C:\Script\AHK\- _ _ LiB\class_DragDrop.ahk"
;=-------=====-==========----------=====-==========----------=====-==========----------=====-==========---

gui,Cut0r:New,-dpiscale 0x568F0000 e0x2080008 ;+ Create G
gui,Cut0r:+owner +MinSize1106x640 +lastfound +e%TBeXtyle% +resize +hWndldr_hWnd 
gui,grad:new, +hwndgradwnd -dpiscale
IconInit(), TabViewInit()
buttons_1(), buttons_2()
comboinit()
tickboxinit()
ToolBarInit()
StatusBarInit()

EditViewInit()

winset,ExStyle,+0x18,ahk_id %ldr_hWnd%
gui,Cut0r:show,hide Center w%init_W% h%init_H%  ,% Titlemain ;-- Show it
Win_Animate(ldr_hWnd,"slide hneg activate",900) ;gui,Cut0r:show,na ;show_upd8()
Aero_BlurWindow(ldr_hWnd)
(opMount2DTop? Win2DTopTrans(ldr_hWnd,(deskX:= (guipos:= wingetpos(ldr_hWnd)).x),(desky:= guipos.y)))
IDT_LV2:= IDropTarget_Create(hTab,"_LV", 1) ; no format required - for testing. 
win_move(evhWnd,700,"","","","") ;DllCall("SetWindowBand","ptr",hgui,"ptr",0,"uint",4)
; hg:=custOverlay()
	;RE11:= DllCall("SetParent","uint",gradwnd,"uint",hGui)
;msgbox % gradwnd " gw " hGui " hg "
; winset,Style,-0x00440000,ahk_id %ldr_hWnd%
	; LdrPos:= wingetpos(ldr_hWnd) 
	; SendMessage, 0x421,,,,ahk_id %hTB% 
	; Win_Move(ldr_hWnd,0,(a_screenheight-LdrPos.h)-10,LdrPos.w+45,LdrPos.h,"") ;CtlColors.Attach(evhWnd, "110223", "6633ff")
	; winset,Transparent, off,ahk_id %ldr_hWnd%
	; winset ExStyle,+0x30,ahk_id %hTab%
	; winget,uib,List,ahk_pid %rPiD% ;ahk_class #32770
	; loop,% uib {
		; wingetclass,ldrClass,ahk_id %ldr_hWnd%
		; if(ldrClass="AutoHotkeyGUI") {
			; ControlGet, h3270, hWnd ,, #327701, ahk_id %ldr_hWnd%
			; winset ExStyle,+0x20,ahk_id %h3270%
			; winset Style,-0x10000000,ahk_id %h3270%
	; }	} ;EnterSizeMove()
winget,uib,List,ahk_pid %rPiD% ;ahk_class #32770
	loop,% uib {
		wingetclass,ldrClass,ahk_id %ldr_hWnd%
		if(ldrClass="AutoHotkeyGUI") {
			ControlGet,h3270,hWnd,,#327701,ahk_id %ldr_hWnd%
			;winset,ExStyle,+0x20,ahk_id %h3270%
			winset,Style,-0x10000000,ahk_id %h3270%
}	}

IDT_LV:= IDropTarget_Create(hTab, "", -1) ; no format required - only for testing purposes
;-- DragDrop flags
	DRAGDROP_S_DROP  := 0x40100 ; 262400
	DRAGDROP_S_CANCEL:= 0x40101 ; 262401
;-- DROPEFFECT flags
	DROPEFFECT_NONE:= 0 ;-- Drop target cannot accept the data.
	DROPEFFECT_COPY:= 1 ;-- Drop results in a copy. The original data is untouched by the drag source.
	DROPEFFECT_MOVE:= 2 ;-- Drag source should remove the data.
	DROPEFFECT_LINK:= 4 ;-- Drag source should create a link to the original data.
;-- Key state values (grfKeyState parameter)
	MK_LBUTTON:= 0x01   ;-- The left mouse button is down.
	MK_RBUTTON:= 0x02   ;-- The right mouse button is down.
	MK_SHIFT  := 0x04   ;-- The SHIFT key is down.
	MK_CONTROL:= 0x08   ;-- The CTRL key is down.
	MK_MBUTTON:= 0x10   ;-- The middle mouse button is down.
	MK_ALT    := 0x20   ;-- The ALT key is down. 
;	MK_BUTTON:= ?    ;-- Not documented.
paletteinit()
fileRead,ScriptRaw,% ScriptRaw
SeTxT(ScriptRaw)
sleep,100
PaintLexForce:= True
settimer,PaintLexForceoff,-900
settimer,_Lex,-10
win_move(gradwnd,0,0,a_screenwidth,a_screenheight)
RE2:= DllCall("SetParent","uint",gradwnd,"uint",ldr_hWnd)
sleep,200
win_move(gradwnd,18,42,init_w+20,init_H)
winset,transparent,190,ahk_id %gradwnd%
winset,transparent,10,ahk_id %hipath%

winset,style,+0x4d000000 -0x80000000,aHk_id %gradwnd%
winset,style,+0x4d000000 -0x80000000,aHk_id %hipath%

winset,exstyle,+0x28,aHk_id %gradwnd%
winset,redraw,,aHk_id %gradwnd%
;DllCall("gdi32.dll\SetStretchBltMode","Uint",2DC_Frame,"int",1)
;	DllCall("gdi32.dll\StretchBlt","UInt",2DC_Frame,"Int",0,"Int",0,"Int"
;	, CURRENT_W,"Int",CURRENT_h,"UInt",HDC_Frame,"UInt",0 
;	, "UInt",0,"Int",0.5*CURRENT_W,"Int",CURRENT_h,"UInt",0x00CC0020) ; SRCCOPY=0x00CC0020 ;
settimer,onMsgz,-1000
wm_allow()
settimer,_Lex,-3000
sleep,3000 
gradinit()
gradupdate(sciinit_w-22,init_h-302)

return,

custOverlay() {
	global ; Desired image>> ;					>>;
	ImgFilePath:= "C:\Script\AHK\GDI\images\uu.png"
	gui,pwn: -Caption -DPIScale -SysMenu +alwaysontop  +toolwindow	+0x8000000	+E0x080008 +hWndhGui +parentCut0r
	gui,pic_:-Caption -SysMenu +alwaysontop +parentpwn +HwndthWnd	;+E0x080008
	imghWnd:= 1mgdr4w(ImgFilePath,80,0,-16,-10)	;msgbox % hGui 
	;msgbox % hgui "hgui"
	return,byref hGui
}

gradinit() {
	global
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
	win_move(gradwnd,0,0,a_screenwidth,a_screenheight,1)
	;win_move(hipath ,20,20,a_screenwidth,a_screenheight,1)
	winset,transparent,33,ahk_id %gradwnd% ; win_move(gradwnd,1280,300,1200,500)
	gui,grad:show, w%a_screenwidth% h%a_screenheight% center ;msgbox % h "£ " w "`n" init_w " " init_h
	winSet,Region,1-0 w%a_screenwidth% h%a_screenheight% R20-20,ahk_id %gradwnd%
	gradupdate(a_screenwidth,a_screenheight) ;ControlGet,staticwnd,Hwnd,, static1, ahk_id %gradwnd%
	;winSet,Region,1-0 w%a_screenwidth% h%a_screenheight% R20-20,ahk_id %hipath% ;msgbox	RE2:= DllCall("SetParent","uint",hipath,"uint",ldr_hwnd)
	;win_move(gradwnd,0,0,a_screenwidth,a_screenheight,1)
}

pToken:= OGdip.Startup()
;winset, transparent, 20 ;+E0x80000
;gui,BackMain: 	hide
	mdc:= DllCall("GetDC","UInt",gradwnd)
glob_DC:= 	DllCall("GetDC","UInt",0 )
main_DC:= 	DllCall("GetDC","UInt",MainhWnd)
DllCall("gdi32.dll\SetStretchBltMode","Uptr",main_DC,"UInt",3)
DllCall("gdi32.dll\SetStretchBltMode","Uptr",SysLv_DC,"UInt",3)
	DllCall("gdi32.dll\SetStretchBltMode","Uptr",mdc,"UInt",3)
;gui,pic: show, x0 y0 w%a_screenwidth% h%a_screenheight% 	;	winset,transcolor,0f00f0
;	winset transparent,80,ahk_id %hpic%
;Win_Move(hpic, 200, 1,800, 800  ,"" ) ; SWP_NOZORDER + SWP_NOACTIVATE
return,

gradupdate(w,h) {
	global
	pathEllipse := new OGdip.Path()
	pathEllipse.AddEllipse(0,0,w,h)
	pathSquare  := new OGdip.Path()
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
	winSet,Region,1-1 w%w% h%h% R20-20,ahk_id %hipath% ;msgbox	RE2:= DllCall("SetParent","uint",hipath,"uint",ldr_hwnd)
	win_move(gradwnd,sciinit_x+20,sciinit_y,w,h,1)
	winSet,Region,1-1 w%w% h%h% R20-20,ahk_id %hipath% ;msgbox	RE2:= DllCall("SetParent","uint",hipath,"uint",ldr_hwnd)
	return,
	anus:=Gdip_GraphicsFromHWNDii(hipath)
	; cunt:=CreateHBITMAPFromBitmap(anus)
		; 2DC_Frame:= DllCall("GetDC","UInt",gradwnd)
	; HDC_Frame:= DllCall("GetDC","UInt",hgui)
	; sleep,100
	; p:= wingetPos(ldr_hwnd)
	; DllCall("UpdateLayeredWindow","UInt",HDC_Frame,"UInt",0,"UInt",0,"Int64P",p.w|p.h<<32
	; ,	"UInt",2DC_Frame,"Int64P",0,"UInt",0,"IntP",0xFF<<16|1<<24,"UInt",2)
	; DllCall("UpdateLayeredWindow","Uint",hgui,"Uint",0,"Uint",0,"int64P",CURRENT_W|CURRENT_H<<32
	; ,"Uint",mDC,"int64P",0,"Uint",0,"intP",0xFF<<16|1<<24,"Uint",2)
	
}

CreateHBITMAPFromBitmap(pBitmap, Background:=0x00000000) {
; background should be zero, to not alter alpha channel of the image
	hBitmap := 0
	If !pBitmap
	{
		gdipLastError := 2
		Return
	}

	gdipLastError := DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "UPtr", pBitmap, "UPtr*", hBitmap, "int", 0)
	return hBitmap
}

paletteinit(){
	global
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
	loop,parse,% dicks,`,
	{
		gui,Add,Radio,% "+hwndb" a_index " cBlack y" (-20+20 * a_index) " x128 v" a_loopfield " gpalbutthandla",% a_loopfield
		nog:= bgrRGB(nog:= substr(dix[a_index].colour,3,6))
		gui,APCBackMain: Font,c%nog%
		Guicontrol,font,% a_loopfield
		global (%a_loopfield%), ("b" , a_index)
	}
}

palactivate:
if(Palactive)
	return,
LPos:= wingetPos(ldr_hWnd)
gui,APCBackMain:Show,% " hide x" (LPos.x+LPos.W) " y" (LPos.y+(78)),Palette
gui,APCBackMain:+lastfound +alwaysontop
(opaeroglass?Aero_BlurWindow(hpal))
winset,ExStyle,+0x08000000,ahk_id %hpal%
winset,transparent,240,ahk_id %hpal%
gui,APCBackMain:-SysMenu -Caption
palactive:= True
Win_Animate(hpal,"slide hpos", 210)
if(!opAlwaysOnTop)
	gui,APCBackMain:-alwaysontop ;gui,APCBackMain:show ,x1536 y430 NoActivate, % "LedPal"
winset,transparent,247,ahk_id %hpal%
return,

palahide:
if(!palactive)
	return,
gui,APCBackMain:+lastfound +alwaysontop
winset,transcolor,000000,ahk_id %hpal%
palactive:= False
Win_Animate(hpal,"hide slide hneg", 150)
winset,transparent,off,ahk_id %$%
return,

paltopp4:
if(palactive)
	if(!palmovtrig) {
		gui,APCBackMain:+lastfound 
		gui,APCBackMain:+alwaysonTop 
		if(!opAlwaysOnTop)
			gui,APCBackMain:-alwaysonTop 
		palmovtrig:= True ;winset,transparent,240,ahk_id %hpal%
	}
LPos:= wingetPos(ldr_hWnd)
win_move(hpal,LPos.x+LPos.W,LPos.y+(78),"","","")
return,


tickboxinit() {
	global cn1, cn2, hTab
	gui,Cut0r:Add,Radio,Checked x464 y8 vcn1 gcn1 +hWndcuntface1,% "Persist"
	gui,Cut0r:Add,Checkbox,Checked x555 y8 vcn2 gcn2 +hWndcuntface2,% "Dbg"
	RE2:= DllCall("SetParent","uint",cuntface1,"uint",hTab)
	RE2:= DllCall("SetParent","uint",cuntface2,"uint",hTab)
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
ttt("Launching " ahk_portable:= ((%A_ThisLabel%).pkg),"tray",1)
pipe(A_ThisLabeL)
return,

EnterSizeMove(wParam="") {
	global
	ControlGetPos,,,W,,,ahk_id %TBhWnd% ;SetWindowPos(bcnt.X,bcnt.Y,bcnt.W,bcnt.H,0,0x4014) ;SWP_NOACTIVATE|SWP_NOZORDER
	r_Wpos:= wingetpos(ldr_hWnd)	;ttt(r_Wpos.w "`n" r_Wpos.h)
	if( r_Wpos.w ) {
		r_Wpos.w < 1118? r_Wpos.w:= 1018 : r_Wpos.w:= r_Wpos.w -14
		r_Wpos.h < 586? r_Wpos.h:= 586  : r_Wpos.h:= r_Wpos.h -49
	guiControl,Move,% hTab,% "x18 y" 0 " w" r_Wpos.w ;win_move(r_Wpos.x+10,r_Wpos.y,w-48,"","")
			settimer,TBRePos,-2
	; settimer,show_upd8,-1000 ; TBRePos()
		loop,5
			;aa:= "b" . a_index . "hWnd" ;win_move(aa,r_Wpos.h-212,"","","")
			GuiControl,move,% (run%a_index%).hWnd,% "y" r_Wpos.h-187 
		loop,parse,% "vAdd,ModifyName,tab_icon_set,TabDelete,TabDeleteAll,buttoncancel,r3load",`,
			GuiControl,move,%a_loopfield%,% "y" r_Wpos.h-212
		sleep,40
	}
	if(!palactive) {
		gui,APCBackMain:hide
		gui,APCBackMain:show,% "hide x" (r_Wpos.x+r_Wpos.W) " y" (r_Wpos.y+(78)),
	} else,win_move(hpal,r_Wpos.x+r_Wpos.W+12,r_Wpos.y+(78),"","","")
	;settimer,TabUpdate,-10	; win_move(ldr_hWnd,r_Wpos.x,r_Wpos.y,r_Wpos.w+10,r_Wpos.h,"") ;
	return,
}

TBRePos() {
	global
	;ControlGetPos,,,W,H,,ahk_id %TBhWnd% ; SetWindowPos(bcnt.X,bcnt.Y , bcnt.W , bcnt.H,0, 0x4014); SWP_NOACTIVATE | SWP_NOZORDER
	wingetPos,,,W,H,ahk_id %ldr_hWnd% ; SetWindowPos(bcnt.X,bcnt.Y , bcnt.W , bcnt.H,0, 0x4014);SWP_NOACTIVATE | SWP_NOZORDER ;win_move(hsci,4,44,w-38,r_Wpos.h -300,1)
	SendMessage,0x421,,,,ahk_id %hTB% ; TB_AUTOSIZE
	;TabUpdate()
		;guiControl,Move,% hTab,% "x18 y" 1 " w" w-12 ;win_move(r_Wpos.x+10,r_Wpos.y,w-48,"","")
	;win_move(hTab,x+1,0,w-44,"","") ; winset,Transparent,50,ahk_id %hTab%
	;win_move(EVhWnd,4,"",270,"","")
	;winset,Style,-0x1,ahk_id %hTB% ;!ccs_TOP not req here
	(DTopDocked? win_move(htb,1,h-96,"","","")
	: win_move(htb,9,h-140,"",70,""))
	;msgbox % w "`n" h
	;winset,Redraw,,ahk_id %hTab%
		win_move(hsci,x+6,42,r_Wpos.w-40,r_Wpos.h -249,"") ; ,win_move(htb,x+10,r_Wpos.h-141,w,"","")
SendMessage,0x454,0,0x90,,ahk_id %hTB% ;only dblbuff

	return,0
}

TabUpdate() {
	global
	loop,4 {
		ControlGet,h3270%a_index%,hWnd,,#32770%a_index%,ahk_id %hTab%
		if(!h3270%a_index%)
			ControlGet,h3270%a_index%,hWnd,,#32770,ahk_id %hTab%
		winset,ExStyle,+0x20,% "ahk_id " h3270%a_index%
		winset,Style,-0x10000000,% "ahk_id " h3270%a_index%
	}
	sleep,100
	TabSelected:= TAB_GetCurSel(hTab), SBText:= ""
	.	"There are " . TAB_GetItemCount(hTab) . " tabs. "
	.	(TabSelected? "Tab " . TabSelected . " (""" . TAB_GetText(hTab,TabSelected) . """) is selected.":"No tab is selected.")
		ControlGet,h3270,hWnd,,#32770%TabSelected%,ahk_id %hTab%
	if(!h3270)
		ControlGet,h3270,hWnd,,#32770,ahk_id %hTab%
	winset,ExStyle,+0x20,ahk_id %h3270%
	winset,Style,-0x10000000,ahk_id %h3270%
	SB_Settext(SBText,1)
	;win_move(hTab,x+10,0,w-48,400,"")	;winset,Transparent,50,ahk_id %hTab% ;win_move(hsci,x+6,42,1066,r_Wpos.h -249,win_move(htb,x+10,r_Wpos.h-141,w,"","")
	;win_move(hTab,10,0,w-48,400,"")	;winset,Transparent,50,ahk_id %hTab% ;win_move(hsci,x+6,42,1066,r_Wpos.h -249,win_move(htb,x+10,r_Wpos.h-141,w,"","")
	winget,uib,List,ahk_pid %rPiD% ; ahk_class #32770 ;
	loop,% uib {
		wingetclass,ldrClass,ahk_id %ldr_hWnd%
		if(ldrClass="AutoHotkeyGUI") {
			ControlGet,h3270,hWnd,,#327701,ahk_id %ldr_hWnd%
			winset,ExStyle,+0x20,ahk_id %h3270%
			winset,Style,-0x10000000,ahk_id %h3270%
}	}	}

gettext() {
	global (%obj%) ;sendmessage,;for,i,v in (%obj%);msgbox,%i"`n" v
	return,byref (%obj%).getlength(txt,txtt) ;bum:= (%obj%).txt ;msgbox,% txtt " txt " txt
}

tabviewinit() {
	global
	gui,Cut0r:Add,Tab3,xm w%TC_W% y0 h%startH% -Wrap %TabStyle% hWndhTab gTabSelected vMyTab
	winset,ExStyle,&e0x2000000,ahk_id %hTab% 	; composited
	TAB_SetImageList(hTab,hIL1)
	TAB_GetPos(hTab,MyTabPosX,MyTabPosY,MyTabPosW,MyTabPosH) ;-- Get the position of the tab control and the display area
	TAB_GetDisplayArea(hTab,DisplayAreaX,DisplayAreaY,DisplayAreaW,DisplayAreaH)
	EditY:= DisplayAreaY -6
	TAB_DeleteAllItems(hTab) 					;-- Delete the dummy tab
	 by:= (360 +(bH:= 34) +(margY:= 40))
	for,i,f in tabicons_init 					;-- Add the tabs and assign an icon
		TAB_InsertItem(hTab,i,f,i) 				;-- End of tabs
}

comboinit(){
	global
	gui,Cut0r:Add,DropDownList,vCombo1 x626 y4 w110 +hWnddrop1,x64 || x86 |
	gui,Cut0r:Add,DropDownList,vCombo2 x749 y4 w110 +hWnddrop2,UNICODE ||ANSI |'UiA'
	gui,Cut0r:Add,DropDownList,vCombo3 x873 y4 w100 +hWnddrop3,UiA || Unsigned
	gui,Cut0r:Add,DropDownList,vCombo4 x988 y4 w103 +hWnddrop4,UTF-8 || UTF-16 | ANSI
	loop,4
		RE2:= DllCall("SetParent","uint",drop%a_index%,"uint",hTab)
}

statusbarinit() {
	global ;gui,Add,StatusBar,y700 +0x100, sb 1 ;-- Status bar			;-- Misc.
	static inc:= round(1118*0.25)
	gui,Cut0r:Add,StatusBar,+hWndSbarhWnd +0x100
	SB_SetParts(inc,inc,inc,inc)
	SB_Settext(SBText,4)
}


buttons_1() {
	global
	by +=83
	gui,Cut0r:Tab
	gui,Cut0r:-dpiscale
	gui,Cut0r:Add,Button,y%by% xm+10 gpip3exec vpip3exec +hWndb1hWnd,%A_Space%Add%A_Space%
	gui,Cut0r:Add,Button,y%by% x+8 gAdd vAdd +hWndb2hWnd,%A_Space%Add%A_Space%
	gui,Cut0r:Add,Button,y%by% x+8 gModifyName vModifyName +hWndb3hWnd,Modify Name
	gui,Cut0r:Add,Button,y%by% x+8 gtab_icon_set vtab_icon_set +hWndb4hWnd,Modify Icon
	gui,Cut0r:Add,Button,y%by% x+8 gtabDelete vtabDelete +hWndb5hWnd,	Delete
	gui,Cut0r:Add,Button,y%by% x+8 gtabDeleteAll vtabDeleteAll +hWndb6hWnd, Delete All
	gui,Cut0r:Add,Button,y%by% x+8 gbuttoncancel vbuttoncancel +hWndb7hWnd w70 yp,% "&Cancel"
	gui,Cut0r:Add,Button,y%by% x+8 gr3load vr3load +hWndb8hWnd,	%A_Space%r3load...%A_Space%
	by +=62
}

buttons_2() {
	global
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
			case   "1":global (Run%a_index%:= {}, Run%a_index%
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
		}
	GuiControl,text,% (run%a_index%).hWnd,% (run%a_index%).btn ;msgbox % "ahk_id " (run%a_index%).hWnd "`n" (run%a_index%).btn
	}
	bY-=18
}

TB_Handla(lParam,wParam) {
	ttt("dfgfdggfg" lParam " " wParam)
	if A_GuiControlEvent&&(A_GuiControlEvent!="N")
		msgb0x(A_GuiControlEvent)
}

ToolbarInit() {
	global ;TBStyle_TOOLTIPS:=0x100|TBStyle_LIST:=0x1000 ;Txt-@-side-of-buttons
	((!SYSGUI_TBbUTTSZ)? SYSGUI_TBbUTTSZ:= 64)
	gui,Cut0r:Add,Custom,w1 x1 y%by% ClassToolbarWindow32  +hWndTBhWnd +0x110 
	ControlGet,hTB,hWnd,,ToolbarWindow321,ahk_id %ldr_hWnd%
	SendMessage,0x43C,0,0,,ahk_id %hTB%	;TB_SETMAXTEXTROWS ;text omitted from buttons; ;note: if more than one button has the same idCommand, then only the last button with that idCommand will have make the call.
	SendMessage,0x430,0,% hIL2,,ahk_id %hTB% ;TB_SETIMAGELIST:=0x430 ;TB_ADDBUTTONSA:= 0x414
	vMsg:= A_IsUnicode? 0x444 : 0x414
	SendMessage,% vMsg,% vCount,% &TBBUTTON,,% "ahk_id " hTB ;TB_ADDBUTTONSW|TB_ADDBUTTONSA|TB_ADDBUTTONSW:= 0x444
	Toolbar_SetButtSize(hTB,SYSGUI_TBbUTTSZ,SYSGUI_TBbUTTSZ)
	winset,Style,-0x1,ahk_id %hTB%
	SendMessage,0x454,0,0x90,,ahk_id %hTB% ;truncate partial-butts && dblbuffd
	SendMessage,0x421,,,,ahk_id %hTB%
}

Toolbar_SetButtSize(hCtrl,W,H="") {
	static TB_SETBUTTONSIZE=0x41F
	IfEqual,H,,SetEnv,H,% W
	SendMessage,TB_SETBUTTONSIZE,,(H<<16)|W,,ahk_id %hCtrl%
	SendMessage,0x421,,,,ahk_id %hCtrl%	;autosize
}

WM_COMMAND(wParam,lParam,uMsg,hWnd){
return
	global buttpressnum
	DetectHiddenWindows, On
	WinGetClass, vWinClass, % "ahk_id " lParam
	;ttt("dfgfg" vWinClass)
	if(vWinClass = "ToolbarWindow32") {
		if(uMsg=273) 
			buttpresshandla(buttpressnum:= wParam +1)
	return,
	}
}

buttpresshandla(butt) {
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
		if(!palactive) {
			settimer,palactivate,-1
			return,
		}
		else,if(palactive) {
			settimer,palahide,-1
			return,
		}
		case "18":
		case "19":
	}
}

show_upd8() {
	global
	TabUpdate()	;other_updating: ; msgbox % MyTabPosH "`n" TC_W-5
	TBRePos()	;winset,Redraw,,ahk_id %ldr_hWnd%
}

EditViewInit() {
	global ;
	gui,Add,Edit,vScriptRaw +0x6000000 +hWndevhWnd +E0x8 ;+E0x00200008; ,% "MsgBox `%A_now`%" TC_W-8 ;TCS_FIXEDWIDTH|TCS_TOOLTIPS;
	sci:= new scintilla(ldr_hWnd)
	hsci:= sci.hwnd
	sci.SetCodePage(65001) ; UTF-8 ;
	sci.SetWrapMode(True) ; Set default-font ;Style_DEFAULT:= 32
	setlexerStyle()
	;ControlGet,hsci,hWnd,,scintilla1,ahk_id %evhWnd%
	winset,ExStyle,+0x30,ahk_id %hsci%
	RE2:= DllCall("SetParent","uint",hsci,"uint",hTab) ; edit-frame.edge-light remove
	win_move(hsci,sciinit_x:=3,sciinit_y:=38,sciinit_w:=1064,sciinit_h:=r_Wpos.h -249,"")
	winset,ExStyle,+0x20,ahk_id %hTab% ; edit-frame.edge-light remove '
	;	gui,Cut0r:Add,Custom,ClassScintilla vScriptRaw +hWndEVhWnd x4 y1 w1010 h258 +0x50010000 ; +wanttab +0x6000000
	;	winset,ExStyle,+0x00080010,ahk_id %evhWnd% ;edit-frame.edge-light remove;
}

ButtonCancel:
return,

GUIClose:
GUIEscape:
gui,Cut0r:Destroy
ExitApp,

Add: ; Remove! ;
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

; gui,Cut0r:+OwnDialogs
; InputBox,TabName,Label,New label:,,,,,,,,% TAB_GetText(hTab,iTab)
; if(ErrorLevel)
; return,
	
; TAB_Settext(hTab,iTab,TabName)
; , TabUpdate()
; return,

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

#h::
	h:=init_H-300
	w:=init_w-20l ; win_move(gradwnd,16,20,w,h,2)
winset redraw,,ahk_id %gradwnd%
return,

#F::
ttt(TBRePos())
return,

#y::
RE2:= DllCall("SetParent","uint",gradwnd,"uint",ldr_hwnd)
RE2:= DllCall("SetParent","uint",gradwnd,"uint",ldr_hwnd)
return,

^w::
;bcnt:= wingetpos(TBhWnd)
ControlGetPos,X,Y,W,H,,ahk_id %TBhWnd% ;SetWindowPos(bcnt.X,bcnt.Y,bcnt.W,bcnt.H,0,0x4014) ;SWP_NOACTIVATE|SWP_NOZORDER
;win_move(ldr_hWnd,aCunt.x+2,aCunt.y-2,aCunt.w-1,aCunt.h+1) ;SWP_NOACTIVATE|SWP_NOZORDER ;SetWindowPos(TBhWnd,x-1000,y-100,w+100, h+41,0,0x4014) ;SWP_NOACTIVATE|SWP_NOZORDER
win_move(htb,4,r_Wpos.h-98,w,w,"")
return,

!^w::
SetWindowPos(TBhWnd,1,1,1120,30,0,0x4014) ; SWP_NOACTIVATE|SWP_NOZORDER ;
return,

DllCall("SetWindowBand","ptr",hgui,"ptr",0,"uint",BandIncr++)
ttt(BandIncr)
return,


^H::
ttt(r:= SCI.sETUSETABS("",1))
sci.SCI_SETTABWIDTH("",1)
return,

#z:: ;testing injection to gain access to the scripts threads
code =
(LTrim
	msgb0x(SYSGUI_TBbUTTSZ,"is father")
)
dllFile:= FileExist("C:\Program Files\Autohotkey\Lib\AutoHotkey.dll") ? "C:\Program Files\Autohotkey\Lib\AutoHotkey.dll"
		:  (A_PtrSize = 8)? "C:\Program Files\Autohotkey\Lib\AutoHotkey.dll"
		:	"C:\Program Files\Autohotkey\LiB\minhook\x32\x32\AutoHotkey.dll"
rThread:= InjectAhkDll(ppidd, dllFile, "") ;rThread.Exec(code)
return,

;*******************; loop(n="",cmd=""){
;*                 *; global
;*    Functions    *; loop,% n,
;*                 *; {
;*******************; % (%cmd%)

SCI_NOTIFY(a="",b="",c="",d=""){ ;if(c!=78)
	if(a!=49374) ;not yet understood.;
	msgbox,% "notify a:" a "`nb:" b  "`nc:" c  "`nd:" d  
}

OnMsgz() {
	global
	OnExit("quit")
	OnMessage(0x0100,"WM_KEYDN")
	OnMessage(0x0101,"WM_KEYUP")
	;loop,parse,% "0x007C,0x007D,0x31E,0x31F,0x320,0x15",`.
		;OnMessage(a_loopfield,"TBRePos")	; 0x007D WM_StyleCHANGED ; attempt to handle events which require a wm_paint post, Style changing unable to find see below
	;OnMessage(0x007D,"TBRePos")				; 0x007D WM_StyleCHANGED deosnt proc when change Styles?
	;OnMessage(0x031E,"TBRePos")				; 0x007C WM_StyleCHANGing
	OnMessage(0x004A,"Receive_WM_COPYDATA")	; WM_DWMNCRENDERINGCHANGED:= 0x31F
	OnMessage(0x0404,"AHK_NOTIFYICON")		; WM_DWMCOLORIZATIONCOLORCHANGED:= 0x320
	OnMessage(0x0233,"GuiDropFiles")		; WM_DWMCOMPOSITIONCHANGED:= 0x31E
	onmessage(0x047,"moved")
	OnMessage(0x231, "wm_movest")
	OnMessage(0x0232,"wm_moveend")
	OnMessage(0x0111,"WM_COMMAND")
	;OnMessage(0x0231,"EnterSizeMove")
	OnMessage(0x0005,"EnterSizeMove")
	OnMessage(0x0003,"wm_move")
	OnMessage(0x0006,"wm_activate")
	return
	OnMessage(2170,"cunt")
}

wm_activate(){
	gui,APCBackMain:+lastfound +alwaysontop
	if(!opAlwaysOnTop)
	gui,APCBackMain:-alwaysontop
	return,
}

WM_LBUTTONDOWN(wParam, lParam, Msg, Hwnd) {
	Global
	Static Init:= OnMessage(0x0201,"WM_LBUTTONDOWN")
		MouseGetPos,,,,MouseCtl
	ttt(MouseCtl)
	GuiControlGet,ColorVal,,% MouseCtl
	
	if(!instr(MouseCtl,"static") || (!RegExMatch(ColorVal,"#(.*)", ClipColor))
	||(!(SelCol_Butt))) ; filter *.* except the color-grid
		return,
	vfg:= strreplace(SelCol_Butt,"butt")
	, (%vfg%):= bgr:= "0x" substr(ClipColor1,5,2) . substr(ClipColor1,3,2) . substr(ClipColor1,1,2)
	loop,parse,% dicks,`,
	{
		if(a_loopfield=vfg) {
			vfg:=%vfg%, dix[a_index].colour:= vfg
			, nog:= bgrrgb(nog:= strreplace(vfg, "0x"),False)
			gui,APCBackMain: Font,c%nog%
			Guicontrol,font,% a_loopfield
			break,
	}	}
	ttt("set colour " dix[a_index].colour " to " vfg)	
	PaintLexForce:= True
	;settimer,PaintLexForceoff,-900
	settimer,_Lex,-19 ;msgbox,% dix[a_index].colour " sdfsf " dix[a_index].title 
	return,
}

WM_MOUSEMOVE(wParam, lParam, Msg, Hwnd) {
	Global ; Assume-global mode
return
	;Static Init:= OnMessage(0x0200,"WM_MOUSEMOVE")
	;,init2:=0,TME
	if(init2=0) {
		VarSetCapacity(TME,16,0)
		init2:=1
		NumPut(16,TME,0)
		NumPut(2,TME,4) ; TME_LEAVE
		NumPut(hColorPalette,TME,8)
		DllCall("User32.dll\TrackMouseEvent","UInt",&TME)
	}
	MouseGetPos,,,,MouseCtl
	ttt(MouseCtl)
	GuiControlGet,ColorVal,,% MouseCtl
}

WM_MOUSELEAVE(wParam, lParam, Msg, Hwnd) {
	Global ; Assume-global mode
	Static Init := OnMessage(0x02A3, "WM_MOUSELEAVE")
}

WM_lrBUTTONDOWN(wParam,lParam,byref RECT,mDC) {
	global lbutton_cooldown, lbd, STrigga:= True
	xs:= lParam &0xffff,	ys:= lParam>>16
	pToken00:= Gdip_Startup()
	   mDC00:= Gdi_CreateCompatibleDC(0)
	DllCall("gdi32.dll\SetStretchBltMode","Uint",mDC,"int",1)
	DllCall("gdi32.dll\StretchBlt","UInt",mDC00,"Int",0,"Int",0,"Int"
	, CURRENT_W,"Int",CURRENT_h,"UInt",mDC%oio%,"UInt",0 
	, "UInt",0,"Int",0.5*CURRENT_W,"Int",CURRENT_h,"UInt",0x00CC0020) ; SRCCOPY=0x00CC0020 ;
	DllCall("UpdateLayeredWindow","Uint",hgui,"Uint",0,"Uint",0,"int64P",CURRENT_W|CURRENT_H<<32
	, "Uint",mDC00,"int64P",0,"Uint",0,"intP",0xFF<<16|1<<24,"Uint",2)
	; settimer,lbutton_cooldown_reset,-400
	settimer,disgrace,-40
	While(LbD:= GetKeyState("lbutton","P")||lbd:= GetKeyState("lbutton","P")) {
		DllCall("GetCursorPos","Uint",&RECT)
		sleep,4
		win_move(hgui,(NumGet(&RECT,0,"Int")-xs),(NumGet(&RECT,4,"Int") -ys),CURRENT_W,CURRENT_H,0x4001)
		TBRePos()

		; DllCall("MoveWindow","Uint",hWnd1,"int",vWinX,"int",vWiny,"int",rw,"int",rh,"Int",2)
		if(STrigga)
			settimer,grace,-400
		if(!lbd){
			settimer,WM_lrBUTTONup,-150
			return,0
	}	}

	grace:
	disgrace:
	(instr(a_thislabel,"dis")? STrigga:= False : STrigga:= True)
	return,
}

WM_lrBUTTONup(wParam="",lParam="") { ; Toggle Maximise & fill ;
	global STrigga, LbD:= ""
	if(!STrigga) {
		settimer,GuiMenu,-1
		return,
}	}

WM_KEYDN(wParam) {
	kdf:=func("kdfunc").bind(wParam)
	settimer,% kdf,-1
	return,
}

kdfunc(wParam){
	local
	static
	global modkeyheld
	switch,wParam {
		case,"16","17": (modkey%wParam%held):=true
	}
		kdff:=func("ttt").bind(wParam)
	settimer,% kdff,-1
}

ttt(txt="fags",bums="",queers="" ){
	local
	static
	tooltip,% txt
	settimer,t2t,-1000
	return,
}

t2t(){
	local
	static
	tooltip
}

WM_KEYUP(wParam,lParam,msg="",hwnd="") {
	global ; global hWnd_Par, scriptraw ;	% Format("{:#x}",hwnd)
	switch,hwnd {
		case,hsci:			ttt(wParam)


		default:return
	}
	static txtl,txtlold,textold,textnew
	txtlold:= txtl
	switch,wParam {
		case,"17","16": modkey%wParam%held:= false
		case,"27"	: settimer,guiclose,-1	; Esc ;
		case,"20"	: return
	;	case,"13"	: ;enter
			gui,par	: submit,nohide
 			send,{tab}
			return
		default:
			if(modkey16held&&modkey17held) {
				tooltip % ("nig ated"),,,2
				return,
			}
			;tooltip % (wParam " up."),,,2
			;tooltip % (wParam " up."),,,2
			textold:= Textnew
			;settimer, _Lex,-10 ; should be handled post notification handler
			;return,_Lex(byref txt){
			;settimer,_Lex,-19
			;ControlGetText,Textnew,,ahk_id %hsci%
		;	;'sendmessage,SCI_GETTEXT,0,0,,ahk_id %hsci%
			;txtl:= errorlevel
		;sendmessage,2008,0,0,scintilla1,ahk_id %ldr_hWnd%
		;	pos:= errorlevel -1	
		; aggtext:=strreplace(Textnew,textold,"")
		;msgbox %  strlen(Textnew) " " strlen(textold) "`n" pos
			;msgbox % aggtext
	; sci.StartStyling(pos)
			; sci.SetTargetRange(pos,pos+1)
			; sci.SetStyling(1,SCE_AHKL_USERDEFINED22)
			; sci.SetStyling(1,Style_DEFAULT)			
						; sci.Updated()
return,
sleep,100
		;ControlGetText,Textnew,,ahk_id %ldr_hWnd%
			;sci.Updated()
			;Count:= sci.Count()
			;SeTxT(sci.text)
			;postMessage,SCI_GOTOPOS,%pos%,,scintilla1,ahk_id %ldr_hWnd%
}	}

; WM_WINDOWPOSCHANGED() {
	; global ; GuiControl,hide,QueryText
	; static InitH:= 7w7
	; ttt("A NR")
	; GPos:= wingetpos(ldr_hWnd), 7w7:= GPos.h
	; (!(InitH= GPos.h)? InitH:= GPos.h, dd:= InitH -100, de:= dd +20)

	;;GuiControl,Move,ahk_id %lvhWnd%,% dd
; }

wm_moveend(){
	global palmovtrig, palactive
	moved(), palmovtrig:= False, ttt("end")
	;if(!palactive) ;winset,transparent,240,ahk_id %hpal%
	return,	
}

wm_move(){
	global
	settimer,paltopp4,-100
	return,
	;settimer, wm_moveend,-100 ;gui,APCBackMain:Show,% "hide x" (LPos.x+LPos.W) " y" (LPos.y+(78)),Palette
}

moved() {	; return 
	settimer test,-700
}

TEST() {
	global gradwnd, HIPath, ldr_hWnd
	static oldw, oldh
	;global gradwnd
	p:= wingetpos(ldr_hWnd)
	; winSet,Region,% "1-0 W" p.w " H" p.h " R" (p.w+ p.h) *.05 "-" (p.w+ p.h) *.05 ,ahk_id %gradwnd%
	if(p.w=oldw && p.h=oldh)
		return,
	oldw:= w:=p.w, oldh:= h:=p.h-366
	win_move(staticwnd,0, 0,w,h,"")
	guiControl,move, HIPath, w%W% h%H%
	gradupdate(w,h)
 	;winSet,Region,% "1-1 W" p.w*1.2 " H" p.h*.9 " R20-20",ahk_id %gradwnd%
}

_Lex(){
	 return
	static p1d,hw,init:=0	;static textnew, textold	;, txtlold, txtl 
	static phwn,sciname
	global ldr_hWnd,sci,scihwnd,r_pid
	if (init=0) {
		phwn := ldr_hWnd
		sciname:= "scintilla1"
		pid:=
		init:= 1
	}
	return,searchrep(Textnew:= sci_getall(hw,p1d))
}

IconInit() { ; C:\Icon\256\pinhead.ico,C:\Icon\- Icons\256\Working.ico,C:\Icon\- Icons\256\Layers.ico, ;
	global
	icona:= "C:\Icon\256\home.ico,C:\Icon\64\SnipSketch64.ico,C:\Icon\- Icons\256\Foursquare One.ico,C:\Icon\- Icons\256\X (30).ico,C:\Icon\256\Untitl44sdsdexxadaedddded.ico,C:\Icon\- Icons\256\Flick Learning Wizard.ico,C:\Icon\256\Floppy - sDisk (15).ico,C:\Icon\256\progRe55752_2.ico,C:\Icon\256\inj4.ico,C:\Icon\256\tabsearc5h.ico,C:\Icon\256\reshackerdddn4.ico,C:\Icon\256\#1444.ico,C:\Icon\256\#1952.ico,C:\Icon\- Icons\256\Windows (26).ico,C:\Icon\64\CUR_HAND.ICO,C:\Icon\64\tism64.ico,C:\Icon\256\IconGroup104.ico,"
	loop,30
		icona .= "C:\Icon\256\pinhead.ico,"
	loop,parse,% icona,`,
		icon_array[max_i:= A_index]:= A_loopfield
	max_i>48? vCount:= 48 : vCount:= max_i
	hIL2:= IL_Create(vCount,2,64),	vSize:= A_PtrSize=8? 32:20
	VarSetCapacity(TBBUTTON,vCount*vSize, 0)
	Loop,% vCount {
		switch a_index {
			case 1: (vTxt%A_Index%):= "Home is where the fart is..."
			default: (vTxt%A_Index%):= "       Cut-em-up!!`nI-can-dance-all-day!!!"
		}
		vOffset:= (A_Index -1) *vSize
		NumPut(A_Index-1,		TBBUTTON,vOffset,  "Int")
		NumPut(A_Index-1,		TBBUTTON,vOffset+4,"Int")
		NumPut(0x4,				TBBUTTON,vOffset+8,"UChar")
		NumPut(&vTxt%A_Index%,	TBBUTTON,vOffset+(A_PtrSize=8? 24:16),"Ptr") ;iString
	} ; hIL2:= IL_Create(5, 2, 64)
	for,i,icopath in icon_array				;	iBitmap
		IL_Add(hIL2,icopath,0) 				;	idCommand
	tabicons_init:= []			;fsState	;	TBSTATE_ENABLED:= 4
	loop,4									; str=tabicons_init.push("ahk" . a_index)
		tabicons_init.push("ahk" . a_index)	; loop(6,str)
	hIL1:= TAB_CreateImageList(32) ;-- Create and populate image list
	for,i,f in tabicons_init
		IL_Add(hIL1,IcoDir . "\" . f . ".ico")
	return,
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
	msgbox,% pipe_nAME .= A_index
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
	}	}
	win_move(ldr_hWnd,aCunt.x+2,aCunt.y-2,aCunt.w-1,aCunt.h+1)
	, d2pos:= WinGetPos(ldr_hWnd)	;guiControl,Move,TBhWnd,% "x1 y2" 
	, show_upd8() ; ToolbarInit() ;guiControl,Move,Cut0r:,TBhWnd,y500 ;sleep,300
	, bcnt:= wingetpos(TBhWnd)
	ssleep(20)
	ControlGetPos,X,Y,W,H,,ahk_id %TBhWnd% ;SetWindowPos(bcnt.X,bcnt.Y,bcnt.W,bcnt.H,0,0x4014
	ssleep(10)
	win_move(htb,1,d2pos.h-98,w,70,"") ;SWP_NOACTIVATE|SWP_NOZORDER=0x4014;
	ssleep(10)
	ssleep(10) 
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

;"TCS_RIGHTJUSTIFY,0x0,TCS_SINGLELINE,0x0,TCS_EX_FLATSEPARATORS,0x1,TCS_SCROLLOPPOSITE,0x1,TCS_RIGHT,0x2,TCS_BOTTOM,0x2,TCS_MULTISELECT,0x4,TCS_FLATBUTTONS,0x8,TCS_FORCEICONLEFT,0x10,TCS_FORCELABELLEFT,0x20,TCS_HOTTRACK,0x40,TCS_VERTICAL,0x80,TCS_BUTTONS,0x100,TCS_MULTILINE0x200,TCS_FIXEDWIDTH,0x400,TCS_RAGGEDRIGHT,0x800,TCS_FOCUSONBUTTONDOWN,0x1000,TCS_OWNERDRAWFIXED,0x2000,TCS_TOOLTIPS,0x4000,TCS_FOCUSNEVER,0x8000"

IDropTargetOnDrop_LV(TargetObject,pDataObj,KeyState,X,Y,DropEffect) {
	global SbarhWnd
	; Standard clipboard formats
	Static CF:= {15: "CF_HDROP"}
	; TYMED enumeration
	Static TM:= {1:  "HGLOBAL"}
	Static CF_NATIVE:= A_IsUnicode ? 13 : 1 ; CF_UNICODETEXT  : CF_TEXT
	; "Private" formats don't get GlobalFree()'d
	Static CF_PRIVATEFIRST:= 0x0200
	Static CF_PRIVATELAST := 0x02FF
	; "GDIOBJ" formats do get DeleteObject()'d
	Static CF_GDIOBJFIRST:= 0x0300
	Static CF_GDIOBJLAST := 0x03FF
	; "Registered" formats
	Static CF_REGISTEREDFIRST:= 0xC000
	Static CF_REGISTEREDLAST := 0xFFFF
	; gui,+OwnDialogs
	; IDataObject_SetPerformedDropEffect(pDataObj, DropEffect)
	;  LV_Delete()
	; GuiControl, -Redraw, LV
	If(pEnumObj:= IDataObject_EnumFormatEtc(pDataObj)) {
		While,IEnumFORMATETC_Next(pEnumObj,FORMATETC) {
			IDataObject_ReadFormatEtc(FORMATETC,Format,Device,Aspect,Index,Type)
			TYMED:= "NONE"
			If(Format >= CF_PRIVATEFIRST) && (Format <= CF_PRIVATELAST)
			Name:= "*PRIVATE" ; Example for getting values out of the returned binary Data
			IDataObject_GetData(pDataObj, FORMATETC, Size, Data)
			If Format In 1,15
			{
				If IDataObject_GetDroppedFiles(pDataObj,Files)
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
							sleep,400
							;_Lex()
							settimer,_Lex,-10
						}
						Scriptnew:= ""
					}
				Continue,
		}	} ;LV_Add("", A_Index, Format, Name, TYMED, Size, Value)
		ObjRelease(pEnumObj)
	}
	Loop,% LV_GetCount("Column")
		LV_ModifyCol(A_Index, "AutoHdr")
	GuiControl,+Redraw,LV
	Effect:= {0: "NONE", 1: "COPY", 2: "MOVE", 4: "LINK"}[DropEffect]
	Return,DropEffect
}

Receive_WM_COPYDATA(byref wParam,byref lParam) {
	StringAddress:=	NumGet(lParam+(2*A_PtrSize))
	CopyOfData	 :=	StrGet(StringAddress)
	gosub,% CopyOfData
	return,True
}

col_mult(col,operand:=0) {
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
	}
	return,bgrout:= (0x . b . g . r)
}

col_add(col,operator:=0) {
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
	}
	return,bgrout:= (0x . b . g . r)
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

SetWindowPos(hWnd,x,y,w,h,hWndInsertAfter:= 0,uFlags:= 0x40) { ; SWP_SHOWWINDOW
	return,DllCall("SetWindowPos","Ptr",hWnd,"Ptr",hWndInsertAfter,"Int"
	,x,"Int",y,"Int",w,"Int",h,"UInt",uFlags)
}

EndTask(hWnd,fShutDown,fForce) {
	return,DllCall("EndTask","int",hWnd,"int",fShutDown,"int",fForce)
}

Gdip_GraphicsFromHWNDii(HWND, useICM:=0, InterpolationMode:="", SmoothingMode:="", PageUnit:="", CompositingQuality:="") {
; Creates a pGraphics object that is associated with a specified window handle [HWND]
; If useICM=1, the created graphics uses ICM [color management - (International Color Consortium = ICC)].
	pGraphics:= 0
	function2call:= (useICM=1)? "ICM" : ""
	gdipLastError:= DllCall("gdiplus\GdipCreateFromHWND" function2call, "UPtr", HWND, "UPtr*", pGraphics)
	If (gdipLastError=1 && A_LastError=8) ;out of memory;
		gdipLastError:= 3

	If (pGraphics && !gdipLastError) {
		If (InterpolationMode!="")
		 Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
		If (SmoothingMode!="")
		 Gdip_SetSmoothingMode(pGraphics, SmoothingMode)
		If (PageUnit!="")
		 Gdip_SetPageUnit(pGraphics, PageUnit)
		If (CompositingQuality!="")
		 Gdip_SetCompositingQuality(pGraphics, CompositingQuality)
	}
	return,pGraphics
}

setlexerStyle() {
sci.SetMarginWidthN(0,32) ; Show line numbers
sci.SetMarginMaskN(1,SC_MASK_FOLDERS) ; Show folding symbolsSC_MASK_FOLDERS
sci.SetMarginSensitiveN(1, true) ; Catch Margin click notifications

; Set up Margin Symbols
sci.MarkerDefine(SC_MARKNUM_FOLDER, SC_MARK_BOXPLUS)
sci.MarkerDefine(SC_MARKNUM_FOLDEROPEN, SC_MARK_BOXMINUS)
sci.MarkerDefine(SC_MARKNUM_FOLDERSUB, SC_MARK_VLINE)
sci.MarkerDefine(SC_MARKNUM_FOLDERTAIL, SC_MARK_LCORNER)
sci.MarkerDefine(SC_MARKNUM_FOLDEREND, SC_MARK_BOXPLUSCONNECTED)
sci.MarkerDefine(SC_MARKNUM_FOLDEROPENMID, SC_MARK_BOXMINUSCONNECTED)
sci.MarkerDefine(SC_MARKNUM_FOLDERMIDTAIL, SC_MARK_TCORNER)

; Change margin symbols colors
sci.MarkerSetFore(SC_MARKNUM_FOLDER , 0xFFFFFF)
sci.MarkerSetBack(SC_MARKNUM_FOLDER , 0x5A5A5A)
sci.MarkerSetFore(SC_MARKNUM_FOLDEROPEN , 0xFFFFFF)
sci.MarkerSetBack(SC_MARKNUM_FOLDEROPEN , 0x5A5A5A)
sci.MarkerSetFore(SC_MARKNUM_FOLDERSUB , 0xFFFFFF)
sci.MarkerSetBack(SC_MARKNUM_FOLDERSUB , 0x5A5A5A)
sci.MarkerSetFore(SC_MARKNUM_FOLDERTAIL , 0xFFFFFF)
sci.MarkerSetBack(SC_MARKNUM_FOLDERTAIL , 0x5A5A5A)
sci.MarkerSetFore(SC_MARKNUM_FOLDEREND , 0x0000FF)
sci.MarkerSetBack(SC_MARKNUM_FOLDEREND , 0x5A5A5A)
sci.MarkerSetFore(SC_MARKNUM_FOLDEROPENMID, 0xFF0000)
sci.MarkerSetBack(SC_MARKNUM_FOLDEROPENMID, 0x5A5A5A)
sci.MarkerSetFore(SC_MARKNUM_FOLDERMIDTAIL, 0xFFFFFF)
sci.MarkerSetBack(SC_MARKNUM_FOLDERMIDTAIL, 0x00FF00)
sci.SetFoldFlags(SC_FOLDFLAG_LEVELNUMBERS)
sci.SetLexer(Style_DEFAULT)
sci.SetReadOnly(False)
sci.StyleSetFont(32,"ms gothic","ms gothic")
sci.Stylesetsize(32,11)
sci.StyleSetFore(Style_DEFAULT,0x8855ff)
sci.StyleSETBACK(Style_DEFAULT,0x000000)
sci.SETWHITESPACEback(Style_DEFAULT,0x000000)
sci.StyleSetBold(Style_DEFAULT,False)
sci.SETUSETABS(True) ;sci.DELETEBACK()
sci.SCI_SETTABWIDTH(4)
sci.SetcaretFore(0x664433)
sci.SETselectionback(Style_DEFAULT,0x00aaff)
sci.SETSELBACK(Style_DEFAULT,0x400580)
sci.SetLexer(Style_DEFAULT)
sci.StyleClearAll()
sci.Notify := "SCI_NOTIFY"
; Command list
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
; Set Autohotkey Lexer and default options
sci.SetWrapMode(true), sci.SetLexer(SCLEX_AHKL)
sci.StyleSetFont(STYLE_DEFAULT, "Courier New"), sci.StyleSetSize(STYLE_DEFAULT, 10), sci.StyleClearAll()
; Set Style Colors
sci.StyleSetFore(SCE_AHKL_IDENTIFIER , 0xFFA044)
sci.StyleSetFore(SCE_AHKL_COMMENTDOC , 0x008888)
sci.StyleSetFore(SCE_AHKL_COMMENTLINE , 0x701530)
sci.StyleSetFore(SCE_AHKL_COMMENTBLOCK , 0x701530), sci.StyleSetBold(SCE_AHKL_COMMENTBLOCK, true)
sci.StyleSetFore(SCE_AHKL_COMMENTKEYWORD , 0xA50000), sci.StyleSetBold(SCE_AHKL_COMMENTKEYWORD, true)
sci.StyleSetFore(SCE_AHKL_STRING , 0xA2A2A2)
sci.StyleSetFore(SCE_AHKL_STRINGOPTS , 0x00EEEE)
sci.StyleSetFore(SCE_AHKL_STRINGBLOCK , 0xA2A2A2), sci.StyleSetBold(SCE_AHKL_STRINGBLOCK, true)
sci.StyleSetFore(SCE_AHKL_STRINGCOMMENT , 0xFF0000)
sci.StyleSetFore(SCE_AHKL_LABEL , 0x0000DD)
sci.StyleSetFore(SCE_AHKL_HOTKEY , 0x00AADD)
sci.StyleSetFore(SCE_AHKL_HOTSTRING , 0x00BBBB)
sci.StyleSetFore(SCE_AHKL_HOTSTRINGOPT , 0x990099)
sci.StyleSetFore(SCE_AHKL_HEXNUMBER , 0x880088)
sci.StyleSetFore(SCE_AHKL_DECNUMBER , 0xFF9000)
sci.StyleSetFore(SCE_AHKL_VAR , 0xFF9000)
sci.StyleSetFore(SCE_AHKL_VARREF , 0x990055)
sci.StyleSetFore(SCE_AHKL_OBJECT , 0x008888)
sci.StyleSetFore(SCE_AHKL_USERFUNCTION , 0x0000DD)
sci.StyleSetFore(SCE_AHKL_DIRECTIVE , 0x4A0000), sci.StyleSetBold(SCE_AHKL_DIRECTIVE, true)
sci.StyleSetFore(SCE_AHKL_COMMAND , 0x0000DD), sci.StyleSetBold(SCE_AHKL_COMMAND, true)
sci.StyleSetFore(SCE_AHKL_PARAM , 0x0085DD)
sci.StyleSetFore(SCE_AHKL_CONTROLFLOW , 0x0000DD)
sci.StyleSetFore(SCE_AHKL_BUILTINFUNCTION, 0xDD00DD)
sci.StyleSetFore(SCE_AHKL_BUILTINVAR , 0xEE00ff), sci.StyleSetBold(SCE_AHKL_BUILTINVAR, true)
sci.StyleSetFore(SCE_AHKL_KEY , 0xA2A2A2), sci.StyleSetBold(SCE_AHKL_KEY, true), sci.StyleSetItalic(SCE_AHKL_KEY, true)
sci.StyleSetFore(SCE_AHKL_USERDEFINED1 , 0xFF0000)
sci.StyleSetFore(SCE_AHKL_USERDEFINED2 , 0x00FF00)
sci.StyleSetFore(SCE_AHKL_ESCAPESEQ , 0x660000), sci.StyleSetItalic(SCE_AHKL_ESCAPESEQ, true)
sci.StyleSetFore(SCE_AHKL_ERROR , 0xFF0000)
; ; Put some text in the control (optional)
; FileRead, text, Highlight Test.txt
; sci.SetText(unused, text), sci.GrabFocus()
; Set up keyword lists, the variables are set at the beginning of the code
Loop,9 {
lstN:=a_index-1
sci.SetKeywords(lstN, ( lstN = 0 ? Dir
                      : lstN = 1 ? Com
                      : lstN = 2 ? Param
                      : lstN = 3 ? Flow
                      : lstN = 4 ? Fun
                      : lstN = 5 ? BIVar
                      : lstN = 6 ? Keys
                      : lstN = 7 ? UD1
                      : lstN = 8 ? UD2
                      : null))
}
return,
}

SeTxT(byref txt,byref obj="sci") {
	global (%obj%)
	static needle:= "[ \t]*(?!(if\(|while\(|for\())([\w#!^+&<>*~$])+\d*(\([^)]*\)|\[[^]]*\])([\s]|(/\*.*?\*)/|((?<=[\s]);[^\r\n]*?$))*?[\s]*\{|^[ \t]*(?!(if\(|while\(|for\())([\w#!^+&<>*~$])+\d*:(?=([\s]*[\r\n]|[\s]+;.*[\r\n]))|^[ \t]*(?!(;|if\(|while\(|for\())([^\r\n\t])+\d*(?&lt;![\s])"
	 ;text3:= txt
	SBtext:= fil3 . ": loaded..."
	SB_Settext(SBText,1), SB_Settext(SBText,2), SB_Settext(SBText,3)
	(%obj%).SeTtexT(unused,txt,0xff00fff)
	return,
}

PaintLexForceoff:
PaintLexForce:= False
return,

SearchRep(byref txt="",byref obj="",byref dickx="") {
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
	dickx:= dix, (obj=""? obj:="sci")

	if(!txt) ;ControlGetText,Textnew,scintilla1,ahk_id %ldr_hWnd%
		Txt:= sci_getall(hsci,r_pid)
	sci.SetTargetRange(0,(txtlength:=strlen(Txt))+1)
	
	if(txtlengthold=txtlength) {
		if(!PaintLexForce)
			return
	}
	txtlengthold:= txtlength
	,c:= 0, FoundPos:= 0. Pos:= 1
	critical
	TickSS:= a_tickcount
	while(FoundPos:= regexmatch(txt,Needle,Match,pos)) {
		loop,12  ;if(matchval(Pos,Len,a_index,colz[ a_index ])) {
			;if(matchval(FoundPos,Match.Len(),a_index,Dix[ a_index ].Colour,Dix[ a_index ].Font, Dix[ a_index ].Size, Dix[ a_index ].Italic, Dix[ a_index ].Bold, Dix[ a_index ].Underline)) {
				if(Match.Value(a_index))    {
					matchval(FoundPos,Match.Len(),a_index,dix[ a_index ].Colour,Match)
					;continue
				}
		Pos:= FoundPos +Match.Len()+1
		; continue
	}
	tooltip,% a_tickcount -tickss " Ms"	;TimeScriptStart()
}

matchval(Pos="",Len="",IDNum="",Colour="",byref match="") {
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
	global ;static nigget
	if(scihwnd="") {
		hwnd:= winexist("A")
		ControlGetFocus,cname,ahk_id %hwnd%
		if(eRRORlEVEL)
			return, 
		ControlGet,scihwnd,Hwnd,,% cname,ahk_id %hwnd%
	}
	hwnd:=scihwnd
	if(scipid="")
		winget,scipid,pid,ahk_id %hwnd%
	sendmessage,2006,"","",,ahk_id %scihwnd% ;SCI_GETLENGTH:=2006
	VarSetCapacity(nigget,(len:= errorlevel)+1,0)

	Address:= DllCall("VirtualAllocEx","Ptr",(hProc:= DllCall("OpenProcess","UInt",0x438,"Int",False,"UInt"
	,scipid,"Ptr")),"Ptr",0,"UPtr",len+1,"UInt",0x1000,"UInt",4,"Ptr")
	sendmessage,2182,len-1,Address,,ahk_id %scihwnd% ;SCI_GETTEXT:=2182;
	if success:= DllCall("ReadProcessMemory","Ptr",hProc,"Ptr",Address,"Ptr",&nigget,"UPtr",len-1,"uint","","uint")
	;msgbox,% byte2string("nigget") " " len " " nigger:= byte2string("nigget")
	return,byte2string("nigget")
}

; loop,parse,% defColz,`, ; loop 16 { 
; if(matchval(FoundPos,Match.Len(),IDNum="",Font="",Size="",Italic="",Bold="",Underline="")); }
	; if(Match.Value(1)) {						; Comments :
		; (%obj%).StartStyling(cunt), lex:= 1
		; (%obj%).StyleSetSize(SCE_AHKL_USERDEFINED%lex%,8)
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(2)) {					; Multiline :
		; (%obj%).StartStyling(cunt), lex:= 2
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(3)) {					; Directives :
		; (%obj%).StartStyling(cunt), lex:= 3
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(4)) {					; Punctuation :
		 ; (%obj%).StartStyling(cunt), lex:= 4
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(5)) {					; Numbers :
		 ; (%obj%).StartStyling(cunt), lex:= 5
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(6)) {					; Strings :
		 ; (%obj%).StartStyling(FoundPos), lex:= 6
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(7)) {					; Builtins :
		 ; (%obj%).StartStyling(cunt), lex:= 7
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(8)) {					; Flow :
		 ; (%obj%).StartStyling(FoundPos), lex:= 8
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(9)) {					; Commands :
		 ; (%obj%).StartStyling(FoundPos), lex:= 9
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(10)) {				; Functions :
		 ; (%obj%).StartStyling(cunt), lex:= 10
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(11)) {				; Keynames :
		 ; (%obj%).StartStyling(cunt), lex:= 11
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(12)) {				; Keywords :
		 ; (%obj%).StartStyling(cunt), lex:= 12
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(13)) {				; Functions2 :
		 ; (%obj%).StartStyling(cunt), lex:= 13
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else,if(Match.Value(14)) {				; Descriptions :
		 ; (%obj%).StartStyling(cunt), lex:= 14
		; ,(%obj%).SetTargetRange(FoundPos,FoundPos+Match.Len())
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; } else {									; Plain ;
		 ; (%obj%).StartStyling(cunt), lex:= 15
		; ,(%obj%).SetTargetRange(FoundPos+Match.Len(),txtlength)
		; ,(%obj%).SetStyling(Match.Len(),SCE_AHKL_USERDEFINED%lex%)
	; }
;}

byte2string(bytes_var_name="",CodePg="CP936") {
	static cp:="CP936" 
	(CodePg!="CP936"? Cp:= CodePg)
	return,nig:=strget(&(%bytes_var_name%),len-1,Cp)
}

MenuPost(wMsgEnum) {
	PostMessage,0x0111,% wMsgEnum,,,% A_ScriptName " - AutoHotkey"
}

GuiMenu() {
	menu,New,Add,Testmenu,Donothing
	menu,New,Show
}

MenuTrayShow() {
	Menu,Tray,Show
}

MenHandlr(isTarget="") {
	global
	switch,nus:= a_thismenuitem {
		case "Open Containing": ttt("Opening "   a_scriptdir "..." Open_Containing(A_scriptFullPath),1)
		case "edit","SUSPEND","pAUSE": MenuPost(%a_thismenuitem%)
		case "Open Vars" : ttt()
			PostMessage,0x0111,65407,,,% A_ScriptName " - AutoHotkey"
		case "r3load" : r3load()
		case "exit" : exitApp,
		case "mount-2-desktop(Trans)":
			Win2DTopTrans(ldr_hWnd,(deskX:= (guipos:=wingetpos(ldr_hWnd)).x),(desky:=guipos.y))
		case "mount-2-desktop(AeroG)","mount-2-desktop(Opaque)":
			Win2DTopOpaque(ldr_hWnd,(deskX:= (guipos:=wingetpos(ldr_hWnd)).x),(desky:=guipos.y))
		case "mount-2-desktop(FrostGlass)":
		glass(0x70441133,240,ldr_hWnd), Aero_BlurWindow(hpal)
		sleep,1100
			glass(0x90280411,240,ldr_hWnd)
		Win2DTopOpaque(ldr_hWnd,(deskX:= (guipos:=wingetpos(ldr_hWnd)).x),(desky:=guipos.y))
		;default: settimer,%a_thismenuitem%,-10 : ())
}	}

AHK_NOTIFYICON(byref wParam="",byref lParam="") {
	switch,lParam {
		; case 0x0204: return,timer("menutray",-20) ;WM_RBUTTONDN-0x0204l;
		case 0x0204 : return,menutray() ;WM_RBUTTONDN-0x0204l;
		case 0x0203 : _:="", wParam:=""
			PostMessage,0x0111,65407,,,% A_ScriptName " - AutoHotkey"
			Sleep(80),lParam:= (Sleep(11),ttt("Loading...","tray",1)) 
	;	case 0x0206: ; WM_RBUTTONDBLCLK	;	case 0x020B: ; WM_XBUTTONDOWN
	;	case 0x0201: ; WM_LBUTTONDOWN	;	case 0x0202: ; WM_LBUTTONUP
	return
}	}				 ; WM_DoubleClick	;	ID_VIEW_VARIABLES:= 65407

MenuTray(){
	Menu,Tray,Show
}

menuz:
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

varz:
global opAlwaysOnTop,topmost,opTaskbarItem,tbitem,TBeXtyle,ico_tick,ico_cross
,deskY,Scriptnew,scriptraw,textnew,ayboi,TBhWnd,DTopDocked,aHkeXe,fil3:=a_scriptname
,evhWnd,ldr_hWnd,htb,TabSelected,Pipes,vcount,icon_array,ppidd,SYSGUI_TBbUTTSZ
,PtrP,Ptr, colour1:= 0xEE0000, keynames:= "Lctrl,", BandIncr:= 0,match,r_pid
,ico_tick:="C:\Icon\256\ticAMIGA.ico", ico_cross:="C:\Icon\256\Oxygeclose.ico"
,_:= "C:\Program Files\Autohotkey\AutoHotkey",File,Titlemain,h3270,deskX, PaintLexForce
,EDIT:= 65304, open:= 65407, Suspend:= 65305, PAUSE:= 65306, exit:= 6530,gradwnd,hgui
,TBeXtyle:= 0x40110,InitH,IcoDir,ldr_hWnd,char_size,r_Wpos,colz,palactive,palmovtrig
global _needl:= "[ \t]*(?!(if\(|while\(|for\())([\w#!^+&<>*~$])+\d*(\([^)]*\)|\[[^]]*\])([\s]|(/\*.*?\*)/|((?<=[\s]);[^\r\n]*?$))*?[\s]*\{|^[ \t]*(?!(if\(|while\(|for\())([\w#!^+&<>*~$])+\d*:(?=([\s]*[\r\n]|[\s]+;.*[\r\n]))|^[ \t]*(?!(;|if\(|while\(|for\())([^\r\n\t])+\d*(?&lt;![\s])"
,Dix,
global SelCol_Butt
,Colors := {"Red": ["FF9999","FF6666","FF3333","FF0000","D90000","B20000","8C0000","660000","400000"], "Flame": ["FFB299","FF8C66","FF6633","FF4000","D93600","B22D00","8C2300","661A00","401000"], "Orange": ["FFCC99","FFB266","FF9933","FF8000","D96C00","B25900","8C4600","663300","402000"], "Amber": ["FFE599","FFD966","FFCC33","FFBF00","D9A300","B28600","8C6900","664D00","403000"], "Yellow": ["FFFF99","FFFF66","FFFF33","FFFF00","D9D900","B2B200","8C8C00","666600","404000"], "Lime": ["E5FF99","D9FF66","CCFF33","BFFF00","A3D900","86B200","698C00","4D6600","304000"], "Chartreuse": ["CCFF99","B2FF66","99FF33","80FF00","6CD900","59B200","468C00","336600","204000"], "Green": ["99FF99","66FF66","33FF33","00FF00","00D900","00B200","008C00","006600","004000"], "Sea": ["99FFCC","66FFB2","33FF99","00FF80","00D96C","00B259","008C46","006633","004020"], "Turquoise": [ "99FFE5","66FFD9","33FFCC","00FFBF","00D9A3","00B286","008C69","00664D","004030"], "Cyan": ["99FFFF","66FFFF","33FFFF","00FFFF","00D9D9","00B2B2","008C8C","006666","004040"], "Sky": ["99E5FF","66D9FF","33CCFF","00BFFF","00A3D9","0086B2","00698C","004D66","003040"], "Azure": ["99CCFF","66B2FF","3399FF","0080FF","006CD9","0059B2","00468C","003366","002040"], "Blue": ["9999FF","6666FF","3333FF","0000FF","0000D9","0000B2","00008C","000066","000040"], "Han": ["B299FF","8C66FF","6633FF","4000FF","3600D9","2D00B2","23008C","1A0066","100040"], "Violet": ["CC99FF","B266FF","9933FF","8000FF","6C00D9","5900B2","46008C","330066","200040"], "Purple": ["E599FF","D966FF","CC33FF","BF00FF","A300D9","8600B2","69008C","4D0066","300040"], "Fuchsia": ["FF99FF","FF66FF","FF33FF","FF00FF","D900D9","B200B2","8C008C","660066","400040"], "Magenta": ["FF99E5","FF66D9","FF33CC","FF00BF","D900A3","B20086","8C0069","66004D","400030"], "Pink": ["FF99CC","FF66B2","FF3399","FF0080","D9006C","B20059","8C0046","660033","400020"], "Crimson": ["FF99B2","FF668C","FF3366","FF0040","D90036","B2002D","8C0023","66001A","400010"], "Gray": ["DEDEDE","BFBFBF","9E9E9E","808080","666666","4D4D4D","333333","1A1A1A","000000"], "Sepia": ["DED3C3","BFAB8F","9E8664","806640","665233","4D3D26","33291A","1A140D","000000"]}

,ColorList := ["Red","Flame","Orange","Amber","Yellow","Lime","Chartreuse","Green","Sea","Turquoise","Cyan","Sky","Azure","Blue","Han","Violet","Purple","Fuchsia","Magenta","Pink","Crimson","Gray","Sepia"]
,dicks:="Comments,Multiline,Directives,Punctuation,Numbers,Strings,Builtins,Flow,Commands,Functions,Keywords,Keynames,Functions2,Descriptions,Plain"
 	; Tab control Styles ;		
(!PtrP? PtrP:= A_IsUnicode?	"UPtr*" : "UInt*")
 (!Ptr?	Ptr:=  A_IsUnicode?	"Ptr"	: "UInt") 
  char_size:=  A_IsUnicode? 	  2 : 1
global TextBackgroundBrush:= dllcall("CreateSolidBrush","UInt"
,	TextBackgroundColor:= 0x060915)
,	Icon_Array:= [] ; Toolbar/Tab-icons ;
,	Pipes:= {} ; All (trouserless) pipes. :
(opAlwaysOnTop? topmost:=" +Alwaysontop ")
(opTaskbarItem? TBeXtyle |= 0x40000)
return,

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
		OGdip.shutdown()

	IDT_LV.RevokeDragDrop(), IDT_LV2.RevokeDragDrop()
	, IDT_LV3.RevokeDragDrop(), IL_Destroy(hIL2)
	for,index in Pipes
	{
		nm:= (Pipes[index].name), pid:= (Pipes[index].hWnd)
		postMessage,0x0111,65307,,,% (nm " - AutoHotkey")
		sleep,100 ;EndTask(id,0,1);
	}
	exitapp,
	loop,3
		sleep,500
}

break(){
	return,break,
}
