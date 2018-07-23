package esame.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jabsorb.JSONSerializer;
import org.jabsorb.serializer.MarshallException;
import org.jabsorb.serializer.UnmarshallException;

public class JsonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private JSONSerializer serializer;

	public static final String OBJECT_TO_SERIALIZE = "objectToSerialize";
	public static final String SERIALIZED_OBJECT = "serializedObject";
	public static final String OBJECT_TO_PARSE = "objectToParse";
	public static final String PARSED_OBJECT = "parsedObject";
	public static final String PARSING_ERROR = "jsonParsingError";
	public static final String SERIALIZING_ERROR = "jsonSerializingError";

	@Override
	public void init() throws ServletException {
		super.init();

		serializer = new JSONSerializer();
		try {
			// inizializza i tipi serializzatori forniti di default
			serializer.registerDefaultSerializers();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// riceve un oggetto da serializzare come attributo di request e lo
		// restituisce come attributo di request
		Object objectToSerialize = request.getAttribute(OBJECT_TO_SERIALIZE);
		if (objectToSerialize != null) {
			try {
				String serializedObject = serializer.toJSON(objectToSerialize);
				request.setAttribute(SERIALIZED_OBJECT, serializedObject);
				request.setAttribute(SERIALIZING_ERROR, null);
			} catch (MarshallException e) {
				e.printStackTrace();
				request.setAttribute(SERIALIZED_OBJECT, "{\"message\":\"Server error\"}");
				request.setAttribute(SERIALIZING_ERROR, e);
			}
		}

		// riceve una stringa da parsare come attributo di request e restituisce
		// l'oggetto come attributo di request
		String objectToParse = (String) request.getAttribute(OBJECT_TO_PARSE);
		if (objectToParse != null) {
			try {
				Object parsedObject = serializer.fromJSON(objectToParse);
				request.setAttribute(PARSED_OBJECT, parsedObject);
				request.setAttribute(PARSING_ERROR, null);
			} catch (UnmarshallException e) {
				e.printStackTrace();
				request.setAttribute(PARSED_OBJECT, null);
				request.setAttribute(PARSING_ERROR, e);
			}
		}
	}
}
