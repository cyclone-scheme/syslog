An Cyclone Scheme interface to the POSIX syslog module. 

# API

## High-Level Functions

### (send-log priority . args)

Send a message to the syslog with the given priority. All `args` objects will be concatenated and written to the log.

### (open-log ident)

An optional function to specify a label that will be appended to all logged messages.

## Low-Level Functions

### (openlog ident logopt facility)

The `openlog` function sets process attributes that affect subsequent calls to `syslog` The ident argument is a string that is prepended to every message. The logopt argument indicates logging options.

### (closelog)

The `closelog` function closes any open file descriptors allocated by previous calls to `openlog` or `syslog`.

### (setlogmask maskpri)

The `setlogmask` function sets the log priority mask for the current process to maskpri and returns the previous mask. If the maskpri argument is 0, the current log mask is not modified. Calls by the current process to `syslog` with a priority not set in maskpri are rejected. The default log mask allows all priorities to be logged. A call to openlog is not required prior to calling `setlogmask`.

### (syslog priority message)

The `syslog` function sends a message to an implementation-dependent logging facility, which may log it in an implementation-dependent system log, write it to the system console, forward it to a list of users, or forward it to the logging facility on another host over the network. The logged message includes a message header and a message body. The message header contains at least a timestamp and a tag string.

## Constants

### EMERG

A panic condition was reported to all processes.

### ALERT

A condition that should be corrected immediately.

### CRIT

A critical condition.

### ERR

An error message.

### WARNING

A warning message.

### NOTICE

A condition requiring special handling.

### INFO

A general information message.

### DEBUG

A message useful for debugging programs.

### LOG_PID

### LOG_USER

