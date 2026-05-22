#!/usr/bin/env bash
set -euo pipefail

WORKDIR="$(pwd)"
DEVCONTAINER_CONFIG="${WORKDIR}/.devcontainer/devcontainer.json"
CONTAINER_LABEL="devcontainer.local_folder=${WORKDIR}"

usage() {
  echo "Usage: $(basename "$0") {start|stop|shell|exec|destroy|rebuild|status}"
  echo "  start    Build and start the devcontainer"
  echo "  stop     Stop the running devcontainer"
  echo "  shell    Open a shell in the running devcontainer"
  echo "  exec     Run a command in the running devcontainer"
  echo "  destroy  Stop and remove the devcontainer"
  echo "  rebuild  Rebuild the devcontainer image from scratch"
  echo "  status   Show the current state of the devcontainer"
  exit 1
}

check_workspace() {
  if [ ! -f "${DEVCONTAINER_CONFIG}" ]; then
    echo "Error: no devcontainer config found at ${DEVCONTAINER_CONFIG}" >&2
    echo "Run this command from the root of a project with .devcontainer/devcontainer.json." >&2
    exit 1
  fi
}

check_docker() {
  if ! command -v docker &>/dev/null; then
    echo "Error: Docker is not installed or not in PATH." >&2
    exit 1
  fi
  if ! docker info &>/dev/null; then
    echo "Error: Docker daemon is not running." >&2
    exit 1
  fi
}

check_devcontainer_cli() {
  if ! command -v devcontainer &>/dev/null; then
    echo "Error: devcontainer CLI is not installed." >&2
    exit 1
  fi
}

get_container_id() {
  docker ps -q --filter "label=${CONTAINER_LABEL}"
}

get_container_id_any() {
  docker ps -aq --filter "label=${CONTAINER_LABEL}"
}

cmd_status() {
  local running stopped
  running="$(get_container_id)"
  stopped="$(get_container_id_any)"

  if [ -n "${running}" ]; then
    echo "Container: ${running}"
    echo "Status: running"
  elif [ -n "${stopped}" ]; then
    echo "Container: ${stopped}"
    echo "Status: stopped"
  else
    echo "Status: not found"
  fi
}

cmd_start() {
  local output
  if ! output="$(devcontainer up --workspace-folder "${WORKDIR}" 2>&1)"; then
    echo "${output}"
    echo "Failed to start devcontainer." >&2
    exit 1
  fi
  local id
  id="$(get_container_id)"
  echo "Container: ${id}"
  echo "Status: started"
}

cmd_stop() {
  local id
  id="$(get_container_id)"
  if [ -z "${id}" ]; then
    echo "No running devcontainer found." >&2
    exit 1
  fi
  docker stop "${id}" >/dev/null
  echo "Container: ${id}"
  echo "Status: stopped"
}

cmd_shell() {
  local id
  id="$(get_container_id)"
  if [ -z "${id}" ]; then
    echo "Devcontainer is not running." >&2
    exit 1
  fi
  devcontainer exec --workspace-folder "${WORKDIR}" bash
}

cmd_exec() {
  local id
  id="$(get_container_id)"
  if [ -z "${id}" ]; then
    echo "Devcontainer is not running." >&2
    exit 1
  fi
  if [ $# -lt 1 ]; then
    echo "Error: exec requires a command." >&2
    echo "Usage: $(basename "$0") exec <command> [args...]" >&2
    exit 1
  fi
  devcontainer exec --workspace-folder "${WORKDIR}" "$@"
}

cmd_destroy() {
  local id
  id="$(get_container_id_any)"
  if [ -z "${id}" ]; then
    echo "No devcontainer found." >&2
    exit 1
  fi
  docker rm -f "${id}" >/dev/null
  echo "Container: ${id}"
  echo "Status: destroyed"
}

cmd_rebuild() {
  devcontainer build --no-cache --workspace-folder "${WORKDIR}"
}

[ $# -lt 1 ] && usage

cmd="$1"
shift

case "${cmd}" in
  -h|--help) usage ;;
esac

check_workspace
check_docker

case "${cmd}" in
  start)
    check_devcontainer_cli
    cmd_start
    ;;
  stop)
    cmd_stop
    ;;
  shell)
    check_devcontainer_cli
    cmd_shell
    ;;
  exec)
    check_devcontainer_cli
    cmd_exec "$@"
    ;;
  destroy)
    cmd_destroy
    ;;
  rebuild)
    check_devcontainer_cli
    cmd_rebuild
    ;;
  status)
    cmd_status
    ;;
  *)
    usage
    ;;
esac
