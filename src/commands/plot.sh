plot_folder="./plotting"
algos="algorithms/"
plot_script="$plot_folder/plot.gp"
outfile="$plot_folder/graph.png"
names=()

mapfile -t files < <(find $algos -name "*.csv")

# make filepath into proper name
for f in "${files[@]}"; do
  # strip algo folder, remove slashes and add to names
  names+=("$(dirname ${f#"$algos"} | sed 's/\//-/')")
done

files_str="${files[*]}"
names_str="${names[*]}"

gnuplot -e "files='$files_str'; names='$names_str'; out='$outfile'" $plot_script
