(defun report-result (result form) 
  (format t "~:[FAIL~;pass~] ... ~a~%" result form)
  result
)

(defmacro check (&body forms) 
  `(combine-results 
     ,@(loop for f in forms collect `(report-result ,f ',f))
   )
)

(defmacro combine-results (&body forms) 
  (with-gensyms (result) 
    `(let ((,result t)) 
       ,@(loop for f in forms collect `(unless ,f (setf ,result nil))) 
       ,result
     )
  )
)

(defun test-+ () 
  (check 
    (= (+ 1 2) 3) 
    (= (+ 1 2 3) 6) 
    (= (+ -1 -3) -4)
  )
)
