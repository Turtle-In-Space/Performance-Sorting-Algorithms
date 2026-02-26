names=()
files=()

programs=$(get_program_folders)
for dir in $programs; do
  files+=$(find $dir -name "*.csv")
  files+=" "
  
  # make filepath into proper name
  # strip algo folder, remove slashes and add to names
  names+=$(echo ${dir#"$algos_folder/"} | sed 's/\//-/')
  names+=" "
done;

files_str="${files[*]}"
names_str="${names[*]}"
axis=${args[--logscale]}

gnuplot -e "axis='$axis'; files='$files_str'; names='$names_str'; out='$outfile'" $plot_script
