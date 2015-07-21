package acmeSupport;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2015-07-02 12:58:51 IST
// -----( ON-HOST: MCSURU01.eur.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
// --- <<IS-END-IMPORTS>> ---

public final class bookInformation

{
	// ---( internal utility methods )---

	final static bookInformation _instance = new bookInformation();

	static bookInformation _newInstance() { return new bookInformation(); }

	static bookInformation _cast(Object o) { return (bookInformation)o; }

	// ---( server methods )---




	public static final void deleteBook (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(deleteBook)>> ---
		// @sigtype java 3.5
		// [i] field:0:required $resourceID
		// [i] field:0:required $path
		IDataCursor inputCursor = pipeline.getCursor();
		String resourceID = IDataUtil.getString(inputCursor, "$resourceID");
		String path = IDataUtil.getString(inputCursor, "$path");
		inputCursor.destroy();
				
		synchronized(library) {
		
			String result = "";
			
			if (path != null) {
		
				result = errorMessage("The Path must not be specified during DELETE requests!");
		
			} else if (resourceID == null) {
				
				result = errorMessage("The resourceID must be specified during DELETE requests!");
				
			} else /* (resourceID != null) */ {
				
				// delete a specific book
				
				if (library.containsKey(resourceID)) {
					library.remove(resourceID);
					result = successMessage("The book with the id '" + resourceID + "' was deleted from the library!");
					
				} else {
					result = errorMessage("The book with the id '" + resourceID + "' is not in the library!");
				}				
			}
		
			// call set response to return our result
		
			setResponse(resourceID, path, result);
		}
		// --- <<IS-END>> ---

                
	}



	public static final void getBook (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getBook)>> ---
		// @sigtype java 3.5
		// [i] field:0:required $resourceID
		// [i] field:0:required $path
		IDataCursor inputCursor = pipeline.getCursor();
		String resourceID = IDataUtil.getString(inputCursor, "$resourceID");
		String path = IDataUtil.getString(inputCursor, "$path");
		inputCursor.destroy();
				
		synchronized(library) {
			
			String result = "";
			
			if (path != null) {
		
				result = errorMessage("The Path must not be specified during GET requests!");
		
			} else if (resourceID == null) {
				
				// return all books
				
				result = q("TR", q("TH", "SKU"), q("TH", "Book Information"));
			
				for (Entry<String, Map<String, String>> e : library.entrySet()) {
					result += q("TR", q("TD", e.getKey()), q("TD", bookToString(e.getValue())));
				}
				result = qa("TABLE", "border='1' cellpadding='5' cellspacing='5'", result);
				
			} else /* (resourceID != null) */ {
				
				// find a specific book
				
				Map<String,String> book = library.get(resourceID);
				if (book == null) {
					result = errorMessage("The book with the id '" + resourceID + "' is not in the library!");
				} else {
					result = bookToString(book);
				}
				
			}
			
			// call set response to return our result
			
			setResponse(resourceID, path, result);
		}
		// --- <<IS-END>> ---

                
	}



	public static final void postBook (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(postBook)>> ---
		// @sigtype java 3.5
		// [i] field:0:required $resourceID
		// [i] field:0:required $path
		IDataCursor inputCursor = pipeline.getCursor();
		String resourceID = IDataUtil.getString(inputCursor, "$resourceID");
		String path = IDataUtil.getString(inputCursor, "$path");
		inputCursor.destroy();
				
		synchronized(library) {
		
			String result = "";
			
			if (path != null) {
		
				result = errorMessage("The Path must not be specified during POST requests!");
		
			} else if (resourceID == null) {
				
				result = errorMessage("The resourceID must be specified during POST requests!");
				
			} else /* (resourceID != null) */ {
				
				// post a specific book
				
				if (library.containsKey(resourceID)) {
					result = errorMessage("The book with the id '" + resourceID + "' is already in the library!");
				} else {
		
					Map<String,String> book = new HashMap<String, String>();
					
					inputCursor = pipeline.getCursor();
		
					String[] keys = {
							"title", 
							"author", 
							"isbn-10", 
							"isbn-13", 
							"price", 
							"currency", 
							"comment"
					};
		
					for (String key : keys) {
						String value = IDataUtil.getString(inputCursor, key);
						if (value != null) {
							book.put(key, value);
						}
					}
		
					inputCursor.destroy();
					library.put(resourceID, book);
					
					result += 
						q("P",
								successMessage("The book with the SKU '" + resourceID + "' was added to the Library."),
								q("P", bookToString(book))
						);
				}
				
			}
			
			// call set response to return our result
		
			setResponse(resourceID, path, result);
		}
		// --- <<IS-END>> ---

                
	}



	public static final void putBook (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putBook)>> ---
		// @sigtype java 3.5
		// [i] field:0:required $resourceID
		// [i] field:0:required $path
		IDataCursor inputCursor = pipeline.getCursor();
		String resourceID = IDataUtil.getString(inputCursor, "$resourceID");
		String path = IDataUtil.getString(inputCursor, "$path");
		inputCursor.destroy();
				
		synchronized(library) {
		
			String result = "";
			
			if (path != null) {
		
				result = errorMessage("The Path must not be specified during PUT requests!");
		
			} else if (resourceID == null) {
				
				result = errorMessage("The resourceID must be specified during PUT requests!");
				
			} else /* (resourceID != null) */ {
				
				// post a specific book
				
				if (! library.containsKey(resourceID)) {
					result = errorMessage("The book with the id '" + resourceID + "' is not in the library!");
				} else {
		
					Map<String,String> book = library.get(resourceID);
					
					inputCursor = pipeline.getCursor();
		
					String[] keys = {
							"title", 
							"author", 
							"isbn-10", 
							"isbn-13", 
							"price", 
							"currency", 
							"comment"
					};
		
					for (String key : keys) {
						String value = IDataUtil.getString(inputCursor, key);
						if (value != null) {
							book.put(key, value);
						}
					}
		
					inputCursor.destroy();
					library.put(resourceID, book);
					
					result += 
						q("P",
								successMessage("The book with the SKU '" + resourceID + "' was updated in the Library."),
								q("P", bookToString(book))
						);
				}
				
			}
			
			// call set response to return our result
		
			setResponse(resourceID, path, result);
		}
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	
	private static String q(String tag, String... contents) {
		String result = "<" + tag + ">";
		for (String s : contents) {
			result += s;
		}
		return result + "</" + tag + ">";
	}
	
	private static String qa(String tag, String attributes, String... contents) {
		String result = "<" + tag + " " + attributes + ">";
		for (String s : contents) {
			result += s;
		}
		return result + "</" + tag + ">";
	}
	
	private static String errorMessage(String message) {
		return q("P", qa("FONT", "color=red", q("B", message)));	
	}
	
	private static String successMessage(String message) {
		return q("P", qa("FONT", "color=green", q("B", message)));	
	}
	
	private static String bookToString(Map<String, String> book) {
		String result = "";
		for (Entry<String, String> e : book.entrySet()) {
			result += q("TR", q("TD", e.getKey()), q("TD", e.getValue()));
		}
		return qa("TABLE", "border='1' cellpadding='5' cellspacing='5'", result);
	}
	
	private static String getHeading(String resourceID, String path) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = sdf.format(cal.getTime());
		
		return
			qa("TABLE", "border='1' cellpadding='5' cellspacing='5'",
				q("TR", q("TD", q("B", "Current Time")), q("TD", now)),
				q("TR", q("TD", q("B", "resourceID")), q("TD", resourceID)),
				q("TR", q("TD", q("B", "path")), q("TD", path))
			);	
	}
	
	private static void setResponse(String resourceID, String path, String result) throws ServiceException { 
		
		String response;
		
		response = 
			q("HTML", 
					q("HEAD", q("TITLE", "REST example result")),
					q("BODY", getHeading(resourceID, path), q("P"), result)
			);
	
		IData input = IDataFactory.create();
		IDataCursor cursor  = input.getCursor();
		
		IDataUtil.put(cursor, "string", response);
		IDataUtil.put(cursor, "encoding", "UTF-8");
		IDataUtil.put(cursor, "contentType", "text/html");
		
		try {
			Service.doInvoke("pub.flow", "setResponse", input);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
	
	private static Map<String, Map<String, String>> library = createLibrary();
	
	private static Map<String, Map<String, String>> createLibrary() {
	
		Map<String, Map<String, String>> lib = new HashMap<String, Map<String, String>>();
	
		Map<String,String> book = new HashMap<String, String>();		
		book.put("title", "Ulysses");
		book.put("author", "James Joyce");
		book.put("isbn-10", "0679722769");
		book.put("isbn-13", "9780679722762");
		book.put("price", "12.00"); 
		book.put("currency", "USD");
		book.put("comment", "Not to be sold to minors");
	
		lib.put("1", book);
		
		book = new HashMap<String, String>();
		book.put("title", "Game Theory");
		book.put("author", "Fudenberg and Tirole");
		book.put("isbn-10", "0262061414");
		book.put("isbn-13", "978-0262061414");
		book.put("price", "70.35");
		book.put("currency", "USD");
		book.put("comment", "Covers most of the central topics in noncooperative game theory");
	
		lib.put("2", book);
		
		book = new HashMap<String, String>();
		book.put("title", "The Shape of Inner Space: String Theory and the Geometry of the Universe's Hidden Dimensions");
		book.put("author", "Shing-Tung Yau");
		book.put("isbn-10", "0465020232");
		book.put("price", "7.49");
		book.put("currency", "USD");
		book.put("comment", "This book is the story of the 'Calabi-Yau manifolds'.");
	
		lib.put("3", book);
		
		book = new HashMap<String, String>();
		book.put("title", "Anorexie und Bulimie im Jugendalter. Mit Online-Materialien");
		book.put("author", "Harriet Salbach-Andrae, Corinna Jacobi, Charlotte Jaite");
		book.put("isbn-10", "3621276866");
		book.put("isbn-13", "978-3621276863");
		book.put("price", "49.95");
		book.put("currency", "EUR");
		book.put("comment", "Kognitiv-verhaltenstherapeutisches Behandlungsmanual. Psychoedukation und Erarbeitung eines individuellen St&ouml;rungsmodells zur Normalisierung des Essverhaltens");
	
		lib.put("4", book);
		
		book = new HashMap<String, String>();
		book.put("title", "Stahl's Essential Psychopharmacology");
		book.put("author", "Stephen M. Stahl");
		book.put("price", "113.70");
		book.put("currency", "USD");
		book.put("comment", "Neuroscientific Basis and Practical Applications");
	
		lib.put("5", book);
		
		book = new HashMap<String, String>();
		book.put("title", "A First Course in String Theory Second (2nd) Edition");
		book.put("author", "Barton Zwiebach");
		book.put("price", "120.17");
		book.put("currency", "USD");
	
		lib.put("6", book);
		
		book = new HashMap<String, String>();
		book.put("title", "Three-Dimensional Geometry and Topology");
		book.put("author", "William P. Thurston");
		book.put("price", "45.50");
		book.put("currency", "USD");
		book.put("isbn-10", "0691083045");
		book.put("isbn-13", "978-0691083049");
		book.put("comment", "Its content provides the methods needed to solve the Poincare Conjecture");
	
		lib.put("7", book);
		
		book = new HashMap<String, String>();
		book.put("title", "Vergessene Pfade um den K&ouml;nigssee: 32 au&szlig;ergew&ouml;hnliche Touren abseits des Trubels");
		book.put("author", "Joachim Burghardt");
		book.put("isbn-10", "3765450189");
		book.put("isbn-13", "978-3765450181");
		book.put("price", "19,95");
		book.put("currency", "EUR");
		book.put("comment", "Blick hinter die Kulissen des K&ouml;nigsseetourismus");
	
		lib.put("8", book);
		
		book = new HashMap<String, String>();
		book.put("title", "Elliptic Curves: Number Theory and Cryptography, Second Edition (Discrete Mathematics and Its Applications)");
		book.put("author", "Lawrence C. Washington");
		book.put("isbn-10", "1420071467");
		book.put("isbn-13", "978-1420071467");
		book.put("price", "61.72");
		book.put("currency", "USD");
		book.put("comment", "A very comprehensive guide on the theory of elliptic curves");
	
		lib.put("9", book);
		
		book = new HashMap<String, String>();
		book.put("title", "The Riemann Hypothesis: A Resource for the Afficionado and Virtuoso Alike");
		book.put("author", "Peter Borwein, Stephen Choi, Brendan Rooney, Andrea Weirathmueller");
		book.put("isbn-10", "1441924655");
		book.put("isbn-13", "978-1441924650");
		book.put("price", "71.97");
		book.put("currency", "USD");
		book.put("comment", "a collection of well-known papers related to the Riemann Hypothesis");
	
		lib.put("10", book);
		
		book = new HashMap<String, String>();
		book.put("title", "The Shape of Inner Space: String Theory and the Geometry of the Universe's Hidden Dimensions");
		book.put("author", "Shing-Tung Yau");
		book.put("isbn-10", "0465020232");
		book.put("price", "7.49");
		book.put("currency", "USD");
		book.put("comment", "This book is the story of the 'Calabi-Yau manifolds'.");
	
		lib.put("11", book);
		
		return lib;
	}
	
		
	// --- <<IS-END-SHARED>> ---
}

