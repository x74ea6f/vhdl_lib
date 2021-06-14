
set -eu

VIVADO_SETTING_PATH=/tools/Xilinx/Vivado/2020.2/settings64.sh 
source ${VIVADO_SETTING_PATH}

libfiles="../src/*.vhd"

# Usage
function usage() {
  echo $1
  cat <<_EOT_
Usage:
  `basename $0` [-g g=v] file.vhd ...

Description:
  run compile, simulation.

Options:
  -g set xelab generic_top(-g "N=10")
  -h show help
_EOT_
  exit 1
}

## Option
files=""
gen=""
while getopts g:h OPT
do
    case $OPT in
        g)  gen="$gen -generic_top $OPTARG"
            ;;
        h)  usage "Help"
            ;;
    esac
done

## Option分移動
shift $(($OPTIND - 1))
if [ $# == 0 ]; then
    usage "Files needed"
fi
files=($@)

## Get top module name from last File
top_file=${files[-1]}
top=${top_file}
top=$(basename -s .vhd ${top})
top=$(echo $top | sed -e "s/^[0-9]\+\.//")
echo "TopModule is $top"

## Main
xvhdl --2008 ${libfiles} ${files[@]}
xelab --debug typical ${top} ${gen}
xsim ${top} --tclbatch wave.tcl
## xsim ${top} --tempDir .tmp --tclbatch wave.tcl
## xsim -R ${top} --tempDir .tmp

## cleanup
rm -f xsim_*.backup.jou xsim_*.backup.log
rm -f vivado_*.backup.jou vivado_*.backup.log
rm -f webtalk_*.jou webtalk_*.log

