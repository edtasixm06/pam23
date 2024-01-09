#! /bin/bash

for user in unix01 unix02 unix03 unix04 unix05
do
  useradd -m -s /bin/bash $user
  echo -e "$user\n$user" | passwd $user
done


/bin/bash
