mapfile -t scripts < <(find $algos -name "build.sh")

print_info "Starting build scripts..."
for f in ${scripts[@]}; do
  print_info "Running:" $f
  ./$f
done;
print_ok "Done"
