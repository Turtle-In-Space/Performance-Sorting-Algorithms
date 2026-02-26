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

exec_clean() {
  programs=$(get_program_folders)

  for dir in $programs; do
    case $(basename $dir) in 
      java)
        exec_cmd $dir "mvn clean -q -f $dir" "Cleaning"
      ;;
      go)
        exec_cmd $dir "go clean -C $dir" "Cleaning"
      ;;
      python)
      ;;
      c | cpp)
        exec_cmd $dir "make clean -s -C $dir" "Cleaning"
      ;;
    esac
  done;

  print_ok "Done"
}

exec_clean
remove_files 
