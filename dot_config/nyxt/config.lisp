;; (defvar *my-search-engines*
;;   (list
;;     '("google" "https://google.com/search?q=~a" "https://google.com")))

(define-configuration (input-buffer)
		      ((default-modes (pushnew 'nyxt/mode/vi:vi-normal-mode %slot-value%))))

(define-configuration (prompt-buffer)
		      ((default-modes (pushnew 'nyxt/mode/vi:vi-insert-mode %slot-value%))))

(define-configuration browser
		      ((theme theme:+dark-theme+)))

(define-configuration (web-buffer)
		      ((default-modes (pushnew 'nyxt/mode/style:dark-mode %slot-value%))))

(define-configuration (input-buffer)
		      ((default-modes (pushnew 'nyxt/mode/vi:vi-normal-mode %slot-value%))))

(define-configuration (prompt-buffer)
		      ((default-modes (pushnew 'nyxt/mode/vi:vi-insert-mode %slot-value%))))

;; (define-configuration context-buffer
;; 		      ((search-engines
;; 			 (append
;; 			   (mapcar (lambda (engine) (apply 'make-search-engine engine))
;; 				   *my-search-engines*)
;; 			   %slot-default%))))
