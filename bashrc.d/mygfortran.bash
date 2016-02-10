# Standard gfortran options
function mygfortran()
{ 
  gfortran -cpp -Wall -pedantic -std=f95 \
    -fbounds-check -ffree-line-length-0 -fbacktrace -fall-intrinsics "$@"
}
export -f mygfortran
