' Maze game, for BASIC, http://rudih.info
' -use Ezedit draw mode as a level editor

DIM lin$(100)
DIM sc$(26)

' initial statements
menu:
CLS
COLOR 10, 0
LOCATE 10, 30
PRINT "---MAZE GAME---"
LOCATE 12, 5
PRINT "arrow keys move - <esc> quits - <L>oad level from 'level.txt'"
COLOR 3, 0
x$ = ""
WHILE x$ = ""
  x$ = INKEY$
WEND
IF x$ = "" THEN END
x = 37
y = 13
xmap = 1
ymap = 1
If x$="L" Or x$="l" then
 OPEN "level.txt" FOR INPUT AS #1
 FOR a = 1 TO 100
  IF NOT EOF(1) THEN LINE INPUT #1, lin$(a)
 NEXT a
 Close 1
 level=99
 GoTo main:
EndIf
level=1
lev:
x = 37
y = 13
xmap = 1
ymap = 1
If level=1 Then
 lin$(1) = "ɻɻ�ͻ"
 lin$(2) = "�ȼ��͹"
 lin$(3) = "���ͼ �"
END If
If level=2 Then
 lin$(1) = "ɻ ɻɻ �ͻ"
 lin$(2) = "ȹɼ���ͼ �"
 lin$(3) = " ȼɻȼ �˼"
 lin$(4) = " �������ʼ"
END If
If level=3 Then
 lin$(1) = "��ͻ ɻ �ͻ"
 lin$(2) = "�λ��ʹ Ȼ̻"
 lin$(3) = "ɼȻȻ��͹�λ"
 lin$(4) = "��ͼ ȼ ���ʼ"
END If
' main loop
main:
GOSUB load:

nav:
LOCATE y, x
COLOR 14, 0
PRINT ""
COLOR 3, 0
user$ = ""
WHILE user$ = ""
  user$ = INKEY$
WEND
IF user$ = "" GOTO menu:
' up
IF user$ = CHR$(0) + "H" THEN
	'colision detection
	dest$ = MID$(sc$(y - 1), x, 1)
	IF dest$ = "�" GOTO nav:
	
	LOCATE y, x
	PRINT " "
	y = y - 1
END IF
' down
IF user$ = CHR$(0) + "P" THEN
		'colision detection
	dest$ = MID$(sc$(y + 1), x, 1)
	IF dest$ = "�" GOTO nav:
	
	LOCATE y, x
	PRINT " "
	y = y + 1
END IF
' left
IF user$ = CHR$(0) + "K" THEN
		'colision detection
	dest$ = MID$(sc$(y), x - 1, 1)
	IF dest$ = "�" GOTO nav:
	
	LOCATE y, x
	PRINT " "
	x = x - 1
END IF
' right
IF user$ = CHR$(0) + "M" THEN
		'colision detection
	dest$ = MID$(sc$(y), x + 1, 1)
	IF dest$ = "�" GOTO nav:
	
	LOCATE y, x
	PRINT " "
	x = x + 1
END IF
IF x > 75 THEN
	x = 5
	xmap = xmap + 1
	GOTO main:
END IF
IF x < 5 THEN
	x = 75
	xmap = xmap - 1
	GOTO main:
END IF
IF y > 21 THEN
	y = 2
	ymap = ymap + 1
	GOTO main:
END IF
IF y < 3 THEN
	y = 21
	ymap = ymap - 1
	GOTO main:
END IF
GOTO nav:

' load the screen data
load:
x$ = MID$(lin$(ymap), xmap, 1)
CLS
IF x$ = " " THEN
 LOCATE 10, 10
 PRINT "You have found the end of the maze! Press space..."
 x$ = ""
 WHILE x$ <> " "
    x$ = INKEY$
 Wend
 If level=99 Or level=3 Then GoTo menu:
 Cls
 Locate 10,10
 Print "...on to level: ";level+1
 Sleep
 level=level+1
 GoTo lev:
END IF
length = 24
IF x$ = "�" THEN
  sc$(1) = "                                 �       �"
  sc$(2) = "                                 �       �"
  sc$(3) = "                                 �       �"
  sc$(4) = "                                 �       �"
  sc$(5) = "                                 �       �"
  sc$(6) = "                                 �       �"
  sc$(7) = "                                 �       �"
  sc$(8) = "                                 �       �"
  sc$(9) = "                                 �       �"
  sc$(10) = "����������������������������������       �������������������������������������"
  sc$(11) = ""
  sc$(12) = ""
  sc$(13) = ""
  sc$(14) = ""
  sc$(15) = "����������������������������������       �������������������������������������"
  sc$(16) = "                                 �       �"
  sc$(17) = "                                 �       �"
  sc$(18) = "                                 �       �"
  sc$(19) = "                                 �       �"
  sc$(20) = "                                 �       �"
  sc$(21) = "                                 �       �"
  sc$(22) = "                                 �       �"
  sc$(23) = "                                 �       �"
  sc$(24) = "                                 �       �"
END IF
IF x$ = "�" THEN
  sc$(1) = ""
  sc$(2) = ""
  sc$(3) = ""
  sc$(4) = ""
  sc$(5) = ""
  sc$(6) = ""
  sc$(7) = ""
  sc$(8) = ""
  sc$(9) = ""
  sc$(10) = "����������������������������������������������������������������������������"
  sc$(11) = ""
  sc$(12) = ""
  sc$(13) = ""
  sc$(14) = ""
  sc$(15) = "����������������������������������������������������������������������������"
  length = 15
END IF
IF x$ = "�" THEN
  sc$(1) = "                                 �       �"
  sc$(2) = "                                 �       �"
  sc$(3) = "                                 �       �"
  sc$(4) = "                                 �       �"
  sc$(5) = "                                 �       �"
  sc$(6) = "                                 �       �"
  sc$(7) = "                                 �       �"
  sc$(8) = "                                 �       �"
  sc$(9) = "                                 �       �"
  sc$(10) = "                                 �       �����������������������������������"
  sc$(11) = "                                 �"
  sc$(12) = "                                 �"
  sc$(13) = "                                 �"
  sc$(14) = "                                 �"
  sc$(15) = "                                 �       �����������������������������������"
  sc$(16) = "                                 �       �"
  sc$(17) = "                                 �       �"
  sc$(18) = "                                 �       �"
  sc$(19) = "                                 �       �"
  sc$(20) = "                                 �       �"
  sc$(21) = "                                 �       �"
  sc$(22) = "                                 �       �"
  sc$(23) = "                                 �       �"
  sc$(24) = "                                 �       �"
END IF
IF x$ = "�" THEN
  sc$(1) = ""
  sc$(2) = ""
  sc$(3) = ""
  sc$(4) = ""
  sc$(5) = ""
  sc$(6) = ""
  sc$(7) = ""
  sc$(8) = ""
  sc$(9) = ""
  sc$(10) = "������������������������������������������������������������������������������"
  sc$(11) = ""
  sc$(12) = ""
  sc$(13) = ""
  sc$(14) = ""
  sc$(15) = "����������������������������������       �������������������������������������"
  sc$(16) = "                                 �       �"
  sc$(17) = "                                 �       �"
  sc$(18) = "                                 �       �"
  sc$(19) = "                                 �       �"
  sc$(20) = "                                 �       �"
  sc$(21) = "                                 �       �"
  sc$(22) = "                                 �       �"
  sc$(23) = "                                 �       �"
  sc$(24) = "                                 �       �"
END IF
IF x$ = "�" THEN
  sc$(1) = "                                 �       �"
  sc$(2) = "                                 �       �"
  sc$(3) = "                                 �       �"
  sc$(4) = "                                 �       �"
  sc$(5) = "                                 �       �"
  sc$(6) = "                                 �       �"
  sc$(7) = "                                 �       �"
  sc$(8) = "                                 �       �"
  sc$(9) = "                                 �       �"
  sc$(10) = "����������������������������������       �������������������������������������"
  sc$(11) = ""
  sc$(12) = ""
  sc$(13) = ""
  sc$(14) = ""
  sc$(15) = "������������������������������������������������������������������������������"
  length = 15
END IF
IF x$ = "�" THEN
  sc$(1) = ""
  sc$(2) = ""
  sc$(3) = ""
  sc$(4) = ""
  sc$(5) = ""
  sc$(6) = ""
  sc$(7) = ""
  sc$(8) = ""
  sc$(9) = ""
  sc$(10) = "                                 ���������������������������������������������"
  sc$(11) = "                                 �"
  sc$(12) = "                                 �"
  sc$(13) = "                                 �"
  sc$(14) = "                                 �"
  sc$(15) = "                                 �       �������������������������������������"
  sc$(16) = "                                 �       �"
  sc$(17) = "                                 �       �"
  sc$(18) = "                                 �       �"
  sc$(19) = "                                 �       �"
  sc$(20) = "                                 �       �"
  sc$(21) = "                                 �       �"
  sc$(22) = "                                 �       �"
  sc$(23) = "                                 �       �"
  sc$(24) = "                                 �       �"
END IF
IF x$ = "�" THEN
  sc$(1) = "                                 �       �"
  sc$(2) = "                                 �       �"
  sc$(3) = "                                 �       �"
  sc$(4) = "                                 �       �"
  sc$(5) = "                                 �       �"
  sc$(6) = "                                 �       �"
  sc$(7) = "                                 �       �"
  sc$(8) = "                                 �       �"
  sc$(9) = "                                 �       �"
  sc$(10) = "                                 �       �������������������������������������"
  sc$(11) = "                                 �"
  sc$(12) = "                                 �"
  sc$(13) = "                                 �"
  sc$(14) = "                                 �"
  sc$(15) = "                                 ���������������������������������������������"
  length = 15
END IF
IF x$ = "�" THEN
  sc$(1) = "                                 �       �"
  sc$(2) = "                                 �       �"
  sc$(3) = "                                 �       �"
  sc$(4) = "                                 �       �"
  sc$(5) = "                                 �       �"
  sc$(6) = "                                 �       �"
  sc$(7) = "                                 �       �"
  sc$(8) = "                                 �       �"
  sc$(9) = "                                 �       �"
  sc$(10) = "����������������������������������       �"
  sc$(11) = "                                         �"
  sc$(12) = "                                         �"
  sc$(13) = "                                         �"
  sc$(14) = "                                         �"
  sc$(15) = "������������������������������������������"
  length = 15
END IF

IF x$ = "�" THEN
  sc$(1) = ""
  sc$(2) = ""
  sc$(3) = ""
  sc$(4) = ""
  sc$(5) = ""
  sc$(6) = ""
  sc$(7) = ""
  sc$(8) = ""
  sc$(9) = ""
  sc$(10) = "������������������������������������������"
  sc$(11) = "                                         �"
  sc$(12) = "                                         �"
  sc$(13) = "                                         �"
  sc$(14) = "                                         �"
  sc$(15) = "����������������������������������       �"
  sc$(16) = "                                 �       �"
  sc$(17) = "                                 �       �"
  sc$(18) = "                                 �       �"
  sc$(19) = "                                 �       �"
  sc$(20) = "                                 �       �"
  sc$(21) = "                                 �       �"
  sc$(22) = "                                 �       �"
  sc$(23) = "                                 �       �"
  sc$(24) = "                                 �       �"
END IF
IF x$ = "�" THEN
  sc$(1) = "                                 �       �"
  sc$(2) = "                                 �       �"
  sc$(3) = "                                 �       �"
  sc$(4) = "                                 �       �"
  sc$(5) = "                                 �       �"
  sc$(6) = "                                 �       �"
  sc$(7) = "                                 �       �"
  sc$(8) = "                                 �       �"
  sc$(9) = "                                 �       �"
  sc$(10) = "                                 �       �"
  sc$(11) = "                                 �       �"
  sc$(12) = "                                 �       �"
  sc$(13) = "                                 �       �"
  sc$(14) = "                                 �       �"
  sc$(15) = "                                 �       �"
  sc$(16) = "                                 �       �"
  sc$(17) = "                                 �       �"
  sc$(18) = "                                 �       �"
  sc$(19) = "                                 �       �"
  sc$(20) = "                                 �       �"
  sc$(21) = "                                 �       �"
  sc$(22) = "                                 �       �"
  sc$(23) = "                                 �       �"
  sc$(24) = "                                 �       �"
END IF
IF x$ = "�" THEN
  sc$(1) = "                                 �       �"
  sc$(2) = "                                 �       �"
  sc$(3) = "                                 �       �"
  sc$(4) = "                                 �       �"
  sc$(5) = "                                 �       �"
  sc$(6) = "                                 �       �"
  sc$(7) = "                                 �       �"
  sc$(8) = "                                 �       �"
  sc$(9) = "                                 �       �"
  sc$(10) = "����������������������������������       �"
  sc$(11) = "                                         �"
  sc$(12) = "                                         �"
  sc$(13) = "                                         �"
  sc$(14) = "                                         �"
  sc$(15) = "����������������������������������       �"
  sc$(16) = "                                 �       �"
  sc$(17) = "                                 �       �"
  sc$(18) = "                                 �       �"
  sc$(19) = "                                 �       �"
  sc$(20) = "                                 �       �"
  sc$(21) = "                                 �       �"
  sc$(22) = "                                 �       �"
  sc$(23) = "                                 �       �"
  sc$(24) = "                                 �       �"
END If
FOR c = 1 TO length
	PRINT sc$(c)
Next
Return


