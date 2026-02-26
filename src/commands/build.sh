exec_build() {
  programs=$(get_program_folders)

  for dir in $programs; do
    case $(basename $dir) in 
      java)
        exec_cmd $dir "mvn package -q -f $dir" "Building"
      ;;
      go)
        exec_cmd $dir "go build -C $dir" "Building"
      ;;
      python)
      ;;
      c | cpp)
        exec_cmd $dir "make -s -C $dir" "Building"
      ;;
    esac
  done;

  print_ok "Done"
}

exec_build 

