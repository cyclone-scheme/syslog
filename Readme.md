An Cyclone Scheme interface to the POSIX syslog module. 

# API

## Functions

### (send-log priority . args)

Send a message to the syslog with the given priority. All `args` objects will be concatenated and written to the log.

### (open-log name)

An optional function to specify a label that will be appended to all logged messages.

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
