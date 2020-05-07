   Caisse$(0)="4400010000"
   Caisse$(1)="0004424400"
   Caisse$(2)="0021010124"
   Caisse$(3)="4024424404"
   Caisse$(4)="4000010004"
   Caisse$(5)=""
   Caisse$(6)=""
   Caisse$(7)=""
   Caisse$(8)=""
   NumCasex=5
   NumCasey=10
   PrevCasex=3
   PrevCasey=2

 open "Level/level11.lvl" for output as #1
          i=0
       while i<>(NumCasex+4)
          i=i+1
      select case i
          case 1
            print #1, NumCasex
          case 2
            print #1, NumCasey
          case 3
             print #1,PrevCasex
          case 4
            print #1, PrevCasey
          case else
          print #1,Caisse$(i-5)
       end select
      wend
   close #1

