mapfile -t scripts < <(find $algos_folder -name "run.sh")

tmp=("${args[--lower]}" "${args[--upper]}" "${args[--step]}" "${args[--iter]}")

[ -n "${args[--out]}" ] && tmp+=("${args[--out]}")

print_info "Starting run scripts..."

for f in ${scripts[@]}; do
  print_info "Running:" $f
  ./$f ${tmp[@]}
done;

print_ok "Done"
