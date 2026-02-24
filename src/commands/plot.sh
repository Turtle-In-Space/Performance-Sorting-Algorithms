names=()

mapfile -t files < <(find $algos_folder -name "*.csv")

# make filepath into proper name
for f in "${files[@]}"; do
  # strip algo folder, remove slashes and add to names
  names+=("$(dirname ${f#"$algos_folder"} | sed 's/\//-/')")
done

files_str="${files[*]}"
names_str="${names[*]}"
axis=${args[--logscale]}

gnuplot -e "axis='$axis'; files='$files_str'; names='$names_str'; out='$outfile'" $plot_script
