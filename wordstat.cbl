       IDENTIFICATION DIVISION.
       PROGRAM-ID. CountWords.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FILE-HANDLE ASSIGN TO FILE-NAME
               ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-FILE-STATUS.

       DATA DIVISION.
       FILE SECTION. 
       FD FILE-HANDLE.
       01 FILE-LINE   PIC X(150).
        
       WORKING-STORAGE SECTION.

       01 FILE-NAME      PIC X(255).
           88 DEFAULT-FILE-NAME VALUE "south.txt".
       01 USER-FILE-NAME PIC X(255).

       01 WS-FILE-STATUS  PIC XX.
           88 END-OF-FILE VALUE "10".
           88 FILE-STATUS-GOOD VALUES ZERO, "10".

       01 REMOVE_CHARACTERS PIC X(40)
                   VALUE "!@#$%^&*-_+=£§~`<>?|.,:;|'\/(){}[]".

       01 LINE-SIZE       PIC 999.
       01 WORDS-TOTAL     PIC 9(6) VALUE ZERO.
       01 WORDS-TOTAL-D   PIC ZZZ,ZZ9.
       01 WORDS-UNIQ      PIC 9(6) VALUE ZERO.
       01 WORDS-UNIQ-D    PIC ZZZ,ZZ9.
       01 LONGEST-WORD    PIC X(40).
       01 LONGEST-WORD-SIZE PIC ZZ.
       01 WORD-1          PIC X(40) VALUE SPACES. 
       01 WORD-1-SIZE     PIC 99.

       01 STRING-PTR      PIC 999.
       01 PROGRESS        PIC 999 VALUE 999.
           88 PROGRESS-FEEDBACK VALUE ZERO.
       01 OUTPUT-ELEMENT   PIC 99 VALUE ZERO.
       01 OUTPUT-LIMIT    PIC 99 VALUE 15.  *> top n elements

       01 FLAGS.   
           05  WORD-STRING-EMPTY   PIC X VALUE "N".   
               88 NO-MORE-WORDS          VALUE "Y".  

       78 WORDS-LIMIT VALUE 10000.  *> hardcoded limit of unique words to hold
 
       78 WORD-SIZE-TRESHOLD VALUE 3. *> ignore short words
       01 WORD-SIZE-LIMIT-COUNTER PIC 9(5) VALUE ZERO. 
       01 WORD-SIZE-LIMIT-COUNTER-D PIC ZZ,ZZ9. 

       01 TABLE-STORAGE  BASED.
           05  LIST-OF-WORDS OCCURS WORDS-LIMIT TIMES
                             ASCENDING KEY IS THE-WORD
                             DESCENDING KEY IS WORD-COUNTER
                             INDEXED BY WORDS-IDX.
               10 THE-WORD     PIC X(40) VALUE ZERO.
               10 WORD-COUNTER PIC 9(4).
               10 WORD-SIZE    PIC 99.
                   88 TOO-SHORT VALUES 1 THRU WORD-SIZE-TRESHOLD. *> indicate short words

       PROCEDURE DIVISION.
       
       MAIN-PARAGRAPH.

           ACCEPT USER-FILE-NAME FROM COMMAND-LINE 
           IF USER-FILE-NAME IS NOT EQUAL SPACES THEN
               MOVE USER-FILE-NAME TO FILE-NAME
           ELSE
               SET DEFAULT-FILE-NAME TO TRUE
           END-IF

           OPEN INPUT FILE-HANDLE
           IF NOT FILE-STATUS-GOOD THEN
           DISPLAY "File error!"
           PERFORM FINISH
           END-IF

           *> file of good to go, allocate memory for table
           ALLOCATE TABLE-STORAGE INITIALIZED

           DISPLAY "Processing file " FILE-NAME
           SET WORDS-IDX TO 1   
           PERFORM UNTIL END-OF-FILE 
               READ FILE-HANDLE
           
               PERFORM CLEANUP-LINE
               *>    initialize pointer and flags
               MOVE 1 TO STRING-PTR
               MOVE 'N' TO WORD-STRING-EMPTY
                  
               PERFORM PROCESS-LINE UNTIL NO-MORE-WORDS
               PERFORM DISPLAY-PROGRESS
               
           END-PERFORM
           DISPLAY "Done."
           CLOSE FILE-HANDLE
           PERFORM PROCESS-WORDS-LIST
           PERFORM FINISH
       .

       CLEANUP-LINE.
       *> remove all unnecesary characters
           INSPECT FILE-LINE CONVERTING REMOVE_CHARACTERS TO SPACE
       .

       PROCESS-LINE.
       *> split line into words   
           SET LINE-SIZE TO SIZE OF FILE-LINE
           UNSTRING FILE-LINE DELIMITED BY ALL SPACES   
               INTO WORD-1
               COUNT IN WORD-1-SIZE   
               POINTER STRING-PTR   
               ON OVERFLOW   *> unfinished strip 
                   IF STRING-PTR > LINE-SIZE THEN   
                       MOVE "Y" TO WORD-STRING-EMPTY   
                   END-IF  
                   IF WORD-1-SIZE IS GREATER THAN ZERO THEN 
                       PERFORM STORE-WORD  
                   END-IF 
                  *> clean up   
               MOVE SPACES TO WORD-1   
           END-UNSTRING
       . 
        
       STORE-WORD.
       *> search the table and increase word counter
           ADD 1 TO WORDS-TOTAL
           
           SET WORDS-IDX TO 1
           SEARCH ALL LIST-OF-WORDS
               AT END PERFORM ADD-NEW-WORD
               WHEN THE-WORD(WORDS-IDX) IS EQUAL TO FUNCTION LOWER-CASE(WORD-1)
                   ADD 1 TO WORD-COUNTER(WORDS-IDX)       
           END-SEARCH
       .

       ADD-NEW-WORD.
       *> addd new word to thte table
           ADD 1 TO WORDS-UNIQ 
           *>    find free spot in table
           SEARCH ALL LIST-OF-WORDS
               AT END DISPLAY "List is full, can't add more words!"
               WHEN THE-WORD(WORDS-IDX) IS EQUAL TO ZERO
               MOVE FUNCTION LOWER-CASE(WORD-1) TO THE-WORD(WORDS-IDX)
               MOVE 1 TO WORD-COUNTER(WORDS-IDX)
               MOVE WORD-1-SIZE TO WORD-SIZE(WORDS-IDX)
               IF WORD-1-SIZE IS GREATER THAN LONGEST-WORD-SIZE THEN
                   MOVE WORD-1-SIZE TO LONGEST-WORD-SIZE
                   MOVE FUNCTION LOWER-CASE(WORD-1) TO LONGEST-WORD
               END-IF
           END-SEARCH
           *> words list needs to be sorted for next SEARCH ALL: 
           SORT LIST-OF-WORDS ON ASCENDING KEY THE-WORD 
       .

       DISPLAY-PROGRESS.
           SUBTRACT 1 FROM PROGRESS
           IF PROGRESS-FEEDBACK THEN
               MOVE 999 TO PROGRESS
               MOVE WORDS-TOTAL to WORDS-TOTAL-D
               MOVE WORDS-UNIQ TO WORDS-UNIQ-D
               DISPLAY "Words found: " WORDS-TOTAL-D NO ADVANCING
               DISPLAY " where unique: " WORDS-UNIQ-D
           END-IF
       .

       PROCESS-WORDS-LIST.
           SORT LIST-OF-WORDS ON DESCENDING KEY WORD-COUNTER 
           DISPLAY "Top " OUTPUT-LIMIT " words:"
           SET WORDS-IDX TO 1
           PERFORM VARYING WORDS-IDX FROM 1 BY 1 UNTIL OUTPUT-ELEMENT > OUTPUT-LIMIT
               IF WORD-COUNTER(WORDS-IDX) IS GREATER THAN ZERO THEN
                   IF NOT TOO-SHORT(WORDS-IDX) THEN
                       DISPLAY WORD-COUNTER(WORDS-IDX) " " THE-WORD(WORDS-IDX) " of " WORD-SIZE(WORDS-IDX) " characters"
                       ADD 1 TO OUTPUT-ELEMENT
                   ELSE    
                       >>D DISPLAY "word size is only: " WORD-SIZE(WORDS-IDX)
                       ADD 1 TO WORD-SIZE-LIMIT-COUNTER
                   END-IF
               END-IF
           END-PERFORM
           MOVE WORD-SIZE-LIMIT-COUNTER TO WORD-SIZE-LIMIT-COUNTER-D
           DISPLAY "List ignores " FUNCTION TRIM(WORD-SIZE-LIMIT-COUNTER-D)
                 " words shorter than " FUNCTION TRIM(WORD-SIZE-TRESHOLD) " characters."

           DISPLAY "Longest word: '" FUNCTION TRIM(LONGEST-WORD) "', "
                 FUNCTION TRIM (LONGEST-WORD-SIZE) " characters."

           MOVE WORDS-TOTAL TO WORDS-TOTAL-D
           MOVE WORDS-UNIQ TO WORDS-UNIQ-D
           DISPLAY "Total number of words: " WORDS-TOTAL-D
           DISPLAY "Unique words: " WORDS-UNIQ-D
       .

       FINISH.
       FREE TABLE-STORAGE
       STOP RUN
       . 
