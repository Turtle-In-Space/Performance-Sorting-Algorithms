algos="algorithms/"

mapfile -t scripts < <(find $algos -name "clean.sh")

for f in ${scripts[@]}; do
  ./$f
done;
