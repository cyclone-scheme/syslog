(import (scheme base) (cyclone syslog) (cyclone test))
(test-group "syslog"
  (open-log "test log")
  (send-log INFO "log message from test program")
  (closelog)
  (send-log INFO "another log message from test program")
  (test 1 1)
)
(test-exit)

