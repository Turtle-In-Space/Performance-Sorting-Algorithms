run() {
  local dir="$1"
  shift
  local run_args="$@"
  [[ -n "${args[--out]}" ]] && run_args+=" -o $dir/${args[--out]}"

  print_info "Running: " $dir 
  if ! eval $run_args; then
    print_warn "Running failed for $dir"
  fi
}

exec_run() {
  programs=$(get_program_folders)
  local -a tmp=(
    "-l ${args[--lower]}"
    "-u ${args[--upper]}"
    "-s ${args[--step]}"
    "-i ${args[--iter]}"
  )

  for dir in $programs; do
    case $(basename $dir) in 
      java)
        run $dir "java -jar $dir/target/sort.jar ${tmp[@]}"
      ;;
      go)
        run $dir "./$dir/sort ${tmp[@]}"
      ;;
      python)
        run $dir "python3 $dir/sort.py ${tmp[@]}"
      ;;
      c | cpp)
        run $dir "./$dir/sort ${tmp[@]}"
      ;;
      *)
        print_err "uh-oh"
      ;;
    esac
  done;
}

exec_run 
