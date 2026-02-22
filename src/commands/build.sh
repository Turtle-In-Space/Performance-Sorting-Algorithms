local -a scripts
mapfile -t scripts < <(get_scripts "build")
run_scripts scripts "build" 
