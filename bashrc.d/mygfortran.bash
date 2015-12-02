# Standard gfortran options
function mygfortran()
{ 
  # Standard flags
  flags='-cpp -Wall -pedantic -std=f95'
  # gcc runtime checks
  flags+="-fbounds-check -ffree-line-length-0 -fbacktrace -fall-intrinsics"
  # compile the program
  gfortran-5 "$flags" "$@"
}
