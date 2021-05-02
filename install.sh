#!/usr/bin/env bash

if [[ -x "$(command -v ansible-playbook)" ]]; then
  cat <<EOF >/etc/ansible
[defaults]
callback_whitelist = profile_tasks
EOF

  echo "Please install latest version of ansible with pip3"
  exit 0
fi

ansible-playbook setup.yml
