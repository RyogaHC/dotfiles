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
