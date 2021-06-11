echo `date` | tee go.log
bash run.sh -g LEN_A=8 -g LEN_CLIP=4 -g LEN_ROUND=4 ../src/debug_lib.vhd ../src/numeric_lib.vhd test_numeric_lib2.vhd | tee -a go.log
bash run.sh -g LEN_A=8 -g LEN_CLIP=7 -g LEN_ROUND=7 ../src/debug_lib.vhd ../src/numeric_lib.vhd test_numeric_lib2.vhd | tee -a go.log
bash run.sh -g LEN_A=8 -g LEN_CLIP=6 -g LEN_ROUND=6 ../src/debug_lib.vhd ../src/numeric_lib.vhd test_numeric_lib2.vhd | tee -a go.log
bash run.sh -g LEN_A=8 -g LEN_CLIP=5 -g LEN_ROUND=5 ../src/debug_lib.vhd ../src/numeric_lib.vhd test_numeric_lib2.vhd | tee -a go.log
bash run.sh -g LEN_A=12 -g LEN_CLIP=10 -g LEN_ROUND=4 ../src/debug_lib.vhd ../src/numeric_lib.vhd test_numeric_lib2.vhd | tee -a go.log
bash run.sh -g LEN_A=12 -g LEN_CLIP=4 -g LEN_ROUND=10 ../src/debug_lib.vhd ../src/numeric_lib.vhd test_numeric_lib2.vhd | tee -a go.log
