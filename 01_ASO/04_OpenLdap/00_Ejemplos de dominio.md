# ADD
## Unidades organizativas
~~~nano
dn: ou=clientes,dc=barcelona,dc=techservices,dc=com
objectClass: top
objectClass: organizationalUnit
ou: clientes

dn: ou=personal,dc=barcelona,dc=techservices,dc=com
objectClass: top
objectClass: organizationalUnit
ou: personal

dn: ou=proveedores,dc=barcelona,dc=techservices,dc=com
objectClass: top
objectClass: organizationalUnit
ou: proveedores

dn: ou=zonas,ou=proveedores,dc=barcelona,dc=techservices,dc=com
objectClass: top
objectClass: organizationalUnit
ou: zona-a

dn: ou=zona-a,ou=zonas,ou=proveedores,dc=barcelona,dc=techservices,dc=com
objectClass: top
objectClass: organizationalUnit
ou: zona-a

dn: ou=zona-b,ou=zonas,ou=proveedores,dc=barcelona,dc=techservices,dc=com
objectClass: top
objectClass: organizationalUnit
ou: zona-b
~~~
## Grupos
~~~nano
dn: cn=suscritos,ou=clientes,dc=barcelona,dc=techservices,dc=com
objectClass: top
objectClass: posixGroup
gidNumber: 5000
cn: suscritos

dn: cn=no-suscritos,ou=clientes,dc=barcelona,dc=techservices,dc=com
objectClass: top
objectClass: posixGroup
gidNumber: 5001
cn: no-suscritos
~~~
## Usuarios
~~~
dn: uid=aruiz,ou=zona-a,ou=proveedores,dc=barcelona,dc=techservices,dc=com
objectClass: top
objectClass: posixAccount
objectClass: inetOrgPerson
objectClass: shadowAccount
uid: aruiz
sn: Ruiz
givenName: Ana
cn: AnaRuiz
uidNumber: 1200
gidNumber: 5001
userPassword: {SSHA}lzUt3pmXlPDwoVr2w+W2Xp9PLnWRlfsg
homeDirectory: /home/aruiz
loginShell: /bin/bash
mail: aruiz@gmail.com
telephoneNumber: 914123456

dn: uid=aperez,ou=zona-b,ou=proveedores,dc=barcelona,dc=techservices,dc=com
objectClass: top
objectClass: posixAccount
objectClass: inetOrgPerson
objectClass: shadowAccount
uid: aperez
sn: Perez
givenName: Angela
cn: AngelaPerez
uidNumber: 1201
gidNumber: 5000
userPassword: {SSHA}TxvR8iiHlvNKGz8g+tfdaPmeoIZnXGZd
homeDirectory: /home/aperez
loginShell: /bin/bash
mail: aperez@gmail.com
telephoneNumber: 914654321
~~~
Comando: `ldapadd -x -D "cn=admin,dc=barcelona,dc=teckservice,dc=com" -W -H ldap://localhost -f esquema.ldif`
# Deletes
~~~
dn: ou=zona-b,ou=zonas,ou=proveedores,dc=barcelona,dc=techservices,dc=com
changetype: delete

dn: cn=suscritos,ou=clientes,dc=barcelona,dc=techservices,dc=com
changetype: delete

dn: uid=aperez,ou=zona-b,ou=proveedores,dc=barcelona,dc=techservices,dc=com
changetype: delete
~~~
Comando `ldapmodify -x -D "cn=admin,dc=barcelona,dc=techservices,dc=com" -W -f delete_entries.ldif`

# Modify
~~~
dn: uid=aperez,ou=zona-b,ou=proveedores,dc=barcelona,dc=techservices,dc=com
changetype: modify
replace: telephoneNumber
telephoneNumber: 600123456
~~~
Comando: `ldapmodify -x -D "cn=admin,dc=barcelona,dc=techservices,dc=com" -W -f modify_telephone.ldif`