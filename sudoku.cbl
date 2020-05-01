IDENTIFICATION DIVISION.
PROGRAM-ID. Sudoku.
DATA DIVISION.
WORKING-STORAGE SECTION.

01 WS-NEXT          PIC X VALUE SPACE.
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
                        PIC  9  USING TABLEY(1,2).
        10  BOX-3-1                               LINE 3 COL 16
                        PIC  9  USING TABLEY(1,3).
        10  BOX-4-1                               LINE 3 COL 19
                        PIC  9  USING TABLEY(1,4).
        10  BOX-5-1                               LINE 3 COL 22
                        PIC  9  USING TABLEY(1,5).
        10  BOX-6-1                               LINE 3 COL 25
                        PIC  9  USING TABLEY(1,6).
        10  BOX-7-1                               LINE 3 COL 28
                        PIC  9  USING TABLEY(1,7).
        10  BOX-8-1                               LINE 3 COL 31
                        PIC  9  USING TABLEY(1,8).
        10  BOX-9-1                               LINE 3 COL 34
                        PIC  9  USING TABLEY(1,9).
        10  BOX-1-2                               LINE 5 COL 10
                        PIC  9  USING TABLEY(2,1).
        10  BOX-2-2                               LINE 5 COL 13
                        PIC  9  USING TABLEY(2,2).
        10  BOX-3-2                               LINE 5 COL 16
                        PIC  9  USING TABLEY(2,3).
        10  BOX-4-2                               LINE 5 COL 19
                        PIC  9  USING TABLEY(2,4).
        10  BOX-5-2                               LINE 5 COL 22
                        PIC  9  USING TABLEY(2,5).
        10  BOX-6-2                               LINE 5 COL 25
                        PIC  9  USING TABLEY(2,6).
        10  BOX-7-2                               LINE 5 COL 28
                        PIC  9  USING TABLEY(2,7).
        10  BOX-8-2                               LINE 5 COL 31
                        PIC  9  USING TABLEY(2,8).
        10  BOX-9-2                               LINE 5 COL 34
                        PIC  9  USING TABLEY(2,9).
        10  BOX-1-3                               LINE 7 COL 10
                        PIC  9  USING TABLEY(3,1).
        10  BOX-2-3                               LINE 7 COL 13
                        PIC  9  USING TABLEY(3,2).
        10  BOX-3-3                               LINE 7 COL 16
                        PIC  9  USING TABLEY(3,3).
        10  BOX-4-3                               LINE 7 COL 19
                        PIC  9  USING TABLEY(3,4).
        10  BOX-5-3                               LINE 7 COL 22
                        PIC  9  USING TABLEY(3,5).
        10  BOX-6-3                               LINE 7 COL 25
                        PIC  9  USING TABLEY(3,6).
        10  BOX-7-3                               LINE 7 COL 28
                        PIC  9  USING TABLEY(3,7).
        10  BOX-8-3                               LINE 7 COL 31
                        PIC  9  USING TABLEY(3,8).
        10  BOX-9-3                               LINE 7 COL 34
                        PIC  9  USING TABLEY(3,9).
        10  LINE-DIVIDER                          LINE 8 COL 10
            VALUE "-------------------------".

        10  BOX-1-4                               LINE 9 COL 10
                        PIC  9  USING TABLEY(4,1).
        10  BOX-2-4                               LINE 9 COL 13
                        PIC  9  USING TABLEY(4,2).
        10  BOX-3-4                               LINE 9 COL 16
                        PIC  9  USING TABLEY(4,3).
        10  BOX-4-4                               LINE 9 COL 19
                        PIC  9  USING TABLEY(4,4).
        10  BOX-5-4                               LINE 9 COL 22
                        PIC  9  USING TABLEY(4,5).
        10  BOX-6-4                               LINE 9 COL 25
                        PIC  9  USING TABLEY(4,6).
        10  BOX-7-4                               LINE 9 COL 28
                        PIC  9  USING TABLEY(4,7).
        10  BOX-8-4                               LINE 9 COL 31
                        PIC  9  USING TABLEY(4,8).
        10  BOX-9-4                               LINE 9 COL 34
                        PIC  9  USING TABLEY(4,9).
        10  BOX-1-5                               LINE 11 COL 10
                        PIC  9  USING TABLEY(5,1).
        10  BOX-2-5                               LINE 11 COL 13
                        PIC  9  USING TABLEY(5,2).
        10  BOX-3-5                               LINE 11 COL 16
                        PIC  9  USING TABLEY(5,3).
        10  BOX-4-5                               LINE 11 COL 19
                        PIC  9  USING TABLEY(5,4).
        10  BOX-5-5                               LINE 11 COL 22
                        PIC  9  USING TABLEY(5,5).
        10  BOX-6-5                               LINE 11 COL 25
                        PIC  9  USING TABLEY(5,6).
        10  BOX-7-5                               LINE 11 COL 28
                        PIC  9  USING TABLEY(5,7).
        10  BOX-8-5                               LINE 11 COL 31
                        PIC  9  USING TABLEY(5,8).
        10  BOX-9-5                               LINE 11 COL 34
                        PIC  9  USING TABLEY(5,9).
        10  BOX-1-6                               LINE 13 COL 10
                        PIC  9  USING TABLEY(6,1).
        10  BOX-2-6                               LINE 13 COL 13
                        PIC  9  USING TABLEY(6,2).
        10  BOX-3-6                               LINE 13 COL 16
                        PIC  9  USING TABLEY(6,3).
        10  BOX-4-6                               LINE 13 COL 19
                        PIC  9  USING TABLEY(6,4).
        10  BOX-5-6                               LINE 13 COL 22
                        PIC  9  USING TABLEY(6,5).
        10  BOX-6-6                               LINE 13 COL 25
                        PIC  9  USING TABLEY(6,6).
        10  BOX-7-6                               LINE 13 COL 28
                        PIC  9  USING TABLEY(6,7).
        10  BOX-8-6                               LINE 13 COL 31
                        PIC  9  USING TABLEY(6,8).
        10  BOX-9-6                               LINE 13 COL 34
                        PIC  9  USING TABLEY(6,9).

        10  LINE-DIVIDER                          LINE 14 COL 10
                VALUE "-------------------------".
    *> ==================
        10  BOX-1-7                               LINE 15 COL 10
                        PIC  9  USING TABLEY(7,1).
        10  BOX-2-7                               LINE 15 COL 13
                        PIC  9  USING TABLEY(7,2).
        10  BOX-3-7                               LINE 15 COL 16
                        PIC  9  USING TABLEY(7,3).
        10  BOX-4-7                               LINE 15 COL 19
                        PIC  9  USING TABLEY(7,4).
        10  BOX-5-7                               LINE 15 COL 22
                        PIC  9  USING TABLEY(7,5).
        10  BOX-6-7                               LINE 15 COL 25
                        PIC  9  USING TABLEY(7,6).
        10  BOX-7-7                               LINE 15 COL 28
                        PIC  9  USING TABLEY(7,7).
        10  BOX-8-7                               LINE 15 COL 31
                        PIC  9  USING TABLEY(7,8).
        10  BOX-9-7                               LINE 15 COL 34
                        PIC  9  USING TABLEY(7,9).
        10  BOX-1-8                               LINE 17 COL 10
                        PIC  9  USING TABLEY(8,1).
        10  BOX-2-8                               LINE 17 COL 13
                        PIC  9  USING TABLEY(8,2).
        10  BOX-3-8                               LINE 17 COL 16
                        PIC  9  USING TABLEY(8,3).
        10  BOX-4-8                               LINE 17 COL 19
                        PIC  9  USING TABLEY(8,4).
        10  BOX-5-8                               LINE 17 COL 22
                        PIC  9  USING TABLEY(8,5).
        10  BOX-6-8                               LINE 17 COL 25
                        PIC  9  USING TABLEY(8,6).
        10  BOX-7-8                               LINE 17 COL 28
                        PIC  9  USING TABLEY(8,7).
        10  BOX-8-8                               LINE 17 COL 31
                        PIC  9  USING TABLEY(8,8).
        10  BOX-9-8                               LINE 17 COL 34
                        PIC  9  USING TABLEY(8,9).
        10  BOX-1-9                               LINE 19 COL 10
                        PIC  9  USING TABLEY(9,1).
        10  BOX-2-9                               LINE 19 COL 13
                        PIC  9  USING TABLEY(9,2).
        10  BOX-3-9                               LINE 19 COL 16
                        PIC  9  USING TABLEY(9,3).
        10  BOX-4-9                               LINE 19 COL 19
                        PIC  9  USING TABLEY(9,4).
        10  BOX-5-9                               LINE 19 COL 22
                        PIC  9  USING TABLEY(9,5).
        10  BOX-6-9                               LINE 19 COL 25
                        PIC  9  USING TABLEY(9,6).
        10  BOX-7-9                               LINE 19 COL 28
                        PIC  9  USING TABLEY(9,7).
        10  BOX-8-9                               LINE 19 COL 31
                        PIC  9  USING TABLEY(9,8).
        10  BOX-9-9                               LINE 19 COL 34
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
    *> PERFORM DISPLAY-SCREEN
    PERFORM FILL-TEST-DATA
    PERFORM SHOW-CONTENT

    *> CALL 'TABLE-ANALYSIS' USING SUDOKU-TABLE

    PERFORM SHOW-CONTENT

*> FIX-ME
    *> PERFORM DISPLAY-SCREEN
    *> ACCEPT SUDOKU-SCREEN

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

FINISH.
    STOP RUN
.

FILL-TEST-DATA.
    MOVE "003000617" TO TABLEX(1)
    MOVE "041705300" TO TABLEX(2)
    MOVE "807601000" TO TABLEX(3)
    MOVE "000060003" TO TABLEX(4)
    MOVE "700000004" TO TABLEX(5)
    MOVE "038107920" TO TABLEX(6)
    MOVE "076029000" TO TABLEX(7)
    MOVE "054806090" TO TABLEX(8)
    MOVE "000003765" TO TABLEX(9)
.
SHOW-CONTENT.
    DISPLAY "Content" X"0D"
    PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 9
        PERFORM VARYING IDY FROM 1 BY 1 UNTIL IDY > 9
            DISPLAY TABLEY(IDX,IDY) SPACE WITH NO ADVANCING
        END-PERFORM
        DISPLAY X"0D"
    END-PERFORM

    ACCEPT WS-NEXT LINE 12
.



END PROGRAM Sudoku.

Program-Id. TABLE-ANALYSIS RECURSIVE.
ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.
01  LEVEL    pic 9(4)  value 5.
LOCAL-STORAGE SECTION.

01  CELL-VALUES OCCURS 9 TIMES INDEXED BY CIDX PIC 9.


01  LIDX    PIC 9(4).
01  LIDY    PIC 9(5).

01  TIDX    PIC 9(4).
01  TIDY    PIC 9(5).

01  TIDX-LIM    PIC 9(4).
01  TIDY-LIM    PIC 9(5).

01  TEST-RES    PIC 9 VALUE ZERO.
    88  TEST-RES-OK VALUE ZERO.

LINKAGE SECTION.
01 SUDOKU-TABLE.
    05 TABLEX OCCURS 9 TIMES INDEXED BY IDX.
        10 TABLEY OCCURS 9 TIMES INDEXED BY IDY PIC 9(1).

PROCEDURE DIVISION USING SUDOKU-TABLE.

*> DISPLAY "i'm program calc-comething".

MAIN.
    
    PERFORM INITIATE-CELL-VALUES

    PERFORM VARYING LIDX FROM 1 BY 1 UNTIL LIDX > 9
        PERFORM VARYING LIDY FROM 1 BY 1 UNTIL LIDY > 9
            IF TABLEY(LIDX,LIDY) <> ZERO THEN
                PERFORM INSERT-CELL-VALUE
                PERFORM RESET-CELL-VALUE
        END-PERFORM
    END-PERFORM


GOBACK.

INITIATE-CELL-VALUES.
    PERFORM VARYING CIDX FROM 1 BY 1 UNTIL  CIDX > 9
        MOVE CIDX TO CELL-VALUES(CIDX)
    END-PERFORM
.

INSERT-CELL-VALUE.
    PERFORM VARYING CIDX FROM 1 BY 1 UNTIL CIDX > 9
        PERFORM TEST-HORIZONTALLY
        PERFORM TEST-VERTICALLY
        PERFORM TEST-SQUARE

        IF TEST-RES-OK THEN
            MOVE CELL-VALUES(CIDX) TO TABLEY(LIDX,LIDY)
            *> make recurent call, with updated data
            CALL 'TABLE-ANALYSIS' USING SUDOKU-TABLE   
        END-IF
    END-PERFORM
.

TEST-HORIZONTALLY.
    *> if value found in the horizontal row, indicate it TEST-RES
    PERFORM VARYING TIDX FROM 1 BY 1 UNTIL TIDX > 9
        IF TABLEY(TIDX, LIDY) = CELL-VALUES(CIDX) THEN 
            ADD 1 TO TEST-RES
        END-IF
    END-PERFORM 
.
TEST-VERTICALLY.
    *> if value found in the vertical row, indicate it TEST-RES
    PERFORM VARYING TIDY FROM 1 BY 1 UNTIL TIDX > 9
        IF TABLEY(LIDX, TIDY) = CELL-VALUES(CIDX) THEN 
            ADD 2 TO TEST-RES
        END-IF
    END-PERFORM 
.

TEST-SQUARE.

    DIVIDE LIDX BY 3 GIVING TIDX
    DIVIDE LIDY BY 3 GIVING TIDY

    MULTIPLY 3 BY TIDX
    MULTIPLY 3 BY TIDY
 
    ADD 2 TO TIDX GIVING TIDX-LIM
    ADD 2 TO TIDY GIVING TIDY-LIM

    PERFORM VARYING TIDX FROM TIDX BY 1 UNTIL TIDX > TIDX-LIM
        PERFORM VARYING TIDY FROM TIDY BY 1 UNTIL TIDY > TIDY-LIM
            IF TABLEY(TIDX,TIDY) = CELL-VALUES(CIDX) THEN 
                ADD 4 TO TEST-RES
            END-IF
        END-PERFORM
    END-PERFORM
.

RESET-CELL-VALUE.
    MOVE ZERO TO TABLEY(LIDX,LIDY)
.

END PROGRAM TABLE-ANALYSIS.


