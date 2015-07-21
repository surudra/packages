package acmeSupport.codeExample.codeSvc;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2008-11-23 09:11:16 EST
// -----( ON-HOST: TrainHost.webmethods.com

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class utils

{
	// ---( internal utility methods )---

	final static utils _instance = new utils();

	static utils _newInstance() { return new utils(); }

	static utils _cast(Object o) { return (utils)o; }

	// ---( server methods )---




	public static final void endTiming (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(endTiming)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required startTime
		// [i] field:0:required sendTo {"Pipeline Only","System.out","debugLog"}
		// [i] field:0:optional msg
		// [i] field:0:optional divideBy
		// [i] field:0:optional debugLevel
		// [o] field:0:required resultTime
		// Grab the endTime before any other processing to get the most accurate timing.
		long			endTime = System.currentTimeMillis();
		
		IDataCursor		cursor = pipeline.getCursor();
		
		// Compute the result time (in ms)
		long			startTime = Long.parseLong( IDataUtil.getString( cursor, "startTime" ) );
		long			resultTime = endTime - startTime;
		
		// Divide by "divideBy" if appropriate
		int				divideBy = IDataUtil.getInt( cursor, "divideBy", -1 );
		if ( divideBy != -1 )
			resultTime /= divideBy;
		
		// Compose the output message
		String			msg = IDataUtil.getString( cursor, "msg" );
		StringBuffer	outputMsg = new StringBuffer( msg != null ? msg : "" );
		if ( msg != null )
			outputMsg.append( ": " );
		outputMsg.append( Long.toString(resultTime) );
		outputMsg.append( " ms" );
		msg = outputMsg.toString();
		
		// Always add the message to the pipeline
		IDataUtil.put( cursor, "resultTime", msg );
		
		// Output the message to System.out if appropriate
		String			sendTo = IDataUtil.getString( cursor, "sendTo" );
		//if ( "System.out".equalsIgnoreCase( sendTo ) )
		//	util.Log.log( msg , "sample.timing");
		
		// Output the message to debugLog if appropriate
		//if ( "debugLog".equalsIgnoreCase( sendTo ) )
		//{
			// This is an example of how to invoke a service from Java
			// by creating a new little pipeline (pipelet).
			String		debugLevel = IDataUtil.getString( cursor, "debugLevel" );
			Object[][]	debugLogInput = {
							{ "message", msg },
							{ "function", "TIMING" },
							{ "level", debugLevel }
						};
			IData		pipelet = IDataFactory.create( debugLogInput );
			try {
				Service.doInvoke( "pub.flow", "debugLog", pipelet );
			}
			catch ( Exception x )
			{
				throw new ServiceException( x );
			}
		//}
		
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void endTimingNanos (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(endTimingNanos)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required startTime
		// [i] field:0:required sendTo {"Pipeline Only","System.out","debugLog"}
		// [i] field:0:optional msg
		// [i] field:0:optional divideBy
		// [i] field:0:optional debugLevel
		// [o] field:0:required resultTime
		// Grab the endTime before any other processing to get the most accurate timing.
		long			endTime = System.nanoTime();
		
		IDataCursor		cursor = pipeline.getCursor();
		
		// Compute the result time (in nSec)
		long			startTime = Long.parseLong( IDataUtil.getString( cursor, "startTime" ) );
		long			resultTime = endTime - startTime;
		
		// Divide by "divideBy" if appropriate
		int				divideBy = IDataUtil.getInt( cursor, "divideBy", -1 );
		if ( divideBy != -1 )
			resultTime /= divideBy;
		
		// Compose the output message
		String			msg = IDataUtil.getString( cursor, "msg" );
		StringBuffer	outputMsg = new StringBuffer( msg != null ? msg : "" );
		if ( msg != null )
			outputMsg.append( ": " );
		outputMsg.append( Long.toString(resultTime) );
		outputMsg.append( " nSec" );
		msg = outputMsg.toString();
		
		// Always add the message to the pipeline
		IDataUtil.put( cursor, "resultTime", msg );
		
		// Output the message to System.out if appropriate
		String			sendTo = IDataUtil.getString( cursor, "sendTo" );
		//if ( "System.out".equalsIgnoreCase( sendTo ) )
		//	util.Log.log( msg , "sample.timing");
		
		// Output the message to debugLog if appropriate
		//if ( "debugLog".equalsIgnoreCase( sendTo ) )
		//{
			// This is an example of how to invoke a service from Java
			// by creating a new little pipeline (pipelet).
			String		debugLevel = IDataUtil.getString( cursor, "debugLevel" );
			Object[][]	debugLogInput = {
							{ "message", msg },
							{ "function", "TIMING" },
							{ "level", debugLevel }
						};
			IData		pipelet = IDataFactory.create( debugLogInput );
			try {
				Service.doInvoke( "pub.flow", "debugLog", pipelet );
			}
			catch ( Exception x )
			{
				throw new ServiceException( x );
			}
		//}
		
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void startTiming (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(startTiming)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [o] field:0:required startTime
		IDataCursor		cursor = pipeline.getCursor();
		
		IDataUtil.put( cursor, "startTime", Long.toString(System.currentTimeMillis()));
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void startTimingNanos (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(startTimingNanos)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [o] field:0:required startTime
		IDataCursor		cursor = pipeline.getCursor();
		
		IDataUtil.put( cursor, "startTime", Long.toString(System.nanoTime()));
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}
}

