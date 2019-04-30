' name: Console editor
' description: 80 column text editor
' for: FreeBasic(QB console) 
' by: Rudi Horne
' web: http://rudih.info

Dim Line$(32000) ' buffer array

fposy=1 ' file position
lenfile=1 ' length of file

' reset screen
Cls
posy=1
posx=1

filen$=Command$
filen$=LTrim$(filen$)
filen$=RTrim$(filen$)
If filen$<>"" Then GoTo skipload:

top:
Cls
For m=1 To 24
  Print Line$((fposy-posy)+m)
Next
ftop:
Locate posy,posx

' get input 
user$=""  
While user$=""
 user$=InKey$
Wend

' delete
If user$=CHR$(0) + CHR$(83) Then
      LeftL$=Left$(Line$(fposy),posx-1)
      RightL$=mid$(Line$(fposy),posx+1,leng)
   	Line$(fposy)= LeftL$ + rightL$
   	GoTo top:
EndIf

' page up
If user$=CHR$(0) + CHR$(73) then
IF fposy >= 25 THEN
	   fposy = fposy - 24
	   posy=1
	ELSE
	  posy = 1
	  fposy = 1
	END IF
	GOTO top:
EndIf

' page down
If user$=CHR$(0) + CHR$(81) Then
	fposy=fposy+24
	If fposy>=lenfile Or fposy>=31900 Then fposy=lenfile
	GoTo top:
EndIf


' enter / down
If user$=CHR$(13) Or user$ = CHR$(0) + "P" Then 
	If fposy=lenfile And user$ = CHR$(0) + "P" Then GoTo top:
	fposy=fposy+1	
	oldposx=posx
	posx=1
	posy=posy+1
	If lenfile>31900 Then 
	 	Print "file too long"
	 	Sleep
	 	End
	EndIf
	If posy>=24 Then      
		Posy=24
      GoTo top:	
	EndIf
	If user$=Chr$(13) Then
			If fposy>lenfile Then lenfile = fposy
       lenfile=lenfile+1     
      For m=0 To lenfile-fposy
      	Line$(lenfile-m)=Line$(lenfile-m-1)
      Next
      If posx<2 Then 
      	Line$(fposy)=Line$(fposy-1)
      	Line$(fposy)=""
   	EndIf
      Leng=Len(Line$(fposy-1))
	   If posx<leng Then 
	   	Line$(fposy)=mid$(Line$(fposy-1),oldposx,leng)
	   	Line$(fposy-1)=Mid$(Line$(fposy-1),1,oldposx-1)
	   EndIf
	   If fposy>=lenfile Then lenfile=fposy+1
	EndIf
	GoTo top:
EndIf
' f2(save)
If user$=CHR$(0) + "<"Then
	Cls 
	Input"Enter filename to save as (or enter to cancel): ",filen$
	If filen$="" Then GoTo top:
	Open filen$ For Output As #1
	For m=1 To lenfile
		Print #1,Line$(m)
	Next m
	Close #1
	Print filen$;" has been saved. Press any key..."
	x$=""
	While x$=""
		x$=InKey$
	Wend
	GoTo top:
EndIf
' f3(load)
If user$=CHR$(0) + "=" Then 
	Cls
	Input "Enter filename to load (or enter to cancel): ",filen$
	If filen$="" Then GoTo top:
	skipload:
	For m=1 To 32000
		Line$(m)=""
	Next
	Open filen$ For Input As #1
	lenfile=1
	While Not Eof(1)
	 Line Input #1, Line$(lenfile) 
	 If Len(Line$(lenfile))>80 Then
	 	Print "line too long"
	 	Sleep
	 	End
	 EndIf
	 lenfile=lenfile+1
	 If lenfile>31900 Then 
	 	Print "file too long"
	 	Sleep
	 	End
	 EndIf
	Wend
	Close #1
	fposy=1
	posy=1
   posx=1
	GoTo top:
EndIf
' f1(help)
If user$= CHR$(0) + ";" Then
	Cls
	Print " Console editor help. "
	Print " <F1> - help"
	Print " <F2> - save as"
	Print " <F3> - load"
	Print " <Esc> - exit"
	Print " Column:";posx;" Line:";fposy;" Length:";lenfile
	Print " Press any key..."
	x$=""
	While x$=""
		x$=InKey$
	Wend
	GoTo top:
EndIf
' Esc(exit)
If user$=CHR$(27) Then
	Cls
	Print "Do you want to exit (y/n)?";
	x$=""
	While x$=""
   	x$=InKey$
	wend
	If x$="Y" Or x$="y" Then End
	GoTo top:
EndIf
' backspace / left
If user$=CHR$(8) Or user$=CHR$(0) + "K" Then
	If posx=1 And fposy=1 Then 
		Line$(fposy)=""
		GoTo top:
	EndIf
	If posx>1 Then
   	posx=posx-1
   	If user$=CHR$(0) + "K" Then GoTo top:
   	Print" "  
      LeftL$=Left$(Line$(fposy),posx-1)
      RightL$=mid$(Line$(fposy),posx+1,leng)
   	Line$(fposy)= LeftL$ + rightL$
	EndIf
	If posx=1 Then
		If user$=CHR$(0) + "K" Then GoTo top:
		If fposy>1 Then fposy=fposy-1
		If posy>1 Then posy=posy-1
		Line$(lenfile+1)=""
		For m=1 To lenfile-fposy
			Line$(fposy+m)=Line$(fposy+m+1)
		Next
		lenfile=lenfile-1
		Cls
		If fposy>1 Then
			For m=1 To 24
			  Print Line$((fposy-posy)+m)
		   Next		
		EndIf
	EndIf
	GoTo top:
EndIf
' up
If user$=CHR$(0) + "H" And posy<2 Then
	If fposy<2 Then GoTo top:
   fposy=fposy-1
	posx=1
	GoTo top:
EndIf
If user$=CHR$(0) + "H" And posy>1 Then
	fposy=fposy-1
	posy=posy-1
	posx=1
	GoTo top:
EndIf
' right
If user$ = CHR$(0) + "M" Then
	If posx>78 Then GoTo top:
	Leng=Len(Line$(fposy))
	If posx>leng Then GoTo top:
	posx=posx+1
   GoTo top:  
EndIf
' home
If user$ = CHR$(0) + "G" Then
	posx=1
	GoTo top:
EndIf
' end
If user$ = CHR$(0) + "O" Then
	posx=Len(Line$(fposy))+1
	GoTo top:
EndIf

If lenfile>31900 Then 
	Print "file too long"
	Sleep
	End
EndIf
Leng=Len(Line$(fposy))
If leng>78 GoTo top:
LeftL$=Left$(Line$(fposy),posx-1)
RightL$=mid$(Line$(fposy),posx,leng)
Line$(fposy)=LeftL$+user$+RightL$
Locate posy,1
Print Line$(fposy)
If posx<80 Then posx=posx+1
GoTo ftop: