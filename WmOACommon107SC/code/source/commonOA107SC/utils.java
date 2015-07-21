package commonOA107SC;

// -----( B2B Java Code Template v1.2
// -----( CREATED: Thu Jan 02 12:28:00 EST 2003
// -----( ON-HOST: VLaxmi2.webmethods.com

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<B2B-START-IMPORTS>> ---
// --- <<B2B-END-IMPORTS>> ---

public final class utils
{
	// ---( internal utility methods )---

	final static utils _instance = new utils();

	static utils _newInstance() { return new utils(); }

	static utils _cast(Object o) { return (utils)o; }

	// ---( server methods )---




	public static final void dateTimeFormat (IData pipeline)
        throws ServiceException
	{
		// --- <<B2B-START(dateTimeFormat)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inDate
		// [i] field:0:required currentPattern
		// [i] field:0:optional locale
		// [o] object:0:required outDate
	 IDataCursor dataCursor=pipeline.getCursor();
			 dataCursor.first("inDate");
			 try { 
  
                    Object inObject = dataCursor.getValue();

					String inDate = null;
					String currentPattern = null;
					String locale = null;

                    if(inObject != null)
					{
							 inDate = (String)inObject;
							 if(inDate.equals("") || inDate == null) return;
							 if (dataCursor.first("currentPattern"))
                             {
							 	if(dataCursor.getValue() != null)
							 	{
							 	   currentPattern = (String)dataCursor.getValue();
                                   if(currentPattern.equals("") || currentPattern == null) return;
							 	}else return;
							  }else return;

							if (dataCursor.first("locale"))
  						     	locale = (String)dataCursor.getValue();

							 IData inIData = IDataFactory.create();
							 IDataCursor inCursor=inIData.getCursor();

							 inCursor.insertAfter("inString",inDate);
							 inCursor.insertAfter("currentPattern",currentPattern);
							 inCursor.insertAfter("newPattern","yyyy-MM-dd HH:mm:ss.S");
 						 	 inCursor.insertAfter("locale",locale);					

							 IData outIData = Service.doInvoke("pub.date","dateTimeFormat",inIData);
							 IDataCursor outCursor=outIData.getCursor();

						     outCursor.first("value");
						     String outDateValue= (String)outCursor.getValue();
						     dataCursor.insertAfter("outDate",java.sql.Timestamp.valueOf(outDateValue));

                     }else return;

  				} catch (Exception e){
					 throw new ServiceException(e);
 				}
		// --- <<B2B-END>> ---

                
	}
}

