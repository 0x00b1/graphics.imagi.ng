#!/bin/sh

IFS="
"

for line in `cat /srv/jupyter/userlist`; do
  test -z "$line" && continue

  user=`echo $line | cut -f 2 -d','`

  uid=`echo $line | cut -f 1 -d','`

  pubkey=`echo $line | cut -f 3 -d','`

  pass=`echo $line | cut -f 4 -d','`

  adminkey=`echo $line | cut -f 5 -d','`

  echo "adding user $user"

  useradd -m -s /bin/bash -u $uid $user || :

  echo "$user:$pass" | chpasswd

  if [ ! -f "/home/$user/.ssh/authorized_keys" ]; then
    echo "creating .ssh for $user"

    mkdir -p "/home/$user/.ssh/"

    echo $pubkey >> "/home/$user/.ssh/authorized_keys"
  fi

  chown -R $user:$user /home/$user

  chown -R $user:$user /home/$user/.ssh

  if [ "$adminkey" = "admin" ]; then
    :
    usermod -a -G sudo $user
  fi
done

exit 0
