

#############################################
## last update: 11-Jan-2016
## by : Vichet Chea
## email: vichet.chea@niptict.edu.kh
## tel: (+855)-77-657-007
## website: www.niptict.edu.kh
#############################################


START_TIME=$SECONDS



usage() {
	echo -e "Usage:\n"
	echo -e "\t$0 crf_model input_file output_dir\n\n";
	echo -e "This is Khmer word segmenation tool. It produces two output files in [output_dir].\n";
	echo -e "\txxx.w\tsegmented output as word.";
	echo -e "\txxx.c\tsegmented output as word, compound word with prefix and suffix.";

	echo -e "\n";
	exit;
}

if [ $# -ne 3 ]
	then
		usage;
fi




model=$1
input_file=$2
output_dir=$3
mkdir -p $output_dir

base=`basename ${input_file}`

#1 - line to crf
>&2 echo "Converting line to characer...";
input_crf=/tmp/${base}.crf
./km-5tag-seg-line2crf.pl  ${input_file}  ${input_crf}

#2 - crf_test
>&2 echo "Segmenting, please wait ... ";
output_crf=${input_crf}.out
crf_test -m ${model} ${input_crf} > ${output_crf}

#3 - crf to line
>&2 echo "Finalizing ... ";
output_c=${output_dir}/${base}.c
output_w=${output_dir}/${base}.w

./km-5tag-seg-crf2line.pl ${output_crf} ${output_c} -c
./km-5tag-seg-crf2line.pl ${output_crf} ${output_w} -w

>&2 echo "Output files are in: ${output_dir}";
>&2 echo "- ${output_c}";
>&2 echo "- ${output_w}";
>&2 echo "DONE!";



ELAPSED_TIME=$(($SECONDS - $START_TIME))
>&2 echo "Execution time: ${ELAPSED_TIME} s";

