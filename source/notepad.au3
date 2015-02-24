;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Created by Kuntal Das
;Xtreme Labs,Team SDK
;Xtreme Note
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;FLAG DEFINITION
;---------------
;$flag1=-2	- file has not been saved even once i.e. text has only been typed in the text box
;$flag1=-1  - File has been saved atleast once
;$flag2=-2	- File has not been opened i.e. text has only been typed in the text box
;$flag2=-1	- File has been opened
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#include <ColorConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <File.au3>
#include <Misc.au3>

_Main()
Func _Main()
	Local $GUIWidth = 700, $GUIHeight = 300
    Local $sDrive = "", $sDir = "", $sFilename = "", $sExtension = ""
	Local $Edit, $Save,$About,$msg,$Open,$temp,$fopen1,$get,$fopen2,$split,$flag1=-2,$opf1,$fread,$name,$flag2=-2,$saf,$lab,$dark,$light,$font,$fd,$file,$lab2
    Local $msg1= "Choose a filename.",$msg2= "Select a single text file."
	$file=FileOpen(@ScriptDir&"\settings.xns")
    $fn=FileReadLine($file,6)
	GUICreate("Xtreme Note. v1.0 ", $GUIWidth, $GUIHeight)

	$Edit = GUICtrlCreateEdit("", 10, 10, 630, 255)
	$Open = GUICtrlCreateButton("Open", 440, 270, 70, 25)
    $Save = GUICtrlCreateButton("Save", 530, 270, 70, 25)
    $About= GUICtrlCreateButton("About", 620, 270, 70, 25)
    $New  = GUICtrlCreateButton("New", 350, 270, 70, 25)
	$lab=GUICtrlCreateLabel(" FILE_NAME : Untitled.txt", 10, 275, 320, 20)
	$lab2=GUICtrlCreateLabel("Presets", 643, 110, 320, 20)
    $dark=GUICtrlCreateButton(" Dark ", 650, 180, 45, 40)
	$light=GUICtrlCreateButton(" Light ", 650, 130, 45, 40)
	$font=GUICtrlCreateButton(" Font ", 650, 60, 45, 40)

    GUISetBkColor(FileReadLine($file,5))
	GUICtrlSetBkColor($Edit, FileReadLine($file,4))

    GUICtrlSetBkColor($Open, FileReadLine($file,2))
    GUICtrlSetBkColor($Save, FileReadLine($file,2))
    GUICtrlSetBkColor($About,FileReadLine($file,2))
    GUICtrlSetBkColor($New, FileReadLine($file,2))
    GUICtrlSetBkColor($dark, $COLOR_BLACK)
    GUICtrlSetBkColor($light, 0xDFEEFC)
    GUICtrlSetBkColor($font, FileReadLine($file,2))

	GUICtrlSetColor($Edit,FileReadLine($file,1))

    GUICtrlSetColor($dark, 0x00FF00)

	GUICtrlSetColor($Open, FileReadLine($file,3))
    GUICtrlSetColor($Save, FileReadLine($file,3))
    GUICtrlSetColor($About,FileReadLine($file,3))
    GUICtrlSetColor($New,FileReadLine($file,3))
    GUICtrlSetColor($lab, FileReadLine($file,3))
	GUICtrlSetColor($lab2, FileReadLine($file,3))
    GUICtrlSetColor($font,FileReadLine($file,3))

    GUICtrlSetFont($Edit,FileReadLine($file,8),FileReadLine($file,10),FileReadLine($file,9),FileReadLine($file,7))
	GUICtrlSetFont($Open,10, 600, "Arial")
    GUICtrlSetFont($Save, 10, 600,  "Arial")
	GUICtrlSetFont($About, 10, 600, "Arial")
    GUICtrlSetFont($New, 10, 600, "Arial")
    GUICtrlSetFont($lab, 10, 600, "Arial")
	GUICtrlSetFont($lab2, 9, 600,4, "Arial")
	GUICtrlSetFont($dark, 10, 600,"Arial")
	GUICtrlSetFont($light, 10,600,"Arial")
	GUICtrlSetFont($font, 10,600,"Arial")
	GUISetState(@SW_SHOW )
	While 1
		$msg = GUIGetMsg()
		Select
;Window Close Button
		 Case $msg = $GUI_EVENT_CLOSE
			if NOT(_GUICtrlEdit_GetText($Edit)==$get) Then							;if what is written , is not saved and user wants to quit.
			   $ch=MsgBox(3,"Attention"," Would you like to Save Changes to the Current Document before Exiting?.")

			   if $ch=6 Then														;yes button
				  If $flag1==-2 then												;if file has not been saved even once
					 $saf = FileSaveDialog($msg1, @DesktopDir, "Text (*.txt)|All Files (*.*)",BitOR(2,16),"Untitled.txt")
					 if NOT($saf=="") Then											;checks if file name has been specified or not
						$split = _PathSplit($saf, $sDrive, $sDir, $sFilename, $sExtension)
						if $split[4] = "" Then										; if extension not specified
						   $saf=$saf&".txt"
						   _FileCreate($saf)
						   $fopen2=FileOpen($saf,$FO_OVERWRITE)

						Else														;Exension has been specified
						   _FileCreate($saf)
						   $fopen2=FileOpen($saf,$FO_OVERWRITE)

						EndIf
						$get=_GUICtrlEdit_GetText($Edit)
						FileWrite($fopen2,$get)
						GUIDelete()
						Exit
					 Endif

				  Else																;if file has been saved at least once
					 $get=_GUICtrlEdit_GetText($Edit)
					 FileClose($fopen2)
					 $fopen2=FileOpen($saf,$FO_OVERWRITE)
					 FileWrite($fopen2,$get)
				  EndIf

			   Elseif $ch=7 Then													;No button
				  GUIDelete()
				  Exit
			   EndIf

			Else																	;if no modification has been made after saving and user wants to quit
			   GUIDelete()
			   Exit
			EndIf
;Save Button
		 Case $msg = $Save

			IF $flag1==-1 Then														;if file has been saved at least once
			   $get=_GUICtrlEdit_GetText($Edit)
			   if $fopen1 Then														;if file has already been opened
				  FileClose($fopen1)
				  $name=$opf1
			   Else																	;if file has already been saved
				  $name=$saf
			   EndIf
			   $fopen1=FileOpen($name,$FO_OVERWRITE)
			   FileWrite($fopen1,$get)
			EndIf

			if $flag1==-2 Then														;if file has not been saved even once
			   $saf = FileSaveDialog($msg1, @DesktopDir, "Text (*.txt)|All Files (*.*)",BitOR(2,16))
			   if NOT($saf=="") Then												;checks if file name has been specified or not
				  $split = _PathSplit($saf, $sDrive, $sDir, $sFilename, $sExtension)
				  if $split[4] = "" Then											;if extension is not specified
					 $saf=$saf&".txt"
					 GUICtrlSetData($lab," FILE_NAME : "&$split[3]&".txt")
					 _FileCreate($saf)
					 $fopen2=FileOpen($saf,$FO_OVERWRITE)
				  Else																;if extension has been specified
					 _FileCreate($saf)
					 GUICtrlSetData($lab," FILE_NAME : "&$split[3]&$split[4])
					 $fopen2=FileOpen($saf,$FO_OVERWRITE)
				  EndIf
				  $flag1=-1
				  $flag2=-1
				  $get=_GUICtrlEdit_GetText($Edit)
				  FileWrite($fopen2,$get)
			   EndIf
			EndIf
;open button

		 Case $msg = $Open
			if NOT(_GUICtrlEdit_GetText($Edit)==$get) Then							;if what is written , is not saved and user wants to open another file.
			   $ch=MsgBox(3,"Attention"," Would you like to Save Changes to the Current Document?.")

			   if $ch=6 Then														;Yes button
				  If $flag1==-2 then												;if file has not been saved even once
					 $saf = FileSaveDialog($msg1, @DesktopDir, "Text (*.txt)|All Files (*.*)",BitOR(2,16),"Untitled.txt" )
					 if NOT($saf=="") Then											;checks if file name has been specified or not
						$split = _PathSplit($saf, $sDrive, $sDir, $sFilename, $sExtension)
						if $split[4] = "" Then										;if extension not specified
						   $saf=$saf&".txt"
						   _FileCreate($saf)
						   $fopen2=FileOpen($saf,$FO_OVERWRITE)
						Else														;if extension has been specified
						   _FileCreate($saf)
						   $fopen2=FileOpen($saf,$FO_OVERWRITE)
						EndIf
						$get=_GUICtrlEdit_GetText($Edit)
						FileWrite($fopen2,$get)
						$opf1=FileOpenDialog($msg2, @DesktopDir& "\", "Text files (*.txt)|All Files (*.*)", $FD_FILEMUSTEXIST)
						if NOT($opf1=="") Then										;checks if file name has been specified or not
						   $split = _PathSplit($opf1, $sDrive, $sDir, $sFilename, $sExtension)
						   GUICtrlSetData($lab," FILE_NAME : "&$split[3]&$split[4])
						   $fopen1 = FileOpen($opf1, $FO_READ)
						   $fread = FileRead($fopen1)
						   _GUICtrlEdit_SetText($Edit, $fread)
						   $flag1=-1
						   $flag2=-1
						Endif
					 Endif
				  Else																;if file has been saved at least once
					 $get=_GUICtrlEdit_GetText($Edit)
					 FileClose($fopen2)
					 $fopen2=FileOpen($saf,$FO_OVERWRITE)
					 FileWrite($fopen2,$get)
					 $opf1=FileOpenDialog($msg2, @DesktopDir& "\", "Text files (*.txt)|All Files (*.*)", $FD_FILEMUSTEXIST)
						if NOT($opf1=="") Then										;checks if file name has been specified or not
						   $fopen1 = FileOpen($opf1, $FO_READ)
						   $split = _PathSplit($opf1, $sDrive, $sDir, $sFilename, $sExtension)
						   GUICtrlSetData($lab," FILE_NAME : "&$split[3]&$split[4])
						   $fread = FileRead($fopen1)
						   _GUICtrlEdit_SetText($Edit, $fread)
						Endif
				  Endif
			   Elseif $ch=7 Then													;no button
				  $opf1=FileOpenDialog($msg2, @DesktopDir& "\", "Text files (*.txt)|All Files (*.*)", $FD_FILEMUSTEXIST)
				  if NOT($opf1=="") Then											;checks if file name has been specified or not
					 $fopen1 = FileOpen($opf1, $FO_READ)
					 $fread = FileRead($fopen1)
					 $split = _PathSplit($opf1, $sDrive, $sDir, $sFilename, $sExtension)
					 GUICtrlSetData($lab," FILE_NAME : "&$split[3]&$split[4])
					 _GUICtrlEdit_SetText($Edit, $fread)
					 $flag1=-1
					 $flag2=-1
				  EndIf
			   EndIf

			Else																	;If no modification  has been made and user wants to open a new file
			   $opf1=FileOpenDialog($msg2, @DesktopDir& "\", "Text files (*.txt)|All Files (*.*)", $FD_FILEMUSTEXIST)
			   if NOT($opf1=="") Then												;checks if file name has been specified or not
				  $flag2=-1
				  $flag1=-1
				  $split = _PathSplit($opf1, $sDrive, $sDir, $sFilename, $sExtension)
				  GUICtrlSetData($lab," FILE_NAME : "&$split[3]&$split[4])
				  $fopen1 = FileOpen($opf1, $FO_READ)
				  $fread = FileRead($fopen1)
				  _GUICtrlEdit_SetText($Edit, $fread)
				  $get=_GUICtrlEdit_GetText($Edit)
			   EndIf
		   EndIf
;about button

		 Case $msg = $About
			MsgBox(0, "About Xtreme Note", "Xtreme Note v1.0" & @CRLF & "Copyright 2014" & @CRLF & "Created By Xtreme Labs"& @CRLF & "Xtreme Note is Created by Kuntal Das,Xtreme Labs, Team SDK.")
;new button

		 Case $msg = $New
			if NOT(_GUICtrlEdit_GetText($Edit)==$get) Then
			   $ch=MsgBox(3,"Attention"," Would you like to Save Changes to the Current Document?.")

			   if $ch=6 Then														;yes button
				  If $flag1==-2 then												;if file has not been saved even once
					 $saf = FileSaveDialog($msg1, @DesktopDir, "Text (*.txt)|All Files (*.*)",BitOR(2,16),"Untitled.txt" )
					 if NOT($saf=="") Then											;checks if file name has been specified or not
						$split = _PathSplit($saf, $sDrive, $sDir, $sFilename, $sExtension)
						if $split[4] = "" Then										;if extension not specified
						   $saf=$saf&".txt"
						   _FileCreate($saf)
						   $fopen2=FileOpen($saf,$FO_OVERWRITE)
						Else														;if extension has been specified
						   _FileCreate($saf)
						   $fopen2=FileOpen($saf,$FO_OVERWRITE)
						EndIf
						$get=_GUICtrlEdit_GetText($Edit)
						FileWrite($fopen2,$get)
						_GUICtrlEdit_SetText($Edit, "")
						GUICtrlSetData($lab," FILE_NAME : "&"Untitled.txt")
						$flag1=-2
						$flag2=-2
						$opf1=""
						$saf=""
						$fopen1=""
						$fopen2=""
						$get=""
					 Endif
				  Else																;if file has been saved at least once
					 $get=_GUICtrlEdit_GetText($Edit)
					 FileClose($fopen2)
					 $fopen2=FileOpen($saf,$FO_OVERWRITE)
					 FileWrite($fopen2,$get)
						_GUICtrlEdit_SetText($Edit, "")
						GUICtrlSetData($lab," FILE_NAME : "&"Untitled.txt")
						$flag1=-2
						$flag2=-2
						$opf1=""
						$saf=""
						$fopen1=""
						$fopen2=""
						$get=""
				  Endif
			   Elseif $ch=7 Then													;no button
					    _GUICtrlEdit_SetText($Edit, "")
						GUICtrlSetData($lab," FILE_NAME : "&"Untitled.txt")
						$flag1=-2
						$flag2=-2
						$opf1=""
						$saf=""
						$fopen1=""
						$fopen2=""
						$get=""
			   EndIf
			Else																	;if no modifications has been done
			   _GUICtrlEdit_SetText($Edit, "")
			   GUICtrlSetData($lab," FILE_NAME : "&"Untitled.txt")
			   $flag1=-2
			   $flag2=-2
			   $opf1=""
			   $saf=""
			   $fopen1=""
			   $fopen2=""
			   $get=""
			Endif
		 Case $msg= $dark
			GUISetBkColor($COLOR_BLACK)

			GUICtrlSetBkColor($Edit, $COLOR_BLACK)
			GUICtrlSetBkColor($Open, $COLOR_BLACK)
			GUICtrlSetBkColor($Save, $COLOR_BLACK)
			GUICtrlSetBkColor($About, $COLOR_BLACK)
			GUICtrlSetBkColor($New, $COLOR_BLACK)
			GUICtrlSetBkColor($font, $COLOR_BLACK)

			GUICtrlSetColor($Edit, 0x00FF00)
			_FileWriteToLine(@ScriptDir&"\settings.xns", 1,"0x00FF00", 1)


			GUICtrlSetColor($Open, 0x00FF00)
			GUICtrlSetColor($Save, 0x00FF00)
			GUICtrlSetColor($About, 0x00FF00)
			GUICtrlSetColor($New, 0x00FF00)
			GUICtrlSetColor($lab, 0x00FF00)
			GUICtrlSetColor($lab2, 0x00FF00)
			GUICtrlSetColor($font, 0x00FF00)

			_FileWriteToLine(@ScriptDir&"\settings.xns", 2,"0x000000", 1)
			_FileWriteToLine(@ScriptDir&"\settings.xns", 3,"0x00FF00", 1)
			_FileWriteToLine(@ScriptDir&"\settings.xns", 4,"0x000000", 1)
			_FileWriteToLine(@ScriptDir&"\settings.xns", 5,"0x000000", 1)

		 Case $msg=$light
			GUISetBkColor(0xF0F0F0)

			GUICtrlSetBkColor($Edit,  0xFFFFFF)
			GUICtrlSetBkColor($Open, 0xDFEEFC)
			GUICtrlSetBkColor($Save, 0xDFEEFC)
			GUICtrlSetBkColor($About,0xDFEEFC)
			GUICtrlSetBkColor($New, 0xDFEEFC)
			GUICtrlSetBkColor($font, 0xDFEEFC)

			GUICtrlSetColor($Edit, $COLOR_BLACK)
			_FileWriteToLine(@ScriptDir&"\settings.xns", 1,"0x000000", 1)

			GUICtrlSetColor($Open, $COLOR_BLACK)
			GUICtrlSetColor($Save, $COLOR_BLACK)
			GUICtrlSetColor($About,$COLOR_BLACK)
			GUICtrlSetColor($New, $COLOR_BLACK)
			GUICtrlSetColor($lab, $COLOR_BLACK)
			GUICtrlSetColor($lab2, $COLOR_BLACK)
			GUICtrlSetColor($font, $COLOR_BLACK)

			_FileWriteToLine(@ScriptDir&"\settings.xns", 2,"0xDFEEFC", 1)
			_FileWriteToLine(@ScriptDir&"\settings.xns", 3,"0x000000", 1)
			_FileWriteToLine(@ScriptDir&"\settings.xns", 4,"0xFFFFFF", 1)
			_FileWriteToLine(@ScriptDir&"\settings.xns", 5,"0xF0F0F0", 1)

		 Case $msg=$font
			$fd = _ChooseFont(FileReadLine($file,7),FileReadLine($file,8),FileReadLine($file,1),FileReadLine($file,10),FileReadLine($file,9))
			If NOT @error Then
			   $fn=-1
			   GUICtrlSetFont($Edit,$fd[3],$fd[1],$fd[4],$fd[2])
			   GUICtrlSetColor($Edit, $fd[7])
			   _FileWriteToLine(@ScriptDir&"\settings.xns", 1,$fd[7], 1)
			   _FileWriteToLine(@ScriptDir&"\settings.xns", 6,$fn, 1)
			   _FileWriteToLine(@ScriptDir&"\settings.xns", 7,$fd[2], 1)
			   _FileWriteToLine(@ScriptDir&"\settings.xns", 8,$fd[3], 1)
			   _FileWriteToLine(@ScriptDir&"\settings.xns", 9,$fd[1], 1)
			   _FileWriteToLine(@ScriptDir&"\settings.xns", 10,$fd[4],1)
			EndIf

	  EndSelect
	WEnd
 EndFunc
