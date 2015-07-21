package acme.PurchaseOrder;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2013-06-12 11:15:35 CEST
// -----( ON-HOST: sagbase.eur.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class work

{
	// ---( internal utility methods )---

	final static work _instance = new work();

	static work _newInstance() { return new work(); }

	static work _cast(Object o) { return (work)o; }

	// ---( server methods )---




	public static final void endsWith (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(endsWith)>> ---
		// @sigtype java 3.5
		// [i] field:0:required String
		// [i] field:0:required Suffix
		// [o] field:0:required value
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	String = IDataUtil.getString( pipelineCursor, "String" );
			String	Suffix = IDataUtil.getString( pipelineCursor, "Suffix" );
		pipelineCursor.destroy();
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "value", "value" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

