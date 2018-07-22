package esame.xml;

import java.util.Vector;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class SaxContentHandler extends DefaultHandler {

	boolean inFirstName = false;
	String firstName = null;
	boolean inLastName = false;
	String lastName = null;
	boolean inTelephone = false;
	String Telephone = null;
	boolean mmFound = false;

	public void startElement(String namespaceURI, String localName, String rawName, Attributes atts) {
		/*
		 * System.out.println("ContentHandler.startElement namespaceURI=" +
		 * namespaceURI + " localName=" + localName + "rawName=" + rawName +
		 * " atts=" + atts);
		 */
		if (localName.equals("Information")) {
			peopleAmount++;
			firstName = null;
			lastName = null;
		} else if (localName.equals("First_name")) {
			inFirstName = true;
		} else if (localName.equals("Last_name")) {
			inLastName = true;
		} else if (localName.equals("Telephone")) {
			inTelephone = true;
		}
	}

	public void characters(char ch[], int start, int length) {
		/*
		 * System.out.println("ContentHandler.characters start=" + start +
		 * " length=" + length + " ch=" + new String(ch, start, length));
		 */
		if (inFirstName) {
			firstName = new String(ch, start, length);
		} else if (inLastName) {
			lastName = new String(ch, start, length);
		} else if (inTelephone) {
			Telephone = new String(ch, start, length);
		}
	}

	public void endElement(String namespaceURI, String localName, String qName) {
		/*
		 * System.out.println("ContentHandler.endElement namespaceURI=" +
		 * namespaceURI + " localName=" + localName + " qName=" + qName);
		 */
		if (localName.equals("First_name")) {
			inFirstName = false;
		} else if (localName.equals("Last_name")) {
			inLastName = false;
		} else if (localName.equals("Telephone")) {
			inTelephone = false;
			if (firstName.startsWith("Don")) {
				donTel.addElement(Telephone);
			}
		} else if (localName.equals("Information")) {
			if (!mmFound && firstName != null && lastName != null) {
				// controllo non necessario per documenti XML validi
				if (firstName.equals("Mickey") && lastName.equals("Mouse")) {
					mmFound = true;
				} else {
					peoplePreMM++;
				}
			}
		}
	}

	private int ignorableWhitespace = 0;

	@Override
	public void ignorableWhitespace(char[] ch, int start, int length) throws SAXException {
		ignorableWhitespace += length;
	}

	public int getIgnorableWhitespace() {
		return ignorableWhitespace;
	}

	private int peopleAmount = 0;

	public int getPeopleAmount() {
		return peopleAmount;
	}

	private int peoplePreMM = 0;

	public int getPeoplePreMM() {
		return peoplePreMM;
	}

	private Vector<String> donTel = new Vector<String>();

	public Vector<String> getDonTel() {
		return donTel;
	}

}
