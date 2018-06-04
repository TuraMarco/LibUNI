# Autore: TURA MARCO
# GIT: https://github.com/TuraMarco/LibUNI

################
#     LDAP     #
################

# LDIF ---------------------------------------------------------------------------------------------------------------------------------------------------
# L'LDIF è iun file formattato esplicitamente per scambiare entry LDAP, 
#   è formatato come una lista di entry separate da linee vuote.

dn: dc=labammsis            # distinguish name, identifica univocamente la entry ed è sempre presente.
objectClass: dcObject       # object class, puo essere una o piu e definisce il tipo della entry
objectClass: organization   # posso avere diverse objectClass a definire il tipo della entry
dc: labammsis               # attributo di tipo dc:
o: university               # attributo di tipo o:

# Identifico una entry univocamente con il suo DN (Distinguished Name) che è la somma del BDN
#   BDN (Base Distinguished Name) che è il nodo dell'albero a cui la entry è appesa.
#   RDN (Relative Distinguished Name) che è un attributo della entry schielto arbitrariamente.
# Posso concatenare 2 attributi con l'operatore '+' al fine di garantire l'univocità del RDN
    cn=Marco+sn=Tura,ou=....,dc=....
# In ogni entry DEVE comparire una classe STRUCTURAL e POSSONO comparire classi AUXILIARY cosi posso risolvere
#   le ereditarietà multiple
#
# Per estendere il funzionamento di LDAP si usa uno schema che può contenere:
#   |- attributeType ---> Definisce i tipi di dato e le regole di comparazione.
#   \_ objectClass ---> Vincola i tipi di attributi nella entry.
#
# Un attributeType è l'equivalente del tipo di una variabile che specifica oltre al dominio dei valori
#   i criteri di confronto: 
#       |- ORDERING ---------------> Come ordinare due elementi dello stesso tipo
#       |- SUBSTRING --------------> Come considerare una sottostringa
#       \_ EQUALITY ---------------> Come condsiderare uguali due attributi dello stesso tipo
#   eventuali vincoli d'uso:
#       \_ SINGLE-VALUE -----------> Ammesso un solo valore di questo tipo nella entry
#   ed eventuali dipendenze gerarchiche:
#       \_ SUP --------------------> il tipo eredita tutte le proprietà del superiore, ne può ridefinire, e nelle ricerche
#                                       per un tipo superiore vengono restituiti anche tutti i valori dei tipi basati su di
#                                       esso

    olcAttributeTypes: ( 1000.1.1.1 NAME ( 'fn' 'filename' )    # OID e nomi del nuovo attributo
        DESC 'nome del file'                                    # Descrizione nuovo attributo
        EQUALITY caseExactMatch                                 # Criterio di eguaglianza ("case sensitive, space insensitive" in questo caso)                          
        SUBSTR caseExactSubstringsMatch                         # Criterio di sottostringa ("case sensitive, space insensitive" in questo caso)
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )                  # Sintassi che deve rispettare ("directoryString" in questo caso)

# Un objectClass è un elenco di attributi opzionali (MAY) ed obbligatori (MUST) all'interno di una entry,
#   possono essere di 3 tipi differenti:
#       |- ABSTRACT -----> Servono per creare una tassonomia, non possono essere usate per originare entry (simili alle classi astratte java).
#       |- STRUCTURAL ---> Servono per descrivere categorie di oggetti concreti (simili alle classi concrete in java).
#       \_ AUXILIARY ----> Servono per aggiungere attributi arricchendo di contenuto informativo una entry (simili alle interfacce in java). 
#   le classi possono essere estese gerarchicamente con SUP, in questo caso la classe inferiore eredita tutti gli attributi MUST e MAY della superiore,
#       e può aggiungerne di nuovi.

    olcObjectClasses: ( 1000.2.1.1 NAME 'dir'   # OID e Nome della classe
        DESC 'una directory'                    # Descrizione della classe
        MUST fn                                 # Attributo obbligatorio
        MAY fs                                  # Attributo facoltativo
        AUXILIARY)                              # Tipologia della classe

#
#       ##############################
#       #   Commonly Used Syntaxes   #
#       ##############################
#       NAME                OID                             DESCRIPTION
#       boolean	            1.3.6.1.4.1.1466.115.121.1.7	boolean value
#       directoryString     1.3.6.1.4.1.1466.115.121.1.15	Unicode (UTF-8) string
#       distinguishedName	1.3.6.1.4.1.1466.115.121.1.12	LDAP DN
#       integer	            1.3.6.1.4.1.1466.115.121.1.27	integer
#       numericString	    1.3.6.1.4.1.1466.115.121.1.36	numeric string
#       OID	                1.3.6.1.4.1.1466.115.121.1.38	object identifier
#       octetString	        1.3.6.1.4.1.1466.115.121.1.40	arbitary octets
#
#       ####################################
#       #   Commonly Used Matching Rules   #
#       ####################################
#       NAME	                            TYPE	    DESCRIPTION
#       booleanMatch	                    equality	boolean
#       caseIgnoreMatch	                    equality	case insensitive, space insensitive
#       caseIgnoreOrderingMatch	            ordering	case insensitive, space insensitive
#       caseIgnoreSubstringsMatch	        substrings	case insensitive, space insensitive
#       caseExactMatch	                    equality	case sensitive, space insensitive
#       caseExactOrderingMatch	            ordering	case sensitive, space insensitive
#       caseExactSubstringsMatch	        substrings	case sensitive, space insensitive
#       distinguishedNameMatch	            equality	distinguished name
#       integerMatch	                    equality	integer
#       integerOrderingMatch	            ordering	integer
#       numericStringMatch	                equality	numerical
#       numericStringOrderingMatch	        ordering	numerical
#       numericStringSubstringsMatch	    substrings	numerical
#       octetStringMatch	equality	    octet       string
#       octetStringOrderingStringMatch	    ordering	octet string
#       octetStringSubstringsStringMatch	ordering	octet string
#       objectIdentiferMatch	            equality	object identifier       

# INSERIMENTO NUOVI SCHEMI ------------------------------------------------------------------------------------------------------------------------------------
# LDAP ha la particolarità di autodescriversi, in breve tutte le direttive di configurazione sono 'attribut' in 'entry' 
#   di un albero separato da quello dei dati veri e propri
#
#   cn=MioSchema,cn=schema,cn=config ---> questa entry contiene il mio schema personale con AttributeType ed ObjectClass personali
#   olcDatabase=mdb,cn=config ---> contiene fra le altre cose il 'domainComponent' (dc) che fà riferimento al mio database 
#                                     come valore dell'attributo 'olcSuffix'.
#
#   Una volta definito il mio file LDIF che descrive il mio schema personale posso aggiungerlo attraverso la direttiva:
(sudo) ldapadd -Y EXTERNAL -H ldapi:/// -f MioSchema.ldif

# ELIMINAZIONE SCHEMI-----------------------------------------------------------------------------------------------------------------------------------------
# Nel caso sia necessario modificare uno schema definito precedentemente, il modo pi`u semplice per farlo `e quello
#   di eliminarlo e successivamente ridefinirlo.
#   Ogni schema non `e altro che un file ldif all’interno della cartella /etc/ldap/slapd.d/cn=config/cn=schema/
#   Nel caso dell’esempio filesystem trattato in precedenza, per eliminarlo bisogner`a procedere in questo modo:
#
#   1) Stoppo il demone slapd con il comando.
#       
#       sudo systemctl stop slapd
#
#   2) Come utente root navigo nella directory degli schemi.
#
#       cd "/etc/ldap/slapd.d/cn=config/cn=schema/"
#
#   3) Cerco il file con il nome dello schema da elimiare con, nel nostro caso cn={n}filesystem.ldif, con 'n' variabile in funzione dello schema.
#
#       rm "cn={4}filesystem.ldif"
#
#   4) In fine riavvio il demone con il comando:
#
#       sudo systemctl start slapd
#
#   A questo punto possiamo modificare il file LDIF e riaggiungere lo schema aggiornato

# RICERCA ENTRY ----------------------------------------------------------------------------------------------------------------------------------------------
# La ricerca deve specificare:
#   |- Un BIND DN ----> utente con cui autenticarsi sul server LDAP
#   |- Un BASE DN ----> nodo da cui iniziare la ricerca
#   |- uno SCOPE -----> definisce quanto estendere la ricerca
#   |                       |- SUB ---> Intero Sottoalbero (Default)
#   |                       |- ONE ---> I soli figli diretti del BASE DN
#   |                       \_ BASE --> Il solo nodo BASE DN
#   \_ eventualmente un FILTRO ---> utile per eseguire una ricerca per contenuto delle entry anziche posizionale, si crea sfruttando 
#                                       delle espressioni logiche in notazione prefissa.
#
#       ####################################
#       #    Sintassi Filtri ldapsearch    #
#       ####################################
#       <filter>::='('<filtercomp>')'
#       <filtercomp>::=<and>|<or>|<not>|<item>
#       <and>::='&'<filterlist>
#       <or>::='|'<filterlist>
#       <not>::='!'<filter>
#       <filterlist>::=<filter>|<filter><filterlist>
#       <item>::=<simple>|<present>|<substring>
#       <simple>::=<attr><filtertype><value>
#       <filtertype>::=<equal>|<approx>|<greater>|<less>
#       <equal>::='='
#       <approx>::='~='
#       <greater>::='>='
#       <less>::='<='
#       <present>::=<attr>'=*'
#       <substring>::=<attr>'='<initial><any><final>
#       <initial>::=NULL|<value>
#       <any>::='*'<starval>
#       <starval>::=NULL|<value>'*'<starval>
#       <final>::=NULL|<value>

(cn=Babs Jensen)    # Ricerca la entri con questo attributo

(!(cn=Tim Howes))   # Ricerca la entry che NON ha questo attributo

(&                                  # Ricerca la entry composta da
(objectClass= Person)           # questo in AND logico
(|
    (sn= Jensen)(cn= Babs J*)   # con l'OR logico di questi due
)
)

(o= univ*of*m ich*) # Ricerca la entry che possiede un attributo che rispecchia il path con le wildcard

(&                                  # Ricerca la entry composta da
(|                              # l'OR logico 
    (uid= jack)(uid= jill)      # di queste due
)
(objectclass= posix Account)    # in AND logico con questa
)

# Il comando per eseguire ricerche è:
(sudo) ldapsearch -x -b dc=labammsis [ -s base | one | sub ] [filtro]
#   -x ----> permette un autenticazione con metodo standard
#   -b dc=labammsis ----> il nodo da cui partire per fare la ricerca (dc=labammsis in questo caso)
#   [ -s base | one | sub ] ----> quanto estendere la ricerca (defoult sub quindi intero sotto albero)

# AGGIUNTA ENTRY ----------------------------------------------------------------------------------------------------------------------------------------------
# Per aggiungere una entry nella directory uso il comando:
(sudo) ldapadd -x -D "cn=admin,dc=labammsis" -w admin [ -f file_ldif_da_inserire ]
#   -x ----> permette un autenticazione con metodo standard
#   -D "cn=admin,dc=labammsis" -w admin ----> autenticazione con username e password
#   -f ----> nel caso venga omesso si usa lo std_in

# MODIFICA ENTRY ----------------------------------------------------------------------------------------------------------------------------------------------
# Per modificare una entry nella directory uso il comando:
(sudo) ldapmodify -x -D "cn=admin,dc=labammsis" -w admin -f ./entrymods.ldif
#   -x ----> permette un autenticazione con metodo standard
#   -D "cn=admin,dc=labammsis" -w admin ----> autenticazione con username e password
#   -f ./entrymods ----> file cntenente le direttive di modifica delle entry
#
#   Il file in base  come è formattato puo permettere svariate operazioni di modifica: aggiunta / modifica / rimozione di attributi

#   LDIF per modifica attributi entry
dn: cn=Modify Me,dc=example,dc=com          # DistinguishName della entry da modificare
changetype: modify                              # Tipo di operazione da eseguire sulla entry (modifica in questo caso)
replace: mail                                   # sostituzione del valore dell'attributo
mail: modme@example.com                         # con il il nuovo valore
-
add: title                                  # Aggiunta di un attributo title
title: Grand Poobah                             # con il valore specificato
-
add: jpegPhoto                              # Aggiunta di un attributo jpegPhoto 
jpegPhoto:< file:///tmp/modme.jpeg              # con riferimento esterno
-
delete: description                         # Eliminazione dell'attributo description
-

#   LDIF per aggiunta di una nuova entry
dn: cn=Barbara Jensen,dc=example,dc=com     # Obbligatorio che ci sia un DN univoco per lo spazio di nomi
objectClass: person                             # Obbligatorio che ce ne sia almeno una
cn: Barbara Jensen
cn: Babs Jensen
sn: Jensen
title: the most famous mythical manager
mail: bjensen@example.com
uid: bjensen

#   LDIF per modifica entry
dn: cn=Barbara Jensen,dc=example,dc=com     # DistinguishName della entry da modificare
changetype: delete                              # Tipo di modifica da eseguire

# RIMOZIONE ENTRY ----------------------------------------------------------------------------------------------------------------------------------------------
# Per aggiungere una entry nella directory uso il comando:
(sudo) ldapdelete -x -D "cn=admin,dc=labammsis" -w admin DN
#   -x ----> permette un autenticazione con metodo standard
#   -D "cn=admin,dc=labammsis" -w admin ----> autenticazione con username e password
#   DN ----> DistinguishName della entry da eliminare
#   E' fondamentale ricordare che Per eliminare una entry, questa deve essere una leaf, ovvero non avere entry figlie. Per ovviare al problema,
#   si pu`o utilizzare il comando ldapdelete con opzione -r che permette di eliminare ricorsivamente
#   anche i figli.

# ESEMPIO COMPLETO DI FILE LDIF --------------------------------------------------------------------------------------------------------------------------------
#Nella definizione dello schema non utilizzare TAB per indentare il codice ma esclusivamente
#   degli spazi, ldap ha dei seri problemi mentali e se non fai cos`ı inizia a lanciare errori a caso. Scusate
#   lo sfogo, ci ho perso un ora.

dn: cn=filesystem,cn=schema,cn=config
objectClass: olcSchemaConfig
cn: filesystem
olcAttributeTypes: ( 1000.1.1.1 NAME ( 'fn' 'filename' )
 DESC 'nome del file'
 EQUALITY caseExactMatch
 SUBSTR caseExactSubstringsMatch
 SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcAttributeTypes: ( 1000.1.1.2 NAME ( 'fs' 'filesize' )
 DESC 'dimensioni del file'
 EQUALITY integerMatch
 ORDERING integerOrderingMatch
 SYNTAX 1.3.6.1.4.1.1466.115.121.1.27 )
olcObjectClasses: ( 1000.2.1.1 NAME 'dir'
 DESC 'una directory'
 MUST fn
 MAY fs
 AUXILIARY )
olcObjectClasses: ( 1000.2.1.2 NAME 'file'
 DESC 'un file'
 MUST ( fn $ fs )
 AUXILIARY )

# FUNZIONI UTILI ----------------------------------------------------------------------------------------------------------------------------------------------
# Legge uno specifico attributo di una entry ldap
#   ARGOMENTI : $1 Distinguished Name , $2 Nome attributo
#   RETURN : 0 se l' attributo è stato trovato , 1 altrimenti
function readLdapAttr () 
{
    RES = $(ldapsearch -x -b "$1" -s base | egrep "^$2" | awk -F ":" '{ print $2 }')
    if test -z "$RES"
    then
        return 1
    else
        echo "$RES"
        return 0
    fi
}
#   Esempio d’uso:
ATTRVAL = $(readldapattr "ind=10.9.9.1,ind=10.1.1.1,dc=labammsis" "cnt" )
echo "RETURN VALUE: $?"
echo "ATTR VALUE: $ATTRVAL"

# Modifica uno specifico attributo di una entry ldap
#   ARG: $1 Distinguished Name , $2 Nome attributo , $3 Nuovo valore
#   RETURN: 0 se l' attributo è stato modificato , 1 altrimenti
function editLdapAttr () 
{
    echo -e " dn : $1\nchangetype: modify\nreplace: $2\n$2: $3" | ldapmodify -x -D "cn=admin,dc=labammsis" -w admin
    return $?
}
#   Esempio d’uso:
editldapattr "ind=10.9.9.1,ind=10.1.1.1,dc=labammsis" "cnt" "2"
echo "RETURN VALUE: $?"