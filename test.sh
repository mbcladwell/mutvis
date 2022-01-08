#!/bin/bash

git log --format="%H" -n 1 $COMMIT

HASH=$(guix hash -rx .)

sed -i "s/\"[:alnum:]+\"/"$COMMIT"/g" /home/mbc/projects/mutvis/target.scm

echo  $COMMIT
echo "hash:" $HASH


##scp -i /home/mbc/labsolns.pem ./shinyln-0.1.tar.gz admin@ec2-18-189-31-114.us-east-2.compute.amazonaws.com:.
##scp -i /home/mbc/labsolns.pem /home/mbc/syncd/tobedeleted/shinyln/guix.scm admin@ec2-18-189-31-114.us-east-2.compute.amazonaws.com:.
##guix package --install-from-file=guix.scm
##source /home/mbc/.guix-profile/etc/profile
