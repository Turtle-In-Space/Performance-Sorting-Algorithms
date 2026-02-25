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

clean() {
  local dir="$1"
  local cmd="$2"

  print_info "Cleaning: " $dir
  if ! eval $cmd; then
    print_warn "Cleaning failed for $dir"
  fi
}

exec_clean() {
  programs=$(get_program_folders)

  for dir in $programs; do
    case $(basename $dir) in 
      java)
        clean $dir "mvn clean -q -f $dir"
      ;;
      go)
        clean $dir "go clean -C $dir"
      ;;
      python)
      ;;
      c | cpp)
        clean $dir "make clean -q -C $dir"
      ;;
      *)
        print_err "uh-oh"
      ;;
    esac
  done;
}

exec_clean
remove_files 
