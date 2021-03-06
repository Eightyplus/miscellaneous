#!/bin/sh
# Fra supporten på Uni.
# Jeg havde brug for at lave en mappe som kun kan ses hvis man er staff
# her i huset - og kun internet på web, hmmm, så kan studerende se det
# på web...

cd /pack/www
mkdir forskningsresultat

# Den skal kun adgang for staff - og alle staff
# kan endvidere og skrive i mappen, hmmm...

chgrp staff forskningsresultat
chmod 770 forskningsresultat

# Så langt, men nu kan webserveren ikke læse den,
# men det kan gøres med setfacl

setfacl -m u:60001:r-x forskningsresultat

# Og det ser så sådan ud:

ls -ld forskningsresultat
getfacl forskningsresultat

# # file: forskningsresultat
# # owner: root
# # group: staff
# user::rwx
# user:nobody:r-x         #effective:r-x
# group::rwx              #effective:rwx
# mask:rwx
# other:---

# ||||||||||||||||||||||||||||||||||||||||
# eller

setfacl - u:apache:r-x passwd
