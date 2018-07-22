// Le interfacce di SAX possono essere divise in 3 categorie:
//  -   Interfacce Parser-to-Application (callback): consentono di definire funzioni di callback e di 
//      associarle agli eventi generati dal parser mentre questi processa un documento XML
//  -   Interfacce Application-to-Parser: consentono di gestire il parser
//  -   Interfacce Ausiliarie: facilitano la manipolazione delle informazioni fornite dal parser

//INTRERFACCE P2A
// Vengono implementate dall'applicazione per imporre un preciso comportamento a seguito del verificarsi di un
// evento sono quattro:
//  >   ContentHandler: metodi per elaborare gli eventi
//      generati dal parser
//          |- setDocumentLocator(Locator locator) //setta un oggetto che determina l'origine di un evento SAX 
//          |- startDocument()
//          |- endDocument()
//          |- startElement(String namespaceURI, String localname, String rawName, Attributes atts)
//          |- endElement(String namespaceURI, String localname, String rawName)
//          |- characters(char ch[], int start, int length) // notifica la presenza di character data
//          |_ ignorableWhitespace(char ch[], int start, int length) // notifica della presenza di whitespace ignorabili nell'element content

//  >   DTDHandler: metodi per ricevere notifiche su entità
//      esterne al documento e loro notazione dichiarata in DTD
//  >   ErrorHandler: metodi per gestire gli errori ed i
//      warning nell'elaborazione di un documento
//  >   EntityResolver: metodi per personalizzare
//      l'elaborazione di riferimenti ad entità esterne
// Se un'interfaccia non viene implementata il comportamento
// di default è ignorare l'evento.

//INTRERFACCE A2P
// Sono implementate dal parser
//  >   XMLReader:  Interfaccia che consente all'applicazione
//                  di invocare il parser e di registrare gli oggetti che
//                  implementano le interfacce di callback
//  >   XMLFilter:  Interfaccia che consente di porre in
//                  sequenza vari XMLReaders come una serie di filtri

//INTRERFACCE AUSILIARIE
//  >   Attributes:     Metodi per accedere ad una lista di attributi
//  >   Locator:        Metodi per individuare l'origine degli eventi nel
//                      parsing dei documenti (es. systemID, numeri di linea e di
//                      colonna, ecc.)

// USO DEl PARSER SAX
//  1 -- importiamo i package utili
import org.xml.sax.XMLReader;
import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.helpers.DefaultHandler;  // Implementazione di default di ContentHandler:
import javax.xml.parsers.*; // Classi JAXP usate per accedere al parser SAX:

//  2 -- Definiamo una classe che discende da DefaultHandler e ridefinisce solo i metodi di callback 
//       che sono rilevanti nella nostra applicazione.
public class SAXDBApp extends DefaultHandler
{
    // Flag per ricordare dove siamo:
    private boolean InFirst = false;
    private boolean InLast = false;
    // Attributi per i valori da visualizzare
    private String FirstName, LastName, IdNum;

    // 3 -- Implementiamo i metodi di callback che ci servono
    //      Start element registra l'inizio degli elementi first e last,
    //      ed il valore dell'attributo idnum dell'elemento person.
    public void startElement (String namespaceURI,
    String localName, String rawName, Attributes atts)
    {
        if (localName.equals("first"))
            InFirst = true;
        if (localName.equals("last"))
            InLast = true;
        if (localName.equals("person"))
            IdNum = atts.getValue("idnum");
    }

    // 4 -- Il metodo di callback characters intercetta il contenuto testuale
    //      Registriamo in modo opportuno il valore del testo a
    //      seconda che siamo dentro first o last
    public void characters (char ch[], int start,
    int length)
    {
        if (InFirst) 
            FirstName = new String(ch, start, length);
        if (InLast) 
            LastName = new String(ch, start, length);
    } 

    // 5 -- Quanto abbiamo trovato la fine dell’elemento person,
    //      scriviamo i dati, quando troviamo la fine dell’elemento
    //      first o dell’elemento last aggiorniamo i flag in modo
    //      opportuno.
    public void endElement(String namespaceURI, String
    localName, String qName)
    {
        if (localName.equals("person"))
            System.out.println(FirstName + " " + LastName + " (" + IdNum + ")" );
        //Aggiorna i flag di contesto
        if (localName.equals("first"))
            InFirst = false;
        if (localName.equals("last"))
            InLast = false;
    }

    // 6 -- definisco il MAIN
    public static void main (String args[]) throws Exception
    {
        // Usa SAXParserFactory per istanziare un XMLReader
        SAXParserFactory spf = SAXParserFactory.newInstance();
        try
        {
            SAXParser saxParser = spf.newSAXParser();
            XMLReader xmlReader = saxParser.getXMLReader();
            ContentHandler handler = new SAXDBApp();
            xmlReader.setContentHandler(handler);
            for (int i=0; i<args.length; i++)
                xmlReader.parse(args[i]);
        }
        catch (Exception e)
        {
            System.err.println(e.getMessage());
            System.exit(1);
        }
    }
}

//ESEMPIO di XML
// <?xml version="1.0" encoding="ISO-8859-1"?>
//     <db>
//     <person idnum="1234">
//         <last>Rossi</last><first>Mario</first>
//     </person>
//     <person idnum="5678">
//         <last>Bianchi</last><first>Elena</first>
//     </person>
//     <person idnum="9012">
//         <last>Verdi</last><first>Giuseppe</first>
//     </person>
//     <person idnum="3456">
//         <last>Rossi</last><first>Anna</first>
//     </person>
// </db>



