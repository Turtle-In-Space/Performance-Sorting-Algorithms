run_scripts() {
  local -n scripts_ref="$1"
  local name="$2"

  if ((${#scripts_ref[@]} == 0)); then
    print_warn "No scripts found!"
    return 0
  fi

  print_info "Starting" "$name" "scripts..."

  for f in "${scripts_ref[@]}"; do
    print_info "Running:" "$f"

    ./$f
  done

  print_ok "Done"
}

run_scripts_with_params() {
  local -n scripts_ref="$1"
  local name="$2"
  local -n script_args_ref="$3"

  if (( ${#scripts_ref[@]} == 0 )); then
    print_warn "No scripts found!"
  return 0
  fi

  print_info "Starting" "$name" "scripts..."

  for f in "${scripts_ref[@]}"; do
    print_info "Running:" "$f"

    ./$f ${script_args_ref[@]}
  done

  print_ok "Done"
}

get_program_folders() {
  local -a algos langs
  local -a results=()

  # split comma lists into arrays
  IFS=',' read -ra algos <<< "${args[--algo]:-}"
  IFS=',' read -ra langs <<< "${args[--lang]:-}"

  # if empty, match all
  ((${#algos[@]})) || algos=("*")
  ((${#langs[@]})) || langs=("*")

  for a in "${algos[@]}"; do
    for l in "${langs[@]}"; do
      for d in "$algos_folder"/$a/$l; do
        [[ -d $d ]] && results+=("$d")
      done
    done
  done

  printf '%s\n' "${results[@]}"
}
