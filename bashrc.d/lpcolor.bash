# color printing
lpcolor()
{
  lpoptions -d m210__color___thayercups \
            -o Duplex=DuplexNoTumble \
            -o prettyprint \
            -o cpi=14 \
            -o lpi=8 \
            -o page-top=18 \
            -o page-right=18 \
            -o page-bottom=36 \
            -o page-left=36
  lp -d m210__color___thayercups $1
}
