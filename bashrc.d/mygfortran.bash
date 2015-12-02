# Standard gfortran options
function mygfortran()
{ 
  flags='-cpp -Wall -pedantic -std=f95'
  flags+="-fbounds-check -ffree-line-length-0 -fbacktrace -fall-intrinsics"
  gfortran-5 "$flags" "$@"
}
export -f mygfortran
