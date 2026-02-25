build() {
  local dir="$1"
  local cmd="$2"

  print_info "Building: " $dir
  if ! eval $cmd; then
    print_warn "Build failed for $dir"
  fi
}

exec_build() {
  programs=$(get_program_folders)

  for dir in $programs; do
    case $(basename $dir) in 
      java)
        build $dir "mvn package -q -f $dir"
      ;;
      go)
        build $dir "go build -C $dir"
      ;;
      python)
      ;;
      c | cpp)
        build $dir "make -s -C $dir"
      ;;
    esac
  done;
}

exec_build 
