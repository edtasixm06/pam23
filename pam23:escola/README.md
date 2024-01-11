# PAM
## @edt ASIX M06-ASO Curs 2023-2024

Podeu trobar les imatges docker al Dockehub de [edtasixm06](https://hub.docker.com/u/edtasixm06/)

Podeu trobar la documentació del mòdul a [ASIX-M06](https://sites.google.com/site/asixm06edt/)

ASIX M06-ASO Escola del treball de barcelona


### PAM Containers:

 * **edtasixm06/pam23:escola** Container PAM per configurar un host com a client de la xarxa
   de l'escola. Fa l'autenticació contra el servidor ldap de l'escola. Crea le home d el'usuari
   i munta dins seu un recurs de xarxa corresponent al *WebDav* de l'usuari.


### Configuració:

 * Configurar el client ldap per definir com accedir al servidor ldap *ldap.escoladeltreball.org* al base
   search *'dc=escoladeltreball,dc=org'*.
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
 * Incloure al common-session el mòdul *pam_mkhomedir.so* per garantir la creació del directori home de 
   l'usuari.
 * Configurar */etc/security/pam.mount.conf.xml* per incloure el recurs de xarxa provinent del servidor
   *WebDav*. Cal muntar-lo al home de l'usuari amb el mateix nom (o user-dav) per exemple.

   Validar manualment si la connectivitat al recurs WebDav de l'escola funciona:
   ```
   mount.davfs -v https://cloud.proxy.inf.edt.cat:5511/remote.php/dav/files/usuari-alumne  /mnt

   mount -t fuse
       <observeu les característiques d'aquest muntatge>

   umount /mnt
   ```

   Exemple de muntatge WebDav al pam_mount.conf.xml
   ```
   <volume 
      uid="*" 
      fstype="davfs" 
      path="https://cloud.proxy.inf.edt.cat:5511/remote.php/dav/files/%(USER)" 
      mountpoint="~/%(USER)dav"
      options="username=%(USER),uid=%(USERUID),gid=%(USERGID),file_mode=0770,dir_mode=0770"
   />
   ```

#### Descripció dels usuaris:

 * Usuaris unix: unix01(unix01), unix02(unix02), unix03(unix03), unix04(unix04)  i unix05(unix05)
 * Usuaris LDAP: pere(pere), marta(marta), anna(anna), jordi(jordi), pau(pau), user01(jupiter)...user09(jupiter)


``` 
docker run --rm --name pam.edt.org  -h pam.edt.prg  --net 2hisx --privileged -d edtasixm06/pam23:escola
```
