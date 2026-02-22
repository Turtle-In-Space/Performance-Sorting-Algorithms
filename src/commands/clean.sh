algos="algorithms/"

mapfile -t scripts < <(find $algos -name "clean.sh")
mapfile -t data < <(find $algos -name "data.csv")

for f in ${scripts[@]}; do
  ./$f
done;

for f in ${data[@]}; do
  rm $f
done;
