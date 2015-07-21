package jsonSupport;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-02-24 14:24:23 CET
// -----( ON-HOST: sagbase.eur.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.util.Iterator;
import org.json.*;
// --- <<IS-END-IMPORTS>> ---

public final class pub

{
	// ---( internal utility methods )---

	final static pub _instance = new pub();

	static pub _newInstance() { return new pub(); }

	static pub _cast(Object o) { return (pub)o; }

	// ---( server methods )---




	public static final void documentToJSONString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(documentToJSONString)>> ---
		// @sigtype java 3.5
		// [i] record:0:required document
		// [i] record:1:required documentList
		// [o] field:0:required jsonString
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		JSONStringer s = new JSONStringer();
		
		// document
		IData	document = IDataUtil.getIData( pipelineCursor, "document" );
		if ( document != null) {
			serializeObject(document, s);
		}
		pipelineCursor.destroy();
		
		// documentList
		IData[]	documentList = IDataUtil.getIDataArray( pipelineCursor, "documentList" );
		if ( documentList != null) {
			serializeObject(documentList, s);
		}
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "jsonString", s.toString() );
		pipelineCursor_1.destroy();
			
		// --- <<IS-END>> ---

                
	}



	public static final void jsonStringToDocument (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(jsonStringToDocument)>> ---
		// @sigtype java 3.5
		// [i] field:0:required jsonString
		// [o] record:0:required document
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	jsonString = IDataUtil.getString( pipelineCursor, "jsonString" );
		JSONObject jo = null;
		try {
			jo = new JSONObject(jsonString);
		} catch (Exception e) {
			throw new ServiceException("jsonStringToDocument failed: "+e.getMessage());
		}
		pipelineCursor.destroy();
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IData	document = null;
		
		// document
		document = jsonObject2Document(jo);
		IDataUtil.put( pipelineCursor_1, "document", document );
		pipelineCursor_1.destroy();
			
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static void serializeObject(Object o, JSONStringer s) throws ServiceException {
		if (o instanceof IData) {
			IData document = (IData)o;
			IDataCursor documentCursor = document.getCursor();
	
			try {
				s.object();
				while (documentCursor.next()) {
					s.key(documentCursor.getKey());
					Object v = documentCursor.getValue();
					if (v instanceof IData || v instanceof Object[]) {
						serializeObject(v, s);
					} else {
						s.value(String.valueOf(v));
					}
				}
				s.endObject();
			} catch (Exception e) {
				throw new ServiceException("serializeObject failed: "+e.getMessage());
			}
			documentCursor.destroy();			
		}
		else if (o instanceof Object[]) {
			Object[] a = (Object[])o;
			try {
				s.array();
				for (int i = 0; i < a.length; i++) {
					if (a[i] instanceof IData || a[i] instanceof Object[]) {
						serializeObject(a[i], s);
					} else {
	//					s.key(string);
						s.value(String.valueOf(a[i]));
					}		
				}
				s.endArray();
			} catch (Exception e) {
				throw new ServiceException("serializeObject failed: "+e.getMessage());
			}
		}
	}	
	
	private static IData jsonObject2Document (JSONObject o) throws ServiceException {
		IData	document = IDataFactory.create();
		IDataCursor documentCursor = document.getCursor();
		Iterator i = o.keys();
		while (i.hasNext()) {
			try {
				String key = (String)i.next();
				Object value = o.get(key);
				if (value != null && (value instanceof JSONObject)) {
					IDataUtil.put(documentCursor, key, jsonObject2Document((JSONObject)value));
				}
				else if (value != null && (value instanceof JSONArray)) {
					JSONArray array = (JSONArray)value;
					if (array.length() > 0 && (array.get(0) instanceof JSONObject)) {
						IDataUtil.put(documentCursor, key, jsonArray2DocumentList(array));						
					} 
					else if (array.length() > 0) {
						String[] strArray = new String[array.length()];
						for (int j = 0; j < array.length(); j++) {
							strArray[j] = String.valueOf(array.get(j));
						}
						IDataUtil.put(documentCursor, key, strArray);						
					}
				}
				else {
					IDataUtil.put(documentCursor, key, value);
				}
			} catch (Exception e) {
				throw new ServiceException("jsonObject2Document failed: "+e.getMessage());
			}
		}
		documentCursor.destroy();
		return document;
	}
	
	private static IData[] jsonArray2DocumentList (JSONArray array) throws ServiceException {
		IData[]	documentList = new IData[array.length()];
		for (int i = 0; i < array.length(); i++) {
			try {
				JSONObject entry = (JSONObject)array.get(i);
				documentList[i] = jsonObject2Document(entry);
			} 
			catch (Exception e) {
				throw new ServiceException("jsonArray2DocumentList failed: "+e.getMessage());
			}
		}
		return documentList;
	}
	// --- <<IS-END-SHARED>> ---
}

