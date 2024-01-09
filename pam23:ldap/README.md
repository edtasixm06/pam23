# PAM
## @edt ASIX M06-ASO Curs 2023-2024

Podeu trobar les imatges docker al Dockehub de [edtasixm06](https://hub.docker.com/u/edtasixm06/)

Podeu trobar la documentació del mòdul a [ASIX-M06](https://sites.google.com/site/asixm06edt/)

ASIX M06-ASO Escola del treball de barcelona


### PAM Containers:

 * **edtasixm06/pam23:ldap** Container PAM base per practicar autenticació unix i LDAP.
   Utilitza els paquets *libpam-ldap*, *libnss-ldap*, *nscd* i *nslcd* per configurar l'accés al servei ldap
   i configura les regles PAM per permetre tant usuaris unix com usuaris LDAP. En tots dos casos es 
   munta en el home un recurs tmpfs temporal. En el cs dels usuaris LDAP si el seu home no existeix
   es crea usant pam_mkhomedir.so.


### Configuració:

 * Cal instal·lar els paquets *libpam-ldap* i *libnss-ldap*.
 * Configurar el client ldap per definir com accedir al servidor ldap per defecte: */etc/ldap/ldap.conf*.
 * Configurar la resolució de noms de */etc/nsswitch* per indicar *files* i *ldap* per a le sbases de dades 
   de *passwd* i *groups*. 
 * Configurar /etc/nslcd.conf per indicar on s'ha de connectar per obtenir la informació LDAP, el proveïdor
   d'informació dels comptes d'usuari **IP: Information provider** i també el **AP: Authentication Provider**,
   perquè en aquest exemple LDAP proporciona tant la informació dels comptes d'usuari de xarxa com el seu password.
 * Engegar els serveis *nscd* i *nslcd*.
 * **Validació-1 Acceś al IP** en aquest punt el host PAM està configurat per accedir a la informació LDAP de 
   manera que les ordres getent han de funcionar i serveixen de mecanisme de validació de si tot està correctament
    configurat o no.

```
$ getent passwd
$ getent group
```

 * Configuració de les regles PAM per incloure autenticació unix i autenticació LDAP. Cal configurar tots 
   els *type* per incloure l'autenticació pam_ldap.so.
 * **Validació-2 Autenticació LDAP i unix** un cop configurats els fitxers de PAM els usuaris han de poder 
   iniciar sessió tant si són usuaris unix com si són usuaris de LDAP.
 * Configurar */etc/security/pam.mount.conf.xml* per incloure el recurs de disk temporal *tmpfs* que cal muntar
   automàticament dins del home de cada usuari en iniciar sessió.


#### Descripció dels usuaris:

 * Usuaris unix: unix01(unix01), unix02(unix02), unix03(unix03), unix04(unix04)  i unix05(unix05)
 * Usuaris LDAP: pere(pere), marta(marta), anna(anna), jordi(jordi), pau(pau), user01(jupiter)...user09(jupiter)


``` 
docker build --no-cache -t edtasixm06/pam23:ldap .

docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -d edtasixm06/ldap23:latest
docker run --rm --name nfs.edt.org  -h nfs.edt.org  --net 2hisx --privileged -v data-nfs:/export -p 2049:2049 -d edtasixm06/nfs23:alpine
docker run --rm --name pam.edt.org  -h pam.edt.prg  --net 2hisx --privileged -d edtasixm06/pam23:ldap
```
