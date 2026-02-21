algos="algorithms/"

mapfile -t scripts < <(find $algos -name "build.sh")

for f in ${scripts[@]}; do
  ./$f
done;
