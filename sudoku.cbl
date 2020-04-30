IDENTIFICATION DIVISION.
PROGRAM-ID. Sudoku.
DATA DIVISION.
WORKING-STORAGE SECTION.

01 WS-NEXT           PIC 9(5) VALUE ZERO.
01 WS-LIMIT         PIC 9(5) VALUE 5.
*> 01 MISC-VALUES.
*>     05 IND           PIC 9(5) VALUE ZERO.
*>     05 COUNTER       PIC 9(5) VALUE ZERO.

01 SUDOKU-TABLE.
    05 TABLEX OCCURS 9 TIMES INDEXED BY IDX .
        10 TABLEY OCCURS 9 TIMES INDEXED BY IDY PIC 9(1) VALUE ZERO.

01  SC-RESPONSE   PIC X VALUE SPACE.
    88  RESPONSE-SOLVE   VALUES "S", "s".
    88  RESPONSE-RESET   VALUES "R", "r".
    88  RESPONSE-QUIT   VALUES "Q", "q".

SCREEN SECTION.
01  SUDOKU-SCREEN.
    05  HEADER-SECTION.
        10  VALUE   "ENTER THE VALUES" UNDERLINE BLANK SCREEN    LINE 1 COL 23.

    05  CONTENT-SECTION.
        10  BOX-1-1                               LINE 3 COL 10
                        PIC  9  USING TABLEY(1,1).
        10  BOX-2-1                               LINE 3 COL 13
                        PIC  9  USING TABLEY(2,1).
        10  BOX-3-1                               LINE 3 COL 16
                        PIC  9  USING TABLEY(3,1).
        10  BOX-4-1                               LINE 3 COL 19
                        PIC  9  USING TABLEY(4,1).
        10  BOX-5-1                               LINE 3 COL 22
                        PIC  9  USING TABLEY(5,1).
        10  BOX-6-1                               LINE 3 COL 25
                        PIC  9  USING TABLEY(6,1).
        10  BOX-7-1                               LINE 3 COL 28
                        PIC  9  USING TABLEY(7,1).
        10  BOX-8-1                               LINE 3 COL 31
                        PIC  9  USING TABLEY(8,1).
        10  BOX-9-1                               LINE 3 COL 34
                        PIC  9  USING TABLEY(9,1).
        10  BOX-1-2                               LINE 5 COL 10
                        PIC  9  USING TABLEY(1,2).
        10  BOX-2-2                               LINE 5 COL 13
                        PIC  9  USING TABLEY(2,2).
        10  BOX-3-2                               LINE 5 COL 16
                        PIC  9  USING TABLEY(3,2).
        10  BOX-4-2                               LINE 5 COL 19
                        PIC  9  USING TABLEY(4,2).
        10  BOX-5-2                               LINE 5 COL 22
                        PIC  9  USING TABLEY(5,2).
        10  BOX-6-2                               LINE 5 COL 25
                        PIC  9  USING TABLEY(6,2).
        10  BOX-7-2                               LINE 5 COL 28
                        PIC  9  USING TABLEY(7,2).
        10  BOX-8-2                               LINE 5 COL 31
                        PIC  9  USING TABLEY(8,2).
        10  BOX-9-2                               LINE 5 COL 34
                        PIC  9  USING TABLEY(9,2).
        10  BOX-1-2                               LINE 7 COL 10
                        PIC  9  USING TABLEY(1,3).
        10  BOX-2-2                               LINE 7 COL 13
                        PIC  9  USING TABLEY(2,3).
        10  BOX-3-2                               LINE 7 COL 16
                        PIC  9  USING TABLEY(3,3).
        10  BOX-4-2                               LINE 7 COL 19
                        PIC  9  USING TABLEY(4,3).
        10  BOX-5-2                               LINE 7 COL 22
                        PIC  9  USING TABLEY(5,3).
        10  BOX-6-2                               LINE 7 COL 25
                        PIC  9  USING TABLEY(6,3).
        10  BOX-7-2                               LINE 7 COL 28
                        PIC  9  USING TABLEY(7,3).
        10  BOX-8-2                               LINE 7 COL 31
                        PIC  9  USING TABLEY(8,3).
        10  BOX-9-2                               LINE 7 COL 34
                        PIC  9  USING TABLEY(9,3).
        10  LINE-DIVIDER                          LINE 8 COL 10
            VALUE "-------------------------".

        10  BOX-1-2                               LINE 9 COL 10
                        PIC  9  USING TABLEY(1,4).
        10  BOX-2-2                               LINE 9 COL 13
                        PIC  9  USING TABLEY(2,4).
        10  BOX-3-2                               LINE 9 COL 16
                        PIC  9  USING TABLEY(3,4).
        10  BOX-4-2                               LINE 9 COL 19
                        PIC  9  USING TABLEY(4,4).
        10  BOX-5-2                               LINE 9 COL 22
                        PIC  9  USING TABLEY(5,4).
        10  BOX-6-2                               LINE 9 COL 25
                        PIC  9  USING TABLEY(6,4).
        10  BOX-7-2                               LINE 9 COL 28
                        PIC  9  USING TABLEY(7,4).
        10  BOX-8-2                               LINE 9 COL 31
                        PIC  9  USING TABLEY(8,4).
        10  BOX-9-2                               LINE 9 COL 34
                        PIC  9  USING TABLEY(9,4).
        10  BOX-1-2                               LINE 11 COL 10
                        PIC  9  USING TABLEY(1,5).
        10  BOX-2-2                               LINE 11 COL 13
                        PIC  9  USING TABLEY(2,5).
        10  BOX-3-2                               LINE 11 COL 16
                        PIC  9  USING TABLEY(3,5).
        10  BOX-4-2                               LINE 11 COL 19
                        PIC  9  USING TABLEY(4,5).
        10  BOX-5-2                               LINE 11 COL 22
                        PIC  9  USING TABLEY(5,5).
        10  BOX-6-2                               LINE 11 COL 25
                        PIC  9  USING TABLEY(6,5).
        10  BOX-7-2                               LINE 11 COL 28
                        PIC  9  USING TABLEY(7,5).
        10  BOX-8-2                               LINE 11 COL 31
                        PIC  9  USING TABLEY(8,5).
        10  BOX-9-2                               LINE 11 COL 34
                        PIC  9  USING TABLEY(9,5).
        10  BOX-1-2                               LINE 13 COL 10
                        PIC  9  USING TABLEY(1,6).
        10  BOX-2-2                               LINE 13 COL 13
                        PIC  9  USING TABLEY(2,6).
        10  BOX-3-2                               LINE 13 COL 16
                        PIC  9  USING TABLEY(3,6).
        10  BOX-4-2                               LINE 13 COL 19
                        PIC  9  USING TABLEY(4,6).
        10  BOX-5-2                               LINE 13 COL 22
                        PIC  9  USING TABLEY(5,6).
        10  BOX-6-2                               LINE 13 COL 25
                        PIC  9  USING TABLEY(6,6).
        10  BOX-7-2                               LINE 13 COL 28
                        PIC  9  USING TABLEY(7,6).
        10  BOX-8-2                               LINE 13 COL 31
                        PIC  9  USING TABLEY(8,6).
        10  BOX-9-2                               LINE 13 COL 34
                        PIC  9  USING TABLEY(9,6).

        10  LINE-DIVIDER                          LINE 14 COL 10
                VALUE "-------------------------".
    *> ==================
        10  BOX-1-2                               LINE 15 COL 10
                        PIC  9  USING TABLEY(1,7).
        10  BOX-2-2                               LINE 15 COL 13
                        PIC  9  USING TABLEY(2,7).
        10  BOX-3-2                               LINE 15 COL 16
                        PIC  9  USING TABLEY(3,7).
        10  BOX-4-2                               LINE 15 COL 19
                        PIC  9  USING TABLEY(4,7).
        10  BOX-5-2                               LINE 15 COL 22
                        PIC  9  USING TABLEY(5,7).
        10  BOX-6-2                               LINE 15 COL 25
                        PIC  9  USING TABLEY(6,7).
        10  BOX-7-2                               LINE 15 COL 28
                        PIC  9  USING TABLEY(7,7).
        10  BOX-8-2                               LINE 15 COL 31
                        PIC  9  USING TABLEY(8,7).
        10  BOX-9-2                               LINE 15 COL 34
                        PIC  9  USING TABLEY(9,7).
        10  BOX-1-2                               LINE 17 COL 10
                        PIC  9  USING TABLEY(1,8).
        10  BOX-2-2                               LINE 17 COL 13
                        PIC  9  USING TABLEY(2,8).
        10  BOX-3-2                               LINE 17 COL 16
                        PIC  9  USING TABLEY(3,8).
        10  BOX-4-2                               LINE 17 COL 19
                        PIC  9  USING TABLEY(4,8).
        10  BOX-5-2                               LINE 17 COL 22
                        PIC  9  USING TABLEY(5,8).
        10  BOX-6-2                               LINE 17 COL 25
                        PIC  9  USING TABLEY(6,8).
        10  BOX-7-2                               LINE 17 COL 28
                        PIC  9  USING TABLEY(7,8).
        10  BOX-8-2                               LINE 17 COL 31
                        PIC  9  USING TABLEY(8,8).
        10  BOX-9-2                               LINE 17 COL 34
                        PIC  9  USING TABLEY(9,8).
        10  BOX-1-2                               LINE 19 COL 10
                        PIC  9  USING TABLEY(1,9).
        10  BOX-2-2                               LINE 19 COL 13
                        PIC  9  USING TABLEY(2,9).
        10  BOX-3-2                               LINE 19 COL 16
                        PIC  9  USING TABLEY(3,9).
        10  BOX-4-2                               LINE 19 COL 19
                        PIC  9  USING TABLEY(4,9).
        10  BOX-5-2                               LINE 19 COL 22
                        PIC  9  USING TABLEY(5,9).
        10  BOX-6-2                               LINE 19 COL 25
                        PIC  9  USING TABLEY(6,9).
        10  BOX-7-2                               LINE 19 COL 28
                        PIC  9  USING TABLEY(7,9).
        10  BOX-8-2                               LINE 19 COL 31
                        PIC  9  USING TABLEY(8,9).
        10  BOX-9-2                               LINE 19 COL 34
                        PIC  9  USING TABLEY(9,9).

        10  V-DIVIDER VALUE "|"   LINE 3 COL 18.
        10  V-DIVIDER VALUE "|"   LINE 3 COL 26.

    05 BOTTOM-SECTION.
        10  VALUE "R - RESET"                           LINE 22 COL 30.
        10  VALUE "S - SOLVE"                           LINE 23 COL 30.
        10  VALUE "Q - TO QUIT"                         LINE 24 COL 30.
        10  VALUE "ENTER RESPONSE"                      LINE 25 COL 30.
        10  RESPONSE-INPUT                              LINE 25 COL 45
                    PIC X    AUTO    TO SC-RESPONSE.

01  BLANK-SCREEN.
    05 BLANK SCREEN                foreground-color 2
               background-color 0.

PROCEDURE DIVISION.

MAIN.
    PERFORM DISPLAY-SCREEN
    *> PERFORM SHOW-CONTENT

    CALL 'TABLE-ANALYSIS' USING SUDOKU-TABLE

    PERFORM FINISH
.

DISPLAY-SCREEN.
    PERFORM SCREEN-LOOP UNTIL RESPONSE-SOLVE
    DISPLAY BLANK-SCREEN
.

SCREEN-LOOP.
    DISPLAY SUDOKU-SCREEN
    ACCEPT SUDOKU-SCREEN

    IF RESPONSE-RESET THEN
        PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 9
            PERFORM VARYING IDY FROM 1 BY 1 UNTIL IDY > 9
                MOVE ZERO TO TABLEY(IDX,IDY)
            END-PERFORM
        END-PERFORM
    END-IF
    IF RESPONSE-QUIT THEN
        PERFORM FINISH
    END-IF
.

*> SHOW-CONTENT.
*>     DISPLAY "Content"
*>     PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 9
*>         PERFORM VARYING IDY FROM 1 BY 1 UNTIL IDY > 9
*>             DISPLAY IDX, IDY, TABLEY(IDX,IDY)
*>         END-PERFORM
*>     END-PERFORM
*> .

FINISH.
    STOP RUN
.




END PROGRAM Sudoku.

Program-Id. TABLE-ANALYSIS RECURSIVE.
ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.
01  numb    pic 9(4)  value 5.
01  fact    pic 9(8)  value 0.
LOCAL-STORAGE SECTION.
01  LIDX    pic 9(4).
01  LIDY    PIC 9(5).

LINKAGE SECTION.
01 SUDOKU-TABLE.
    05 TABLEX OCCURS 9 TIMES INDEXED BY IDX.
        10 TABLEY OCCURS 9 TIMES INDEXED BY IDY PIC 9(1).

PROCEDURE DIVISION USING SUDOKU-TABLE.

*> DISPLAY "i'm program calc-comething".

MAIN.
    
    IF TABLEY(1,1) = 5
        DISPLAY "Success"
    END-IF

GOBACK.

END PROGRAM TABLE-ANALYSIS.


