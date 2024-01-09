# PAM 
## @edt ASIX M06-ASO Curs 2022-2023

Podeu trobar les imatges docker al Dockehub de [edtasixm06](https://hub.docker.com/u/edtasixm06/)

Podeu trobar la documentació del mòdul a [ASIX-M06](https://sites.google.com/site/asixm06edt/)

ASIX M06-ASO Escola del treball de barcelona


### PAM Containers:


Exemples d'imatges per practicar PAM individualment i per practicar autnticació PAM amb ldap.


 * **edtasixm06/pam22:base** Container PAM base per practicar regles PAM. Utilitza chfn per practicar els
   exmples del HowTo per aprendre el funcionament dels *type* (*auth*,*account*,*session* i*password*) i 
   dels *control* bàsics (*sufficient*, *required*,*requisite* i *optional*) i avançats (*die*, *ok*).
   També permet practicar *pam_mount.so* per muntar unitats de *tmpfs* o *NFS* als usuaris.

``` 
docker run --rm --name pam.edt.org -h pam.edt.prg --net 2hisx -it edtasixm06/pam22:base

```


 * **edtasixm06/pam22:ldap** Container PAM per practicar l'autenticació PAM unix i PAM ldap. Utilitza els paquets
   *libpam-ldap*, *libnss-ldap*, *nscd* i *nslcd* per configurar l'accés al servei ldap i configura les regles PAM 
   per permetre tant usuaris unix com usuaris LDAP. En tots dos casos es munta en el home un recurs *tmpfs*
   temporal. En el cs dels usuaris LDAP si el seu home no existeix es crea usant *pam_mkhomedir.so*.


``` 
docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -d edtasixm06/ldap22:latest
docker run --rm --name pam.edt.org  -h pam.edt.prg  --net 2hisx --privileged -it edtasixm06/pam22:ldap

```

 * **edtasixm06/pam21:python** host pam basat en pam20:base per practicar crear una aplicació PAM Aware i per
   crear el nostre propi mòdul de PAM. Amb l'aplicació PAM Aware pamware.py es fa un programa que mostra els 
   números del 1 al 10 però sempre i quant l'usuari que l'executa sigui un usuari autenticat (pam_unix.so).

   Es dissenya un mòdul propi de PAM anomenat pam_mates.py que autentica els usuaris segons si saben respondre
   o no a una pregunta de mates. Els usuaris que en saben queden autenticats, si no diuen la resposta correcta
   es denega l'autenticació. Per poder usar un modul pam escrit en python cal descarregar, compilar i incorporar
   com a llibreia el mòdul pam_pyhton.so.


``` 
$ docker run --rm --name pam.edt.org --hostname pam.edt.org --net 2hisix -it edtasixm06/pam21:python

# Test pam_pyhton.so pam_mates.py
su - unix01
chfn

# Test pamwarare.py
python3 /opt/docker/pamaware.py
```

 * **edtasixm06/pam21:homes-sshfs** host pam client de ssh que munta els homes dels usuaris via sshfs. Està 
   desenvolupat en realitat en el repositori: *edtasixm06/ssh21:sshfs*

 * **edtasixm06/pam19:nfs** host pam client que munta el home dels usuaris via nfs. Utilitza el servidor nfs
   desenvolupat en el repositori: nfs19:pam (aquest és el server nfs).



