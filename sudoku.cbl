IDENTIFICATION DIVISION.
PROGRAM-ID. Sudoku.
DATA DIVISION.
WORKING-STORAGE SECTION.

01 PRESS-ENTER      PIC X VALUE SPACE.

01 SUDOKU-TABLE.
    05 TABLEX OCCURS 9 TIMES INDEXED BY IDX .
        10 TABLEY OCCURS 9 TIMES INDEXED BY IDY PIC 9(1) VALUE ZERO.

01 SOLUTIONS-COUNTER PIC 9(4).
01 STEPS-COUNTER PIC 9(9) VALUE ZERO.

01  SC-RESPONSE   PIC X VALUE SPACE.
    88  RESPONSE-SOLVE   VALUES "S", "s".
    88  RESPONSE-TEST    VALUES "T", "t".
    88  RESPONSE-REFRESH VALUES "R", "r".
    88  RESPONSE-RESET   VALUES "X", "x".
    88  RESPONSE-QUIT    VALUES "Q", "q".

SCREEN SECTION.
01  SUDOKU-SCREEN.
    05  HEADER-SECTION.
        10  VALUE "ENTER KNOWN VALUES" UNDERLINE BLANK SCREEN    LINE 1 COL 12.

        05  CONTENT-SECTION.
            10  BOX-1-1                               LINE 3 COL 5
                            PIC  9  BLANK WHEN ZERO USING TABLEY(1,1).
            10  BOX-2-1                               LINE 3 COL 9
                            PIC  9  BLANK WHEN ZERO USING TABLEY(1,2).
            10  BOX-3-1                               LINE 3 COL 13 
                            PIC  9  BLANK WHEN ZERO USING TABLEY(1,3).
            10  BOX-4-1                               LINE 3 COL 17
                            PIC  9  BLANK WHEN ZERO USING TABLEY(1,4).
            10  BOX-5-1                               LINE 3 COL 21
                            PIC  9  BLANK WHEN ZERO USING TABLEY(1,5).
            10  BOX-6-1                               LINE 3 COL 25
                            PIC  9  BLANK WHEN ZERO USING TABLEY(1,6).
            10  BOX-7-1                               LINE 3 COL 29
                            PIC  9  BLANK WHEN ZERO USING TABLEY(1,7).
            10  BOX-8-1                               LINE 3 COL 33
                            PIC  9  BLANK WHEN ZERO USING TABLEY(1,8).
            10  BOX-9-1                               LINE 3 COL 37
                            PIC  9  BLANK WHEN ZERO USING TABLEY(1,9).
            10  BOX-1-2                               LINE 5 COL 5
                            PIC  9  BLANK WHEN ZERO USING TABLEY(2,1).
            10  BOX-2-2                               LINE 5 COL 9
                            PIC  9  BLANK WHEN ZERO USING TABLEY(2,2).
            10  BOX-3-2                               LINE 5 COL 13
                            PIC  9  BLANK WHEN ZERO USING TABLEY(2,3).
            10  BOX-4-2                               LINE 5 COL 17
                            PIC  9  BLANK WHEN ZERO USING TABLEY(2,4).
            10  BOX-5-2                               LINE 5 COL 21
                            PIC  9  BLANK WHEN ZERO USING TABLEY(2,5).
            10  BOX-6-2                               LINE 5 COL 25
                            PIC  9  BLANK WHEN ZERO USING TABLEY(2,6).
            10  BOX-7-2                               LINE 5 COL 29
                            PIC  9  BLANK WHEN ZERO USING TABLEY(2,7).
            10  BOX-8-2                               LINE 5 COL 33
                            PIC  9  BLANK WHEN ZERO USING TABLEY(2,8).
            10  BOX-9-2                               LINE 5 COL 37
                            PIC  9  BLANK WHEN ZERO USING TABLEY(2,9).
            10  BOX-1-3                               LINE 7 COL 5
                            PIC  9  BLANK WHEN ZERO USING TABLEY(3,1).
            10  BOX-2-3                               LINE 7 COL 9
                            PIC  9  BLANK WHEN ZERO USING TABLEY(3,2).
            10  BOX-3-3                               LINE 7 COL 13
                            PIC  9  BLANK WHEN ZERO USING TABLEY(3,3).
            10  BOX-4-3                               LINE 7 COL 17
                            PIC  9  BLANK WHEN ZERO USING TABLEY(3,4).
            10  BOX-5-3                               LINE 7 COL 21
                            PIC  9  BLANK WHEN ZERO USING TABLEY(3,5).
            10  BOX-6-3                               LINE 7 COL 25
                            PIC  9  BLANK WHEN ZERO USING TABLEY(3,6).
            10  BOX-7-3                               LINE 7 COL 29
                            PIC  9  BLANK WHEN ZERO USING TABLEY(3,7).
            10  BOX-8-3                               LINE 7 COL 33
                            PIC  9  BLANK WHEN ZERO USING TABLEY(3,8).
            10  BOX-9-3                               LINE 7 COL 37
                            PIC  9  BLANK WHEN ZERO USING TABLEY(3,9).
        *> ==================
            10  BOX-1-4                               LINE 9 COL 5
                            PIC  9  BLANK WHEN ZERO USING TABLEY(4,1).
            10  BOX-2-4                               LINE 9 COL 9
                            PIC  9  BLANK WHEN ZERO USING TABLEY(4,2).
            10  BOX-3-4                               LINE 9 COL 13
                            PIC  9  BLANK WHEN ZERO USING TABLEY(4,3).
            10  BOX-4-4                               LINE 9 COL 17
                            PIC  9  BLANK WHEN ZERO USING TABLEY(4,4).
            10  BOX-5-4                               LINE 9 COL 21
                            PIC  9  BLANK WHEN ZERO USING TABLEY(4,5).
            10  BOX-6-4                               LINE 9 COL 25
                            PIC  9  BLANK WHEN ZERO USING TABLEY(4,6).
            10  BOX-7-4                               LINE 9 COL 29
                            PIC  9  BLANK WHEN ZERO USING TABLEY(4,7).
            10  BOX-8-4                               LINE 9 COL 33
                            PIC  9  BLANK WHEN ZERO USING TABLEY(4,8).
            10  BOX-9-4                               LINE 9 COL 37
                            PIC  9  BLANK WHEN ZERO USING TABLEY(4,9).
            10  BOX-1-5                               LINE 11 COL 5
                            PIC  9  BLANK WHEN ZERO USING TABLEY(5,1).
            10  BOX-2-5                               LINE 11 COL 9
                            PIC  9  BLANK WHEN ZERO USING TABLEY(5,2).
            10  BOX-3-5                               LINE 11 COL 13
                            PIC  9  BLANK WHEN ZERO USING TABLEY(5,3).
            10  BOX-4-5                               LINE 11 COL 17
                            PIC  9  BLANK WHEN ZERO USING TABLEY(5,4).
            10  BOX-5-5                               LINE 11 COL 21
                            PIC  9  BLANK WHEN ZERO USING TABLEY(5,5).
            10  BOX-6-5                               LINE 11 COL 25
                            PIC  9  BLANK WHEN ZERO USING TABLEY(5,6).
            10  BOX-7-5                               LINE 11 COL 29
                            PIC  9  BLANK WHEN ZERO USING TABLEY(5,7).
            10  BOX-8-5                               LINE 11 COL 33
                            PIC  9  BLANK WHEN ZERO USING TABLEY(5,8).
            10  BOX-9-5                               LINE 11 COL 37
                            PIC  9  BLANK WHEN ZERO USING TABLEY(5,9).
            10  BOX-1-6                               LINE 13 COL 5
                            PIC  9  BLANK WHEN ZERO USING TABLEY(6,1).
            10  BOX-2-6                               LINE 13 COL 9
                            PIC  9  BLANK WHEN ZERO USING TABLEY(6,2).
            10  BOX-3-6                               LINE 13 COL 13
                            PIC  9  BLANK WHEN ZERO USING TABLEY(6,3).
            10  BOX-4-6                               LINE 13 COL 17
                            PIC  9  BLANK WHEN ZERO USING TABLEY(6,4).
            10  BOX-5-6                               LINE 13 COL 21
                            PIC  9  BLANK WHEN ZERO USING TABLEY(6,5).
            10  BOX-6-6                               LINE 13 COL 25
                            PIC  9  BLANK WHEN ZERO USING TABLEY(6,6).
            10  BOX-7-6                               LINE 13 COL 29
                            PIC  9  BLANK WHEN ZERO USING TABLEY(6,7).
            10  BOX-8-6                               LINE 13 COL 33
                            PIC  9  BLANK WHEN ZERO USING TABLEY(6,8).
            10  BOX-9-6                               LINE 13 COL 37
                            PIC  9  BLANK WHEN ZERO USING TABLEY(6,9).
        *> ==================
            10  BOX-1-7                               LINE 15 COL 5
                            PIC  9  BLANK WHEN ZERO USING TABLEY(7,1).
            10  BOX-2-7                               LINE 15 COL 9
                            PIC  9  BLANK WHEN ZERO USING TABLEY(7,2).
            10  BOX-3-7                               LINE 15 COL 13
                            PIC  9  BLANK WHEN ZERO USING TABLEY(7,3).
            10  BOX-4-7                               LINE 15 COL 17
                            PIC  9  BLANK WHEN ZERO USING TABLEY(7,4).
            10  BOX-5-7                               LINE 15 COL 21
                            PIC  9  BLANK WHEN ZERO USING TABLEY(7,5).
            10  BOX-6-7                               LINE 15 COL 25
                            PIC  9  BLANK WHEN ZERO USING TABLEY(7,6).
            10  BOX-7-7                               LINE 15 COL 29
                            PIC  9  BLANK WHEN ZERO USING TABLEY(7,7).
            10  BOX-8-7                               LINE 15 COL 33
                            PIC  9  BLANK WHEN ZERO USING TABLEY(7,8).
            10  BOX-9-7                               LINE 15 COL 37
                            PIC  9  BLANK WHEN ZERO USING TABLEY(7,9).
            10  BOX-1-8                               LINE 17 COL 5
                            PIC  9  BLANK WHEN ZERO USING TABLEY(8,1).
            10  BOX-2-8                               LINE 17 COL 9
                            PIC  9  BLANK WHEN ZERO USING TABLEY(8,2).
            10  BOX-3-8                               LINE 17 COL 13
                            PIC  9  BLANK WHEN ZERO USING TABLEY(8,3).
            10  BOX-4-8                               LINE 17 COL 17
                            PIC  9  BLANK WHEN ZERO USING TABLEY(8,4).
            10  BOX-5-8                               LINE 17 COL 21
                            PIC  9  BLANK WHEN ZERO USING TABLEY(8,5).
            10  BOX-6-8                               LINE 17 COL 25
                            PIC  9  BLANK WHEN ZERO USING TABLEY(8,6).
            10  BOX-7-8                               LINE 17 COL 29
                            PIC  9  BLANK WHEN ZERO USING TABLEY(8,7).
            10  BOX-8-8                               LINE 17 COL 33
                            PIC  9  BLANK WHEN ZERO USING TABLEY(8,8).
            10  BOX-9-8                               LINE 17 COL 37
                            PIC  9  BLANK WHEN ZERO USING TABLEY(8,9).
            10  BOX-1-9                               LINE 19 COL 5
                            PIC  9  BLANK WHEN ZERO USING TABLEY(9,1).
            10  BOX-2-9                               LINE 19 COL 9
                            PIC  9  BLANK WHEN ZERO USING TABLEY(9,2).
            10  BOX-3-9                               LINE 19 COL 13
                            PIC  9  BLANK WHEN ZERO USING TABLEY(9,3).
            10  BOX-4-9                               LINE 19 COL 17
                            PIC  9  BLANK WHEN ZERO USING TABLEY(9,4).
            10  BOX-5-9                               LINE 19 COL 21
                            PIC  9  BLANK WHEN ZERO USING TABLEY(9,5).
            10  BOX-6-9                               LINE 19 COL 25
                            PIC  9  BLANK WHEN ZERO USING TABLEY(9,6).
            10  BOX-7-9                               LINE 19 COL 29
                            PIC  9  BLANK WHEN ZERO USING TABLEY(9,7).
            10  BOX-8-9                               LINE 19 COL 33
                            PIC  9  BLANK WHEN ZERO USING TABLEY(9,8).
            10  BOX-9-9                               LINE 19 COL 37
                            PIC  9  BLANK WHEN ZERO USING TABLEY(9,9).
    
    05  SCREEN-DIVIDERS FOREGROUND-COLOR 3 .
        COPY "sudoku-dividers.cbl".

    05 BOTTOM-SECTION.
        10  VALUE "0 = EMPTY CELL"                      LINE 21 COL 5.
        10  VALUE "S - SOLVE"                           LINE 22 COL 30.
        10  VALUE "T - TEST DATA"                       LINE 23 COL 30.
        10  VALUE "R - REFRESH"                         LINE 24 COL 30.    
        10  VALUE "X - RESET"                           LINE 25 COL 30.
        10  VALUE "Q - TO QUIT"                         LINE 26 COL 30.
        10  VALUE "ENTER RESPONSE:"                     LINE 27 COL 30.
        10  RESPONSE-INPUT                              LINE 27 COL 46
                    PIC X   AUTO        TO SC-RESPONSE.

01  BLANK-SCREEN.
    05 BLANK SCREEN                foreground-color 2
               background-color 0.

PROCEDURE DIVISION.

    PERFORM UNTIL 0 > 1   
        PERFORM DISPLAY-SCREEN
        CALL 'TABLE-ANALYSIS' USING SUDOKU-TABLE, SOLUTIONS-COUNTER, STEPS-COUNTER
        PERFORM SHOW-FINAL-RESULTS
    END-PERFORM
.

DISPLAY-SCREEN.
    PERFORM SCREEN-LOOP UNTIL RESPONSE-SOLVE
    DISPLAY "SOLVING..." FOREGROUND-COLOR 0 BACKGROUND-COLOR 4  LINE 23 COL 7
.
SCREEN-LOOP.
    DISPLAY SUDOKU-SCREEN
    ACCEPT SUDOKU-SCREEN

    IF RESPONSE-RESET THEN
        PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 9
            MOVE "000000000" TO TABLEX(IDX)
        END-PERFORM
    END-IF
    IF RESPONSE-QUIT THEN
        PERFORM FINISH
    END-IF
    IF RESPONSE-TEST THEN
        PERFORM FILL-TEST-DATA
    END-IF
     IF RESPONSE-REFRESH THEN
        PERFORM REFRESH-DATA
    END-IF   
    MOVE SPACE TO RESPONSE-INPUT
.

FINISH.
    STOP RUN
.

FILL-TEST-DATA.
    *> example data
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

REFRESH-DATA.
    DISPLAY SUDOKU-SCREEN
.

SHOW-FINAL-RESULTS.
    DISPLAY BLANK-SCREEN
    IF SOLUTIONS-COUNTER > 0 THEN
        DISPLAY "NO MORE SOLUTIONS FOUND" LINE 3
        DISPLAY "SOLUTIONS COUNTER: " LINE 5
        DISPLAY SOLUTIONS-COUNTER  HIGHLIGHT LINE 5 COL 20
    ELSE 
        DISPLAY "NO SOLUTIONS FOUND" LINE 3
    END-IF
    DISPLAY "PRESS ENTER." LINE 9
    ACCEPT PRESS-ENTER LINE 10
    MOVE ZERO TO SOLUTIONS-COUNTER
    MOVE ZERO TO STEPS-COUNTER
    MOVE SPACE TO SC-RESPONSE
.

END PROGRAM Sudoku.

Program-Id. TABLE-ANALYSIS RECURSIVE.
ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.
01  LEVEL       PIC 9(4) VALUE ZERO.
01  PRESS-ENTER PIC X.

LOCAL-STORAGE SECTION.

01 CELL-VALUES.
    05 CELL-VALUE OCCURS 9 TIMES PIC 9.

01  VAL-IDX PIC 99.

01  LIDX    PIC 99.
01  LIDY    PIC 99.

01  TIDX    PIC 99.
01  TIDY    PIC 99.

01  ZIDX    PIC 99.
01  ZIDY    PIC 99.

01  TIDX-LIM    PIC 99.
01  TIDY-LIM    PIC 99.
01  TIDX-START    PIC 99.
01  TIDY-START    PIC 99.

01  TEST-RES    PIC 9 VALUE ZERO.
    88  TEST-RES-OK VALUE ZERO.

LINKAGE SECTION.
01 SUDOKU-TABLE.
    05 TABLEX OCCURS 9 TIMES INDEXED BY IDX.
        10 TABLEY OCCURS 9 TIMES INDEXED BY IDY PIC 9(1).

01 SOLUTIONS-COUNTER PIC 9(4).
01 STEPS-COUNTER PIC 9(9).

PROCEDURE DIVISION USING SUDOKU-TABLE, SOLUTIONS-COUNTER, STEPS-COUNTER.

MAIN.
    
    ADD 1 TO LEVEL
    ADD 1 TO STEPS-COUNTER

    PERFORM INITIATE-CELL-VALUES

    PERFORM VARYING LIDX FROM 1 BY 1 UNTIL LIDX > 9
        PERFORM VARYING LIDY FROM 1 BY 1 UNTIL LIDY > 9
            IF TABLEY(LIDX,LIDY) IS ZERO THEN    *> I found empty cell, test it!
                PERFORM INSERT-CELL-VALUE
            END-IF
        END-PERFORM
    END-PERFORM
    *> if you are here, means all cells of table are filled, and all matches!
    ADD 1 to SOLUTIONS-COUNTER
    CALL 'SHOW-SUDOKU-BOARD' USING SUDOKU-TABLE, SOLUTIONS-COUNTER, STEPS-COUNTER
    GOBACK
.
INITIATE-CELL-VALUES.
    *> all possible values for a cell
    MOVE 123456789 TO CELL-VALUES
.
INSERT-CELL-VALUE.
    PERFORM VARYING VAL-IDX FROM 1 BY 1 UNTIL VAL-IDX > 9

        *> reset test status
        MOVE ZERO TO TEST-RES

        PERFORM TEST-HORIZONTALLY
        PERFORM TEST-VERTICALLY
        PERFORM TEST-SQUARE

        IF TEST-RES-OK THEN
            *> this cell value fits to table 
            MOVE CELL-VALUE(VAL-IDX) TO TABLEY(LIDX,LIDY)
            
            *> execute recurently program again
            CALL 'TABLE-ANALYSIS' USING SUDOKU-TABLE, SOLUTIONS-COUNTER, STEPS-COUNTER  

            *> if you back here, means this cell value was not so good
            MOVE ZERO TO TABLEY(LIDX,LIDY)
            
        END-IF

    END-PERFORM
    *> tested all numbers for this cell    
    SUBTRACT 1 FROM LEVEL
    GOBACK
.
TEST-VERTICALLY.
    *> if value found in the horizontal row, indicate it TEST-RES
    PERFORM VARYING TIDX FROM 1 BY 1 UNTIL TIDX > 9
        IF TABLEY(TIDX, LIDY) = CELL-VALUE(VAL-IDX) THEN 
            ADD 1 TO TEST-RES
        END-IF
    END-PERFORM 
.
TEST-HORIZONTALLY.
    *> if value found in the vertical row, indicate it TEST-RES
    PERFORM VARYING TIDY FROM 1 BY 1 UNTIL TIDY > 9
        IF TABLEY(LIDX, TIDY) = CELL-VALUE(VAL-IDX) THEN 
            ADD 2 TO TEST-RES
        END-IF
    END-PERFORM 
.
TEST-SQUARE.

    *> reduce by one, DIV works better
    SUBTRACT 1 FROM LIDX GIVING ZIDX
    SUBTRACT 1 FROM LIDY GIVING ZIDY

    DIVIDE ZIDX BY 3 GIVING TIDX-START
    DIVIDE ZIDY BY 3 GIVING TIDY-START

    MULTIPLY 3 BY TIDX-START
    MULTIPLY 3 BY TIDY-START
 
    *> table indexes start from 1
    ADD 1 TO TIDX-START 
    ADD 1 TO TIDY-START 

    ADD 3 TO TIDX-START GIVING TIDX-LIM
    ADD 3 TO TIDY-START GIVING TIDY-LIM

    PERFORM VARYING TIDX FROM TIDX-START BY 1 UNTIL TIDX = TIDX-LIM
        PERFORM VARYING TIDY FROM TIDY-START BY 1 UNTIL TIDY = TIDY-LIM
            IF TABLEY(TIDX,TIDY) = CELL-VALUE(VAL-IDX) THEN 
                ADD 4 TO TEST-RES
            END-IF
        END-PERFORM
    END-PERFORM



.
*> SHOW-CONTENT.
*>     PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 9
*>         DISPLAY TABLEX(IDX) LINE IDX COL 2
*>     END-PERFORM
*> .

END PROGRAM TABLE-ANALYSIS.

Program-Id. SHOW-SUDOKU-BOARD.
ENVIRONMENT DIVISION.
DATA DIVISION.
WORKING-STORAGE SECTION.

01 SC-RESPONSE   PIC X VALUE SPACE.
    88  RESPONSE-NEXT   VALUES "N", "n".
    88  RESPONSE-QUIT   VALUES "Q", "q".

01 STEPS-COUNTER-D PIC Z(09)9.

*> 01 SCORE-RATING PIC Z(9).

LINKAGE SECTION.
01 SUDOKU-TABLE.
    05 TABLEX OCCURS 9 TIMES INDEXED BY IDX.
        10 TABLEY OCCURS 9 TIMES INDEXED BY IDY PIC 9(1).

01 SOLUTIONS-COUNTER PIC ZZZZ.
01 STEPS-COUNTER PIC 9(9).

SCREEN SECTION.
01 SUDOKU-SCREEN.
    05  HEADER-SECTION.
        10  VALUE   "SOLUTION #" UNDERLINE HIGHLIGHT BLANK SCREEN    LINE 1 COL 14.
        10  SC-COUNTER           UNDERLINE HIGHLIGHT                 LINE 1 COL 24
                        PIC Z(4) FROM FUNCTION TRIM(SOLUTIONS-COUNTER).

    05  CONTENT-SECTION.
        10  BOX-1-1                               LINE 3 COL 5
                        PIC  9  FROM TABLEY(1,1).
        10  BOX-2-1                               LINE 3 COL 9
                        PIC  9  FROM TABLEY(1,2).
        10  BOX-3-1                               LINE 3 COL 13
                        PIC  9  FROM TABLEY(1,3).
        10  BOX-4-1                               LINE 3 COL 17
                        PIC  9  FROM TABLEY(1,4).
        10  BOX-5-1                               LINE 3 COL 21
                        PIC  9  FROM TABLEY(1,5).
        10  BOX-6-1                               LINE 3 COL 25
                        PIC  9  FROM TABLEY(1,6).
        10  BOX-7-1                               LINE 3 COL 29
                        PIC  9  FROM TABLEY(1,7).
        10  BOX-8-1                               LINE 3 COL 33
                        PIC  9  FROM TABLEY(1,8).
        10  BOX-9-1                               LINE 3 COL 37
                        PIC  9  FROM TABLEY(1,9).
        10  BOX-1-2                               LINE 5 COL 5
                        PIC  9  FROM TABLEY(2,1).
        10  BOX-2-2                               LINE 5 COL 9
                        PIC  9  FROM TABLEY(2,2).
        10  BOX-3-2                               LINE 5 COL 13
                        PIC  9  FROM TABLEY(2,3).
        10  BOX-4-2                               LINE 5 COL 17
                        PIC  9  FROM TABLEY(2,4).
        10  BOX-5-2                               LINE 5 COL 21
                        PIC  9  FROM TABLEY(2,5).
        10  BOX-6-2                               LINE 5 COL 25
                        PIC  9  FROM TABLEY(2,6).
        10  BOX-7-2                               LINE 5 COL 29
                        PIC  9  FROM TABLEY(2,7).
        10  BOX-8-2                               LINE 5 COL 33
                        PIC  9  FROM TABLEY(2,8).
        10  BOX-9-2                               LINE 5 COL 37
                        PIC  9  FROM TABLEY(2,9).
        10  BOX-1-3                               LINE 7 COL 5
                        PIC  9  FROM TABLEY(3,1).
        10  BOX-2-3                               LINE 7 COL 9
                        PIC  9  FROM TABLEY(3,2).
        10  BOX-3-3                               LINE 7 COL 13
                        PIC  9  FROM TABLEY(3,3).
        10  BOX-4-3                               LINE 7 COL 17
                        PIC  9  FROM TABLEY(3,4).
        10  BOX-5-3                               LINE 7 COL 21
                        PIC  9  FROM TABLEY(3,5).
        10  BOX-6-3                               LINE 7 COL 25
                        PIC  9  FROM TABLEY(3,6).
        10  BOX-7-3                               LINE 7 COL 29
                        PIC  9  FROM TABLEY(3,7).
        10  BOX-8-3                               LINE 7 COL 33
                        PIC  9  FROM TABLEY(3,8).
        10  BOX-9-3                               LINE 7 COL 37
                        PIC  9  FROM TABLEY(3,9).
    *> ==================
        10  BOX-1-4                               LINE 9 COL 5
                        PIC  9  FROM TABLEY(4,1).
        10  BOX-2-4                               LINE 9 COL 9
                        PIC  9  FROM TABLEY(4,2).
        10  BOX-3-4                               LINE 9 COL 13
                        PIC  9  FROM TABLEY(4,3).
        10  BOX-4-4                               LINE 9 COL 17
                        PIC  9  FROM TABLEY(4,4).
        10  BOX-5-4                               LINE 9 COL 21
                        PIC  9  FROM TABLEY(4,5).
        10  BOX-6-4                               LINE 9 COL 25
                        PIC  9  FROM TABLEY(4,6).
        10  BOX-7-4                               LINE 9 COL 29
                        PIC  9  FROM TABLEY(4,7).
        10  BOX-8-4                               LINE 9 COL 33
                        PIC  9  FROM TABLEY(4,8).
        10  BOX-9-4                               LINE 9 COL 37
                        PIC  9  FROM TABLEY(4,9).
        10  BOX-1-5                               LINE 11 COL 5
                        PIC  9  FROM TABLEY(5,1).
        10  BOX-2-5                               LINE 11 COL 9
                        PIC  9  FROM TABLEY(5,2).
        10  BOX-3-5                               LINE 11 COL 13
                        PIC  9  FROM TABLEY(5,3).
        10  BOX-4-5                               LINE 11 COL 17
                        PIC  9  FROM TABLEY(5,4).
        10  BOX-5-5                               LINE 11 COL 21
                        PIC  9  FROM TABLEY(5,5).
        10  BOX-6-5                               LINE 11 COL 25
                        PIC  9  FROM TABLEY(5,6).
        10  BOX-7-5                               LINE 11 COL 29
                        PIC  9  FROM TABLEY(5,7).
        10  BOX-8-5                               LINE 11 COL 33
                        PIC  9  FROM TABLEY(5,8).
        10  BOX-9-5                               LINE 11 COL 37
                        PIC  9  FROM TABLEY(5,9).
        10  BOX-1-6                               LINE 13 COL 5
                        PIC  9  FROM TABLEY(6,1).
        10  BOX-2-6                               LINE 13 COL 9
                        PIC  9  FROM TABLEY(6,2).
        10  BOX-3-6                               LINE 13 COL 13
                        PIC  9  FROM TABLEY(6,3).
        10  BOX-4-6                               LINE 13 COL 17
                        PIC  9  FROM TABLEY(6,4).
        10  BOX-5-6                               LINE 13 COL 21
                        PIC  9  FROM TABLEY(6,5).
        10  BOX-6-6                               LINE 13 COL 25
                        PIC  9  FROM TABLEY(6,6).
        10  BOX-7-6                               LINE 13 COL 29
                        PIC  9  FROM TABLEY(6,7).
        10  BOX-8-6                               LINE 13 COL 33
                        PIC  9  FROM TABLEY(6,8).
        10  BOX-9-6                               LINE 13 COL 37
                        PIC  9  FROM TABLEY(6,9).
    *> ==================
        10  BOX-1-7                               LINE 15 COL 5
                        PIC  9  FROM TABLEY(7,1).
        10  BOX-2-7                               LINE 15 COL 9
                        PIC  9  FROM TABLEY(7,2).
        10  BOX-3-7                               LINE 15 COL 13
                        PIC  9  FROM TABLEY(7,3).
        10  BOX-4-7                               LINE 15 COL 17
                        PIC  9  FROM TABLEY(7,4).
        10  BOX-5-7                               LINE 15 COL 21
                        PIC  9  FROM TABLEY(7,5).
        10  BOX-6-7                               LINE 15 COL 25
                        PIC  9  FROM TABLEY(7,6).
        10  BOX-7-7                               LINE 15 COL 29
                        PIC  9  FROM TABLEY(7,7).
        10  BOX-8-7                               LINE 15 COL 33
                        PIC  9  FROM TABLEY(7,8).
        10  BOX-9-7                               LINE 15 COL 37
                        PIC  9  FROM TABLEY(7,9).
        10  BOX-1-8                               LINE 17 COL 5
                        PIC  9  FROM TABLEY(8,1).
        10  BOX-2-8                               LINE 17 COL 9
                        PIC  9  FROM TABLEY(8,2).
        10  BOX-3-8                               LINE 17 COL 13
                        PIC  9  FROM TABLEY(8,3).
        10  BOX-4-8                               LINE 17 COL 17
                        PIC  9  FROM TABLEY(8,4).
        10  BOX-5-8                               LINE 17 COL 21
                        PIC  9  FROM TABLEY(8,5).
        10  BOX-6-8                               LINE 17 COL 25
                        PIC  9  FROM TABLEY(8,6).
        10  BOX-7-8                               LINE 17 COL 29
                        PIC  9  FROM TABLEY(8,7).
        10  BOX-8-8                               LINE 17 COL 33
                        PIC  9  FROM TABLEY(8,8).
        10  BOX-9-8                               LINE 17 COL 37
                        PIC  9  FROM TABLEY(8,9).
        10  BOX-1-9                               LINE 19 COL 5
                        PIC  9  FROM TABLEY(9,1).
        10  BOX-2-9                               LINE 19 COL 9
                        PIC  9  FROM TABLEY(9,2).
        10  BOX-3-9                               LINE 19 COL 13
                        PIC  9  FROM TABLEY(9,3).
        10  BOX-4-9                               LINE 19 COL 17
                        PIC  9  FROM TABLEY(9,4).
        10  BOX-5-9                               LINE 19 COL 21
                        PIC  9  FROM TABLEY(9,5).
        10  BOX-6-9                               LINE 19 COL 25
                        PIC  9  FROM TABLEY(9,6).
        10  BOX-7-9                               LINE 19 COL 29
                        PIC  9  FROM TABLEY(9,7).
        10  BOX-8-9                               LINE 19 COL 33
                        PIC  9  FROM TABLEY(9,8).
        10  BOX-9-9                               LINE 19 COL 37
                        PIC  9  FROM TABLEY(9,9).

    05  SCREEN-DIVIDERS FOREGROUND-COLOR 3 .
            COPY "sudoku-dividers.cbl".

    05 BOTTOM-SECTION.
        10  VALUE "STEPS TO SOLUTION: "                 LINE 21 COL 10.
        10  SC-COUNTER                                  LINE 21 COL 29
                     FROM FUNCTION TRIM(STEPS-COUNTER-D).          
        10  VALUE "N - NEXT SOLUTION"                   LINE 23 COL 30.
        10  VALUE "Q - TO QUIT"                         LINE 24 COL 30.
        10  VALUE "ENTER RESPONSE:"                     LINE 25 COL 30.
        10  RESPONSE-INPUT                              LINE 25 COL 46
                    PIC X    AUTO    TO SC-RESPONSE.

PROCEDURE DIVISION USING SUDOKU-TABLE, SOLUTIONS-COUNTER, STEPS-COUNTER.

DISPLAY-SCREEN.
    MOVE STEPS-COUNTER TO STEPS-COUNTER-D
    PERFORM SCREEN-LOOP 
    MOVE SPACE TO RESPONSE-INPUT
    MOVE SPACE TO SC-RESPONSE
    MOVE ZERO TO STEPS-COUNTER
    DISPLAY "SOLVING NEXT..." FOREGROUND-COLOR 0 BACKGROUND-COLOR 4  LINE 23 COL 7
    GOBACK
.
SCREEN-LOOP.
    PERFORM UNTIL RESPONSE-NEXT
        DISPLAY SUDOKU-SCREEN
        ACCEPT SUDOKU-SCREEN

        IF RESPONSE-QUIT THEN
            STOP RUN
        END-IF
    END-PERFORM
.

END PROGRAM SHOW-SUDOKU-BOARD.
