local -a tmp=(
  "${args[--lower]}"
  "${args[--upper]}"
  "${args[--step]}"
  "${args[--iter]}"
)

[[ -n "${args[--out]}" ]] && tmp+=("${args[--out]}")

local -a scripts
mapfile -t scripts < <(get_scripts "run")
run_scripts_with_params scripts "run" tmp
