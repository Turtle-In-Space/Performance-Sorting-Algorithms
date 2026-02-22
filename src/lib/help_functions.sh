print_ok() {
  echo "$(green [+])" "$@"
}

print_info() {
  echo "$(blue [*])" "$@"
}

print_warn() {
  echo "$(orange [-])" "$@"
}

print_err() {
  echo "$(red [!])" "$@"
}
