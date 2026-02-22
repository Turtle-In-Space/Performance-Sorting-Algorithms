algos="algorithms/"

mapfile -t scripts < <(find $algos -name "run.sh")

tmp=("${args[--lower]}" "${args[--upper]}" "${args[--step]}" "${args[--iter]}")
[ -n "${args[--out]}" ] && tmp+=("${args[--out]}")

for f in ${scripts[@]}; do
  ./$f ${tmp[@]}
done;
