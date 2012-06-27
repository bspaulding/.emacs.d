;; indentation.el
;; Author: Bradley J. Spaulding
;; Created On: 2012-04-05

(defun indent-block()
  (shift-region my-tab-width)
  (setq deactivate-mark nil))

(defun unindent-block()
  (shift-region (- my-tab-width))
  (setq deactivate-mark nil))

(defun shift-region(numcolumns)
  (if (< (point)(mark))
    (if (not(bolp))