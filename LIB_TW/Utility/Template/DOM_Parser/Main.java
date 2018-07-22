package esame.xml;

import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;

public class Main {

	public static void main(String[] args) throws Exception {

		String xmlFilename;

		if (args.length != 1) {
			System.out.println("usage: " + Main.class.getSimpleName() + " xmlFilename");
		} else {
			try {
				xmlFilename = args[0];
				// Domanda 1: il parser come e' a conoscenza del DTD/XSD da
				// utilizzare per la validazione?
				// Domanda 2: come specificare se il parser deve validare
				// tramite DTD o XSD?
				// (http://xerces.apache.org/xerces2-j/features.html)

				String schemaFeature = "http://apache.org/xml/features/validation/schema";
				String ignorableWhitespace = "http://apache.org/xml/features/dom/include-ignorable-whitespace";


				// DOM
				// -----------------------------------------------------------------
				// 1) Costruire un DocumentBuilder che validi il documento XML
				DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
				dbf.setValidating(true);
				dbf.setNamespaceAware(true);

				// seguente istruzione per specificare che stiamo validando
				// tramite XML Schema (commentarla se si usa DTD)
				dbf.setFeature(schemaFeature, true);

				// seguente istruzione per specificare che gli "ignorable
				// whitespace" (tab, new line...)
				// tra un tag ed un altro devono essere scartati e non
				// considerati come text node
				dbf.setFeature(ignorableWhitespace, false);

				// 2) Attivare un gestore di non-conformita'
				DocumentBuilder db = dbf.newDocumentBuilder();
				db.setErrorHandler(new ErrorHandler());

				// 3) Parsificare il documento, ottenendo un DOM
				Document dom = db.parse(new File(xmlFilename));
				dom.getDocumentElement().normalize();

				// 4) utilizzare il documento DOM
				System.out.println("DOM Pellicole 16mm prestabili = " + DomFunctions.getPellicole16mm(dom));
				System.out.println("DOM Audiovisivi in bianco e nero = " + DomFunctions.getAudiovisiviBN(dom));

				// mostrare su standard output il documento DOM risultante
				// (non richiesto dal testo d'esame)
				DomFunctions.printDom(dom);
				System.out.println();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
