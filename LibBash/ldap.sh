################
#     LDAP     #
################

# LDIF ------------------------------------------------------------------------------------------------------
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

