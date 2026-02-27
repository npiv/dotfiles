MvnRunSpring() {
  local port=8080

  if [ $# -gt 0 ]; then
    port="$1"
    shift
  fi

  mvn spring-boot:run \
    -Dspring-boot.run.profiles=dev \
    "-Dspring-boot.run.arguments=--server.port=${port}" "$@"
}

alias mrsp='MvnRunSpring'
