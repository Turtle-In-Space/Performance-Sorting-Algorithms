mapfile -t scripts < <(find $algos_folder -name "build.sh")

get_scripts
run_scripts $scripts "build"
