remove_files() {
  local -a data
  
  print_info "Removing created files..."

  mapfile -t data < <(find $algos_folder -name "data.csv")
  for f in ${data[@]}; do
    rm -f $f
  done;

  rm -f $outfile
  print_ok "Done"
}

run_clean_scripts() {
  local scripts=$(get_scripts "clean")

  run_scripts scripts "clean"
}

run_clean_scripts 
remove_files 
