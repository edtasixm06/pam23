# PAM 
## @edt ASIX M06-ASO Curs 2023-2024

Podeu trobar les imatges docker al Dockehub de [edtasixm06](https://hub.docker.com/u/edtasixm06/)

Podeu trobar la documentació del mòdul a [ASIX-M06](https://sites.google.com/site/asixm06edt/)

ASIX M06-ASO Escola del treball de barcelona


### PAM Containers:

 * **edtasixm06/pam23:base** Container PAM base per practicar regles PAM. Utilitza chfn per practicar els
   exmples del HowTo per aprendre el funcionament dels *type* (*auth*,*account*,*session* i*password*) i
   dels *control* bàsics (*sufficient*, *required*,*requisite* i *optional*) i avançats (*die*, *ok*).
   També permet practicar *pam_mount.so* per muntar unitats de *tmpfs* o *NFS* als usuaris.

Procediment per usar pam_mount.so

 * Instal·lar el paquet *libpam-mount*.
 * Configurar pam_mount en els dos controls apropiats: *auth* i *session*.
 * Configurar el fitxer */etc/security/pam_mount.conf.xml* per definir els recursos a muntar. Poden ser globals 
   (per a tots els usuaris: generalment es defineixen al fstab) o individuals (dins el home d'un usuari). 
 * Realitzar un exemple usant un sistema tmpfs de 100MB dins el home dels usuaris.
   Realitzar un exemple muntant dins el home dels usuaris un recurs NFS, per exemple el recurs /usr/share/doc. Per fer-ho
   cal muntar un servidor NFS per exemple en el propi host de l'alumne (no en un container!).


```
docker run --rm --name pam.edt.org -h pam.edt.org --net 2hisx --privileged -it edtasixm06/pam23:base 
```

