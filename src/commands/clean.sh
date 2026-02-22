mapfile -t scripts < <(find $algos -name "clean.sh")

print_info "Starting clean scripts..."
for f in ${scripts[@]}; do
  print_info "Running:" $f
  ./$f
done;
print_ok "Done"

mapfile -t data < <(find $algos -name "data.csv")

print_info "Removing created files..."
for f in ${data[@]}; do
  rm $f
done;

rm $outfile
