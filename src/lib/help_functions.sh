set -Eeo pipefail
trap 'print_stack_trace' ERR

print_ok() {
  echo "$(green [+])" "$@"
}

print_info() {
  echo "$(blue [*])" "$@"
}

print_warn() {
  echo "$(yellow [-])" "$@"
}

print_err() {
  echo "$(red [!])" "$@"
}

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

  if ((${#scripts_ref[@]} == 0)); then
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

get_scripts() {
  local type="$1"
  local algo="${args[--algo]//,/|}"
  local lang="${args[--lang]//,/|}"

  find $algos_folder -name "$type.sh" | grep -E "$algo" | grep -E "$lang" 
}

print_stack_trace() {
  local exit_code=$?

  echo "Error (exit code $exit_code)"
  echo "Stack trace:"

  for ((i=${#FUNCNAME[@]}-1; i>=1; i--)); do
    local func="${FUNCNAME[i]}"
    local line="${BASH_LINENO[i-1]}"
    local file="${BASH_SOURCE[i]}"

    printf '  at %s (%s:%s)\n' "$func" "$file" "$line"
  done
}
