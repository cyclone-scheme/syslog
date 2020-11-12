(define-library (cyclone syslog)
  (import 
    (scheme base)
    (scheme write)
    (cyclone foreign))
  (include-c-header "<syslog.h>")
  (export
    openlog
    closelog
    syslog

LOG_PID
LOG_USER

    notice
    error)
  (begin
    (define (error msg . err)
      (let ((fp (current-error-port)))
        (display msg fp)
        (newline fp)
        (if (not (null? err))
            (display err fp))
        (newline fp)))
    
    (define notice error)

    (define LOG_PID (c-value "LOG_PID" int))
    (define LOG_USER (c-value "LOG_USER" int))

    (c-define openlog c-void "openlog" string int int)
    (c-define closelog c-void "closelog")

    ;(c-define syslog c-void "syslog" int string)
    (define-c syslog
      "(void *data, int argc, closure _, object k, object lvl, object msg)"
      " Cyc_check_str(data, msg);
        Cyc_check_fixnum(data, lvl);
        syslog(obj_obj2int(lvl), \"%s\", string_str(msg));
        return_closcall1(data, k, boolean_t);")
  )
)
