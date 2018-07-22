//	___________
//	|   DOM   |
//  ¯¯¯¯¯¯¯¯¯¯¯
// DOM specifica diverse classi, tutte con metodi simili tra loro, ogniuno degli oggetti 
// istanziati a partire da queste classi sono inseriti in un contesto di un documento,
// che può essere recuperato con il metodo
//     X.getOwnerDocument();
// Gli oggetti chei implementano l'interfaccia "X" sono creati da una factory, 
//     D.createX();
// dove D è l'oggetto Documento, ad esempio:
createElement("A");
createAttribute("href"); //crea un attributo nuovo vuoto
createTextNode("Hello!");
// Document espone quindi i seguenti metodi:
getDocumentElement();
createAttribute(name);
createElement(tagName);
createTextNode(data);
getDocType();
getElementById(IdVal);
// Element (sono i TAG) espone invece i seguenti:
getTagName();
getAttributeNode(name);
setAttributeNode(attr);
removeAttribute(name);
getElementsByTagName(name);
hasAttribute(name);
// Node invece, che astrae sia attributi che tag, ha comportamenti differenziati 
// a seconda del tipo di oggetto
Node.getNodeName(); //  Se applicato ad Element equivale a getTagName()
                    //  Se applicato ad Attr restituisce il nome dell’attributo

Node.getNodeValue();//  Restituisce il contenuto di un text node, il valore di un attributo, ecc.
                    //  Se applicato ad Element restituisce null 

Node.getNodeType(); //  Restituisce un valore numerico costante (es. 1, 2, 3,..., 12) che corrisponde 
                    //  a ELEMENT_NODE, ATTRIBUTE_NODE, TEXT_NODE, …, NOTATION_NODE
// CharacterData definisce il contenuto alfanumerico di un TAG, può essere acceduto e manipolato con
// i seguenti metodi:
substringData(offset, count);
appendData(string);
insertData(offset, string);
deleteData(offset, count);
replaceData(offset, count, string); // equivale a delete + insert
// Per accedere invece agli attributi di un element vi sono i seguenti metodi:
getAttribute(name);
setAttribute(name, value); //crea un attributo con il valore indicat, se esiste gia sostituisce il valore
removeAttribute(name);
// L'interfaccia NodeList rappresenta liste ordinate di nodi, ad esempio:
Node.getChildNodes(); //  tutti i nodi figli di un nodo
Element.getElementsByTagName("name"); // tutti i discendenti di tipo "name" nell’ordine in cui appaiono nel documento
Element.getElementsByTagName("*");  // tutti gli elementi del documento
// L'interfaccia NamedNodeMap invece permette di accedere a insiemi non ordinati di nodi individuati per nome,
// come ad esempio tutti gli attributi di un nodo
Node.getAttribute();

//	__________________
//	|   PARSER DOM   |
//  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
// Creazione in successione di una DocumentBuilderFactory, DocumentBuilder, File e di un document
DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
documentBuilder builder = dbf.newDocumentBuilder();
File file = new File ("prova.xml");
Document doc = builder.parse(file);
// Creazione di una classe che implementi l'interfaccia ErrorHandler di SAX con metodi error, fatalError
// e warning, un istanza di questa classe viene passata al parser con il metodo
DocumentBuilder.setErrorHandler(ErrorHandler eh);
// La validazione ed i namespace vengono gestiti sia per SAXParserFactories che per 
// DocumentBuilderFactories con:
DocumentBuilderFactories.setValidating(boolean)
DocumentBuilderFactories.setNamespaceAware(boolean)
// Vanno importati i seguenti package:
import java.io.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;

