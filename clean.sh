#!/bin/bash
rm ./ChangeLog
rm -Rf  ./build-aux
rm ./configure.ac
rm ./Makefile.am
rm ./pre-inst-env.in
rm ./guix.scm
rm ./hall.scm
rm ./*.go
rm ./mutvis/*.go
rm ./scripts/*.*
rm ./mutvis-0.1.tar.gz
hall init --convert --author "mbc" mutvis --execute
hall scan -x
hall build -x
cp /home/mbc/syncd/tobedeleted/mutvis/guix.scm .

autoreconf -vif && ./configure && make
cp /home/mbc/syncd/tobedeleted/mutvis/Makefile.am .
cp /home/mbc/syncd/tobedeleted/mutvis/*.sh ./scripts
cp /home/mbc/syncd/tobedeleted/mutvis/*.aln .

make dist

git add .
git commit -a -S -m "changes for server"
git push

$1 = git log --format="%H" -n 1
$2 = guix hash -rx .


##scp -i /home/mbc/labsolns.pem ./shinyln-0.1.tar.gz admin@ec2-18-189-31-114.us-east-2.compute.amazonaws.com:.
##scp -i /home/mbc/labsolns.pem /home/mbc/syncd/tobedeleted/shinyln/guix.scm admin@ec2-18-189-31-114.us-east-2.compute.amazonaws.com:.
##guix package --install-from-file=guix.scm
##source /home/mbc/.guix-profile/etc/profile
