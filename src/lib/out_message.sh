print_ok() {
  echo "$(green [+])" "$@"
}

print_info() {
  echo "$(blue [*])" "$@"
}

print_warn() {
  echo "$(yellow [-])" "$@"
}

print_err() {
  echo "$(red [!])" "$@"
}
