print_ok() {
  echo "$(green [+])" "$@"
}

print_info() {
  echo "$(blue [*])" "$@"
}

print_warn() {
  echo "$(orange [-])" "$@"
}

print_err() {
  echo "$(red [!])" "$@"
}

run_scripts() {
  if [[ $# -ne 2 ]]; then
    return 0
  fi

  local scripts="$1"
  local name="$2"

  print_info "Starting" $name "scripts..."
  for f in ${scripts[@]}; do
    print_info "Running:" $f
    ./$f
  done;
  print_ok "Done"
}

get_scripts() {
  local type="$1"
  local algo="${args[--algo]//,/|}"
  local lang="${args[--lang]//,/|}"

  find $algos_folder -name "$type.sh" | grep -E "$algo" | grep -E "$lang" 
}
