# Run gdb on OsX 10.12 (Sierra):
set startup-with-shell off
# Convenience settings:
set history save on
set history size 10000
set history remove-duplicates unlimited
set print pretty on
set print array on
# set print address off
# print actual bits at address
define whodat
    eval "monitor get_vbits %p %d", &$arg0, sizeof($arg0)
end
# print user-defined number of bits at address
define whodatn
  eval "monitor get_vbits %p %d", &$arg0, $arg1
end
