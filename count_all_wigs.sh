
export NA=$1
cd ${NA}

# adapted from https://stackoverflow.com/questions/10523415/execute-command-on-all-files-in-a-directory

for file in ./*.wig
do
	echo "$file" >>wigcount.txt
	perl ../count_wigs.pl <"$file" >>wigcount.txt
done

cd ..
