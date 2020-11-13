;;;;
;;;; An Cyclone Scheme interface to the POSIX syslog module. 
;;;;
(define-library (cyclone syslog)
  (import 
    (scheme base)
    (scheme write)
    (cyclone foreign))
  (include-c-header "<syslog.h>")
  (export
    ;; Convenience functions
    open-log
    send-log

    ;; Core functions from syslog.h
    openlog
    closelog
    syslog
    setlogmask

    ;; openlog options
    LOG_PID

    ;; Facility
    LOG_USER

    ;; Log priority
    EMERG
    ALERT
    CRIT
    ERR
    WARNING
    NOTICE
    INFO
    DEBUG
  )
  (begin
    (define (open-log name)
      (openlog name LOG_PID LOG_USER))

    (define (send-log priority . args)
      (let* ((fp (open-output-string)))
        (for-each
          (lambda (obj)
            (display obj fp))
          args)

        (syslog priority (get-output-string fp))))

    (define LOG_PID (c-value "LOG_PID" int))

;; TODO:
;; Log the process ID with each message. This is useful for identifying specific processes.
;; LOG_CONS
;; Write messages to the system console if they cannot be sent to the logging facility. The syslog() function ensures that the process does not acquire the console as a controlling terminal in the process of writing the message.
;; LOG_NDELAY
;; Open the connection to the logging facility immediately. Normally the open is delayed until the first message is logged. This is useful for programs that need to manage the order in which file descriptors are allocated.
;; LOG_ODELAY
;; Delay open until syslog() is called.
;; LOG_NOWAIT
;; Do not wait for child processes that may have been created during the course of logging the message. This option should be used by processes that enable notification of child termination using SIGCHLD, since syslog() may otherwise block waiting for a child whose exit status has already been collected.
;; 

    (define LOG_USER (c-value "LOG_USER" int))

    ;; A panic condition was reported to all processes.
    (define EMERG (c-value "LOG_EMERG" int))
    ;; A condition that should be corrected immediately.
    (define ALERT (c-value "LOG_ALERT" int))
    ;; A critical condition.
    (define CRIT (c-value "LOG_CRIT" int))
    ;; An error message.
    (define ERR (c-value "LOG_ERR" int))
    ;; A warning message.
    (define WARNING (c-value "LOG_WARNING" int))
    ;; A condition requiring special handling.
    (define NOTICE (c-value "LOG_NOTICE" int))
    ;; A general information message.
    (define INFO (c-value "LOG_INFO" int))
    ;; A message useful for debugging programs.
    (define DEBUG (c-value "LOG_DEBUG" int))


    (c-define openlog c-void "openlog" string int int)
    (c-define closelog c-void "closelog")
    (c-define setlogmask int "setlogmask" int)

    ;(c-define syslog c-void "syslog" int string)
    (define-c syslog
      "(void *data, int argc, closure _, object k, object lvl, object msg)"
      " Cyc_check_str(data, msg);
        Cyc_check_fixnum(data, lvl);
        syslog(obj_obj2int(lvl), \"%s\", string_str(msg));
        return_closcall1(data, k, boolean_t);")
  )
)
