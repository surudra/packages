package V82TrainingSOA.IS.REST;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2011-03-15 11:06:57 PDT
// -----( ON-HOST: sagbase

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class utilservices

{
	// ---( internal utility methods )---

	final static utilservices _instance = new utilservices();

	static utilservices _newInstance() { return new utilservices(); }

	static utilservices _cast(Object o) { return (utilservices)o; }

	// ---( server methods )---




	public static final void strcompare (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(strcompare)>> ---
		// @sigtype java 3.5
		// [i] field:0:required str1
		// [i] field:0:required str2
		// [o] field:0:required val
		IDataCursor myCursor = pipeline.getCursor();
		
		String str1 = IDataUtil.getString(myCursor, "str1");
		System.out.println("after get cursor");
		System.out.println("str1" + str1);
		
		
		if ( str1 == null ) {
			myCursor.destroy();
			// Print to standard output an error message and exit processing
			System.out.println("Input could not be found in pipeline!" + "str1");
			return;
		}
		
		String str2 = IDataUtil.getString(myCursor, "str2");
		System.out.println("str2" + str2);
		
		if ( str2 == null ) {
			myCursor.destroy();
			// Print to standard output an error message and exit processing
			System.out.println("Input could not be found in pipeline!" + "str2");
			return;
		}
		
		if (str1.equals(str2))
		{
			IDataUtil.put( myCursor, "val", "1");
			System.out.println("val2" + str2);
		}
		else
		{
			IDataUtil.put( myCursor, "val", "0");
		}
		myCursor.destroy();
			
			
		// --- <<IS-END>> ---

                
	}
}

