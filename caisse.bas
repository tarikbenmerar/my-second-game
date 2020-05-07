 'declaration de variables
global key$,state,Index,NumCasex,NumCasey,PrevCasex,PrevCasey,NumWon,MaxWon,Level$,MaxLevel
 MaxLevel=40
 Dim Caisse$(1)
  Level$="1"
 Dim main(4)
  main(1)=070
  main(2)=170
  main(3)=270
  main(4)=370
Index=1
   'instructions lors de l'ouverture de la fen�tre
 ' ouverture d'une nouvelle fen�tre
open  "caisse v1.0 by Sniper Ninja" for graphics_fs_nsb  as #main
#main, "trapclose [quit]"
#main, "when characterInput [keys]"
 'chargement du graphisme
   for i=0 to 9
      loadbmp  i    ,"graph\number\";i;".bmp"
    next i
     loadbmp  "Win"       ,"graph\Win.bmp"
     loadbmp  "Perso"     ,"graph\Perso.bmp"
     loadbmp  "MBloc0"    ,"graph\MBloc0.bmp"
     loadbmp  "MBloc1"    ,"graph\MBloc1.bmp"
     loadbmp  "FreeBloc"  ,"graph\FreeBloc.bmp"
     loadbmp  "FullBloc"  ,"graph\FullBloc.bmp"
     loadbmp  "Piece"     ,"graph\Piece.bmp"
     loadbmp  "A"         ,"graph\Arrow.bmp"
     loadbmp  "Exit"      ,"graph\exit.bmp"
     loadbmp  "Level"     ,"graph\Level.bmp"
     loadbmp  "Continuer" ,"graph\Continuer.bmp"
     loadbmp  "N"         ,"graph\N.bmp"
     loadbmp  "mobile"    ,"graph\mobile.bmp"
     #main , "background mobile"
      call main
  'lecture de touche
  [keys]
  key$=left$(Inkey$, 2)
  if state=0 then call menus else if state=1 then call Level  else if state=2 then call Ingame
  wait
    'd�claration des fonctions et des proc�dures
  'proc�dure de chargement du graphisme
      sub main
     #main , "addsprite New N"
     #main , "addsprite Continuer Continuer"
     #main , "addsprite Level Level"
     #main , "addsprite Exit  Exit"
     #main , "addsprite A A"
     #main ,  "spritexy New       270 053"
     #main ,  "spritexy Continuer 270 153"
     #main ,  "spritexy Level     270 253"
     #main ,  "spritexy Exit      270 353"
     #main ,  "spritexy A         170 070"
     #main ,  "drawsprites"
      end sub
   'procedure de menu
  sub menus
   select case right$(key$,1)
   case chr$(_VK_UP)
    Index=Index-1
   case chr$(_VK_DOWN)
     Index=Index+1
   case "s"
    select case Index
      case 1
     state=2
     call Load Level
     call Initiate
      case 2
     state=2
     call Initiate
      case 3
     state=1
      case 4
     close #main
      end
    end select
  end select
   if Index=0 then Index=4
   if Index=5  then Index=1
  if state=0 then
    #main ,  "spritexy A 170 ";main(Index)
  else
    #main , "removesprite New"
    #main , "removesprite Continuer"
    #main , "removesprite Level"
    #main , "removesprite Exit"
    #main,  "removesprite A";
  end if
  if state=1  then
     if val(Level$)<10 then
      call LevelInitiate  "0" , Right$(Level$,1)
     else
      call LevelInitiate  Left$(Level$,1) , Right$(Level$,1)
    end if
   end if

    #main ,  "drawsprites"
 end sub
  'procedure d'initiation
  sub Initiate
  NumWon=0
  MaxWon=0
  for i=0 to (NumCasex-1)
   for j=0 to (NumCasey-1)
   select case CaseState$(i,j)
       #main , "addsprite ";i;j;1;" FreeBloc"
       #main ,  "spritexy ";i;j;1;" ";(200+(j*33));" ";(100+(i*33))
       #main,  "spritetoback  ";i;j;1

        case "1"
     #main , "addsprite ";i;j;" Piece"
     #main ,  "spritexy ";i;j;" ";(200+(j*33));" ";(100+(i*33))
     #main, "spriteoffset ";i;j;" 8 8 "
     MaxWon=MaxWon+1
       case "2"
    #main , "addsprite ";i;j;" MBloc0"
    #main ,  "spritexy ";i;j;" ";(200+(j*33));" ";(100+(i*33))
       case "3"
     #main , "addsprite ";i;j;" MBloc1"
     #main ,  "spritexy ";i;j;" ";(200+(j*33));" ";(100+(i*33))
       case "4"
     #main , "addsprite ";i;j;" FullBloc"
     #main ,  "spritexy ";i;j;" ";(200+(j*33));" ";(100+(i*33))
        end select
    next j
   next i
  #main , "addsprite Perso Perso"
  #main ,  "spritexy Perso ";(200+((PrevCasey-1)*33));" ";(100+((PrevCasex-1)*33))
  #main ,  "drawsprites"

 end sub

 sub Ingame
   Index=1
  select case right$(key$,1)
   case chr$(_VK_UP)
    call Move  -1,0,-2,0
   case chr$(_VK_DOWN)
     call Move  1,0,2,0
   case chr$(_VK_RIGHT)
     call Move  0,1,0,2
   case chr$(_VK_LEFT)
   call Move   0,-1,0,-2
   case "s"
    state=0
    call LevelClose
   end select
      #main ,  "drawsprites"
   end sub
 sub Level
     select case right$(key$,1)
   case chr$(_VK_UP)
     call AddNumber
   case chr$(_VK_DOWN)
   if val(Level$)<>1 then
    call MinusNumber
   end if
   case "s"
    MaxWon=0
    state=0
   #main , "removesprite Level "
   call main
   Index=1
  end select
   #main , "removesprite Left  "
   #main , "removesprite Right "
   if  state<>0 then
       if val(Level$)<10 then
      call LevelInitiate  "0" , Right$(Level$,1)
     else
      call LevelInitiate  Left$(Level$,1) , Right$(Level$,1)
    end if
   end if
 #main ,  "drawsprites"
end sub
    sub AddSprite  Type$,x,y
  #main , "addsprite ";x-1;y-1;" ";Type$
  #main ,  "spritexy ";x-1;y-1;" ";(200+((y-1)*33));" ";(100+((x-1)*33))
    end sub
    sub RemoveSprite x,y
  #main , "removesprite ";x;y
    end sub
    sub MoveSprite SpriteName$ , x , y
  #main ,  "spritexy ";SpriteName$;" ";(200+((y-1)*33));" ";(100+((x-1)*33))
    end sub
 ' procedure de changement de l'etat de la caisse
    sub CaseStateChange x , y , Value$
  x=x-1
  Rstate$=Left$(Caisse$(x),y-1)
  Lstate$=Mid$(Caisse$(x),y+1,NumCasey-(y))
  Caisse$(x)=Rstate$+Value$+Lstate$
    end sub

   'procedure de mouvement
    sub Move x,y,Nextx, Nexty
  if PrevCasex+x>0 and PrevCasex+x<=NumCasex and PrevCasey+y>0 and PrevCasey+y<=NumCasey  then
        select case CaseState$(PrevCasex+x-1,PrevCasey+y-1)
      case "0","1"
            PrevCasex=PrevCasex+x
            PrevCasey=PrevCasey+y
      call MoveSprite "Perso",PrevCasex,PrevCasey
      case "2"
       if PrevCasex+Nextx>0 and PrevCasex+Nextx<=NumCasex and PrevCasey+Nexty>0 and PrevCasey+Nexty<=NumCasey  then
    select case  CaseState$(PrevCasex+Nextx-1,PrevCasey+Nexty-1)
          case "0","1"
      if CaseState$(PrevCasex-1+Nextx,PrevCasey-1+Nexty)="1" then
         call RemoveSprite PrevCasex-1+Nextx,PrevCasey-1+Nexty
         Value$="3"
          NumWon=NumWon+1
        else
         Value$="2"
       end if
         call RemoveSprite PrevCasex-1+x,PrevCasey-1+y
         call AddSprite  "MBloc"+CaseState$(PrevCasex-1+Nextx,PrevCasey-1+Nexty),PrevCasex+Nextx,PrevCasey+Nexty
         call  CaseStateChange PrevCasex+x , PrevCasey+y ,"0"
         call  CaseStateChange PrevCasex+Nextx , PrevCasey+Nexty ,Value$
          PrevCasex=PrevCasex+x
          PrevCasey=PrevCasey+y
       call MoveSprite "Perso",PrevCasex,PrevCasey

     end select
     end if
        Case "3"
       if PrevCasex+Nextx>0 and PrevCasex+Nextx<=NumCasex and PrevCasey+Nexty>0 and PrevCasey+Nexty<=NumCasey  then
          select case  CaseState$(PrevCasex-1+Nextx,PrevCasey-1+Nexty)
         case "0","1"
       if CaseState$(PrevCasex-1+Nextx,PrevCasey-1+Nexty)="1" then
           call RemoveSprite PrevCasex-1+Nextx,PrevCasey-1+Nexty
         Value$="3"
        else
          NumWon=NumWon-1
          Value$="2"
       end if
    call RemoveSprite PrevCasex-1+x,PrevCasey-1+y
    call AddSprite  "MBloc"+CaseState$(PrevCasex-1+Nextx,PrevCasey-1+Nexty),PrevCasex+Nextx,PrevCasey+Nexty
    call AddSprite  "Piece",PrevCasex+x,PrevCasey+y
    call  CaseStateChange PrevCasex+x , PrevCasey+y ,"1"
    call  CaseStateChange PrevCasex+Nextx , PrevCasey+Nexty ,Value$
          PrevCasex=PrevCasex+x
          PrevCasey=PrevCasey+y
     #main, "spritetoback  ";PrevCasex-1;PrevCasey-1
     #main, "spritetoback  ";(PrevCasex-1);(PrevCasey-1);1
     #main, "spriteoffset  ";PrevCasex-1;PrevCasey-1;" 8 8 "
       call MoveSprite "Perso",PrevCasex,PrevCasey
     end select
       end if
     end select
   end if
      if NumWon=MaxWon then

          call AddNumber
             state=-1
     #main , "background Win"
        'suppression des blocs
    for i=0 to (NumCasex-1)
     for j=0 to (NumCasey-1)
        #main , "removesprite ";i;j;1;
    select case CaseState$(i,j)
       case"0"
      case else
       #main , "removesprite ";i;j;
      end select
      next j
     next i
      #main , "removesprite Perso"
      #main , "drawsprites"
       time=time$("milliseconds")
       while time$("milliseconds")-time<=1000
       wend
      #main , "background mobile"
      call main
      state=0
    end if
 end sub
 ' fonction renvoie l'etat de la case
     function CaseState$  (x , y)
   CaseState$=MID$(Caisse$(x),y+1,1)
     end function

  ' procedure de chargement du niveau
     sub Load Level
      open "Level/Level";Level$;".lvl" for input as #1
          i=0
       while eof(#1)=0
             INPUT #1, Lv$
           i=i+1
        select case i
          case 1
             NumCasex=val(Lv$)
             Dim Caisse$(NumCasex)
           case 2
             NumCasey=val(Lv$)
          case 3
             PrevCasex=val(Lv$)
          case 4
             PrevCasey=val(Lv$)
          case else
          if i<=NumCasex+4 and i>4  then Caisse$(i-5)=Lv$
       end select
       wend
       close #1
    end sub
 Sub LevelClose
   'suppression des blocs
  for i=0 to (NumCasex-1)
   for j=0 to (NumCasey-1)
        #main , "removesprite ";i;j;1;
    select case CaseState$(i,j)
      case"0"
      case else
       #main , "removesprite ";i;j;
      end select
      next j
   next i
  #main , "removesprite Perso"
   ' creation du menu
     call main
 end sub
 sub LevelInitiate  L$ , R$
 #main , "addsprite Level Level"
 #main ,  "spritexy Level       270 053"
 #main , "addsprite Left ";L$
 #main , "spritexy  Left  400 200 "
 #main , "addsprite Right ";R$
 #main , "spritexy  Right 480 200 "
 end sub

sub AddNumber
if val(Level$)=MaxLevel then  Level$="00"

if MaxLevel<>val(Level$) and  val(Level$)< 9   then
          Level$=chr$(val(Left$(Level$,1))+49)
    else
    if MaxLevel<>val(Level$) and  val(Level$)= 9 then
        Level$="10"
       else
         if val(Right$(Level$,1))=9 then
               Level$=chr$(val(Left$(Level$,1))+49)+"0"
             else
          Level$=chr$(val(Left$(Level$,1))+48)+chr$(val(Right$(Level$,1))+49)
         end if
       end if
      end if
end sub
sub MinusNumber
 if val(Level$)<= 9 then
          Level$=chr$(val(Right$(Level$,1))+47)
    else
      if val(Right$(Level$,1))=0 then
               Level$=chr$(val(Left$(Level$,1))+47)+"9"
             else
          Level$=chr$(val(Left$(Level$,1))+48)+chr$(val(Right$(Level$,1))+47)
         end if
       end if
end sub
[quit]
  close #main
  end
