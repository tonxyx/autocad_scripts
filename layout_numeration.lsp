(defun c:AUTONUM (/ layoutList layoutName index ss ent txtObj layoutCount)
  (setq layoutList (layoutlist))  ; List of all the layouts
  (setq index 0)
  (setq layoutCount (length layoutList))  ; Number of layouts

  (while (< index layoutCount)  ; Loop through all the layouts
    (setq layoutName (nth index layoutList))  ; Fetch layout name by index
    
    (setvar "CTAB" layoutName)  ; Activate current layout
    (setq ss (ssget "X" '((0 . "TEXT"))))  ; Find all TEXT objects in current layout

    (if (and ss (> (sslength ss) 0) (<= index (sslength ss)))  ; Check if index is inside the layout selection
      (progn
        (setq ent (ssname ss index))  ; Take object from index position
        (setq txtObj (entget ent))  
        
        ;; Replace text with reverse order of index
        (setq txtObj (subst (cons 1 (itoa (- layoutCount index))) (assoc 1 txtObj) txtObj))  
        
        (entmod txtObj)  ; Update object
        (entupd ent)  ; Ensure changes
      )
    )

    (setq index (1+ index))  ; Increase index for next layout
  )
  (princ "\Automatic layout numeration done.")
  (princ)
)
