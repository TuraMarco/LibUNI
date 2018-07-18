//	___________
//	|   DAO   |
//  ¯¯¯¯¯¯¯¯¯¯¯
//  Il attern DAO risolve molte problematiche tipiche dell'approccio a forza bruta nella progettazione della persisitenza,
//  tra cui:
//  -   L'accoppiamento tra la sorgente dati e le classi del modello è molto forte
//  -   Le classi del modello sono poco coese (responsabilità eterogenee)
//  -   Molto difficile iniziare a sviluppare senza preoccuparsi di tanti (troppi !) dettagli e senza un ambiente operativo complesso
//  Il pattern Data Access Object (DAO) affidare le responsabilità di interagire con il database ad opportune classi.
//  I componenti della logica di businnes non devono contenere codice che accede al DB, per questo motivo si crea una gerarchia di 
//  nuove classi preposte a questo.

//	___________________
//	|   OGGETTI DTO   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  I valori scambiati tra DB ed applicazione vengono racchiusi in oggetti specifici detti DTO caratterizzati da:
//  -   campi privati
//  -   accessor publici
//  -   metodi di utilità publici o privati in base all'esigenza
//  Le operazioni che coinvolgono tali oggetti sono raggruppate in interfaccia che definiscono i DAO disponibili:
//  -   metodi CRUD
//  -   altri metodi di supporto
//  L'implementazione di tali interfaccia permettono l'effettiva interazione con il DB, permettendo:
//  -   Attraverso diverse implementazioni di accedere a DB di diversi vendor in modo omogeneo
//  -   Semplicità nel migrare su DB differenti
//  -   Separare in modo ottimale le responsabilità tra le parti dell'applicazione
//  Per istanziare i suddetti oggetti DAO si fa uso di metodi factory associati a classi specifiche.

//	______________________
//	|   CLASSI FACTORY   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Si usa un unica classe factory astratta per fornire specifiche per le factory concrete, espone inoltre un metodo creazionale per istanziare 
//  factory concrete.
//  Si sviluppa una factory concreta per ogni tipo di DB supportato nell'applicazione, queste factory concrete permettono di:
//  -   ottenere oggetti DAO appropriati al tipo di DB corrispondente
//  -   gestire l'ottenimento delle connessioni, autenticazioni, ecc.

//	_____________
//	|   TO DO   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯
//  Per sfruttare il pattern DAO quindi dovremo implementare:
//  -   1 factory astratta (DAOFactory.java)
//  -   1 factory concreta per ogni DB supportato (DB2DAOFactory.java,...)
//  -   1 oggetto DTO per ogni tipo di entità che si vuole trattare 
//  -   1 interfaccia DAO per ogni oggetto DTO che si vuole trattare
//  -   1 implementazione dell'interfaccia DAO di un DTO per ciascun DB supportato
