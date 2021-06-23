echo `date` | tee go.log

bash run.sh test_file_lib1.vhd | tee -a go.log
bash run.sh test_numeric_lib1.vhd | tee -a go.log
bash run.sh test_numeric_lib2.vhd | tee -a go.log
bash run.sh test_numeric_lib3.vhd | tee -a go.log
bash run.sh test_sim_lib1.vhd | tee -a go.log
bash run.sh test_sim_lib2.vhd | tee -a go.log
bash run.sh test_sim_lib3.vhd | tee -a go.log
bash run.sh test_str_lib1.vhd | tee -a go.log
bash run.sh test_str_lib2.vhd | tee -a go.log
bash run.sh test_str_lib3.vhd | tee -a go.log
