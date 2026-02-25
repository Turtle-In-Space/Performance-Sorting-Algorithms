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
