       IDENTIFICATION DIVISION.
       PROGRAM-ID. PrimeNumbers.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 WS-FIND          PIC 9(4).
           01 WS-PRIM          PIC 9(4) VALUE 2.
           01 WS-NEX           PIC 9(4) VALUE ZERO.
           01 MISC-VALUES.
               05 IND           PIC 9(4) VALUE ZERO.
               05 COUNTER       PIC 9(4) VALUE ZERO.
               05 SEARCH-RETURN PIC 9(1) VALUE ZERO.
           01 PRIMES-TABLE OCCURS 1 TO 10000 TIMES    *> limit
               DEPENDING ON WS-FIND INDEXED BY PRIMES-IDX PIC 9(4).
               
       PROCEDURE DIVISION.
       
       MAIN-PARAGRAPH.
           DISPLAY "Enter a positive integer".
           ACCEPT WS-FIND.
           PERFORM POPULATE-PARAGRAPH.
       
           *> remove all 2^n
           PERFORM REMOVE-PARAGRAPH
           
           PERFORM UNTIL SEARCH-RETURN = 1
           
               SEARCH PRIMES-TABLE
                   AT END MOVE 1 TO SEARCH-RETURN
                   WHEN PRIMES-TABLE (PRIMES-IDX) > WS-PRIM
                       MOVE PRIMES-TABLE (PRIMES-IDX) TO WS-PRIM
                       PERFORM REMOVE-PARAGRAPH
               END-SEARCH  
       
           END-PERFORM.
       
           PERFORM DISPLAY-TABLE-PARAGRAPH.
       
       STOP RUN.
       
       POPULATE-PARAGRAPH.
       *> load initial values: 1, 2, 3, ... n
           PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > WS-FIND
               MOVE IND TO PRIMES-TABLE (IND)
           END-PERFORM
       .
       
       REMOVE-PARAGRAPH.
       *> REMOVE PRIME^2 FROM TABLE
           MULTIPLY WS-PRIM BY WS-PRIM GIVING WS-NEX.
           >>D  DISPLAY "Found :" WS-PRIM.
           PERFORM VARYING IND FROM WS-NEX BY WS-PRIM 
              UNTIL IND > WS-FIND
              >>D  DISPLAY "REMOVE: " IND
               *> remove means actually "change to zero"
               MOVE ZERO TO PRIMES-TABLE (IND)
           END-PERFORM
       .
       
       DISPLAY-TABLE-PARAGRAPH.
       *> DISPLAY FILTERED TABLE
           DISPLAY "Primes lower than " WS-FIND ":"
           PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > WS-FIND
               IF PRIMES-TABLE (IND) <> 0 THEN
                  DISPLAY PRIMES-TABLE (IND)
                  ADD 1 TO COUNTER
               END-IF
           END-PERFORM.
           DISPLAY "Total " COUNTER " prime numbers found."
       .