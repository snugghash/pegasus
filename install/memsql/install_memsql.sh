#!/bin/bash

# Copyright 2015 Insight Data Science
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

MEMSQL_INSTALLS_DIR=/usr/local/memsql
if [ ! -d ${MEMSQL_INSTALLS_DIR} ]; then
  TECHNOLOGY_URL=http://download.memsql.com/memsql-ops-5.1.0/memsql-ops-5.1.0.tar.gz
  curl -sL $TECHNOLOGY_URL | gunzip | sudo tar xv -C ~ >> ~/peg_log.txt
  if [ -d ~/memsql* ]; then
    cd memsql*
    sudo ./install.sh --ops-datadir /usr/local/memsql-ops-data --memsql-installs-dir ${MEMSQL_INSTALLS_DIR}
  fi
fi

if ! grep "export MEMSQL_HOME" ~/.profile; then
  echo -e "\nexport MEMSQL_HOME="${MEMSQL_INSTALLS_DIR}"\nexport PATH=\$PATH:\$MEMSQL_HOME/bin" | cat >> ~/.profile

  . ~/.profile

  echo "Memsql installed"
fi
