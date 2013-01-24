;
; This is the demo workflow Artem puts together in his screencast:
; http://www.youtube.com/watch?v=BUgxmvpuKAs
;
; You can run it from project root like so:
;
;   lein run --auto --workflow demos/people-skills/workflow.d
;
; Or, if you have Drake installed, you can cd to this directory and just run drake.
;


;
; Cleans up the skills file.
; Input lines are like:
;   Artem Boytsov,flying southwest
;   REAL BAD ENTRY
;   Maverick Lou,java clojure jenkins
;
skills.filtered <- skills
  grep -v BAD $INPUT > $OUTPUT

;
; Starts with people formatted like...
;   Crow,Aaron,310-300-0000
;   Pepi,Vinnie,+86-310-400-0000
;   Lao,Will,+86-310-600-0000
;
; ...and ends with people.fullname formatted like:
;   Aaron Crow, 310-300-0000
;   Vinnie Pepi, +86-310-400-0000
;   Will Lao, +86-310-600-0000
;
people.fullname <- people
  awk -F, '{ print $2 " " $1 ", " $3}' $INPUT > $OUTPUT

;
; Simple sort of our people...
;
people.sorted <- people.fullname
  sort $INPUT > $OUTPUT

;
; Joins sorted people to their skills. output is like:
;   Aaron Crow,java ruby clojure, 310-300-0000
;   Artem Boytsov,flying southwest, 310-100-0000
;   Maverick Lou,java clojure jenkins, +86-310-200-0000
;
output <- skills.filtered, people.sorted
  echo Number of inputs: $INPUTN
  echo All inputs: $INPUTS
  echo Joining ...
  join -t, $INPUTS > $OUTPUT