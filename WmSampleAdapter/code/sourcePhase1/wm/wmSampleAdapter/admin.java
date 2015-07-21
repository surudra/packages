/*
 * admin.java
 *
 * Copyright 2004 webMethods, Inc.
 * ALL RIGHTS RESERVED
 *
 * UNPUBLISHED -- Rights reserved under the copyright laws of the United States.
 * Use of a copyright notice is precautionary only and does not imply
 * publication or disclosure.
 *
 * THIS SOURCE CODE IS THE CONFIDENTIAL AND PROPRIETARY INFORMATION OF
 * WEBMETHODS, INC.  ANY REPRODUCTION, MODIFICATION, DISTRIBUTION,
 * OR DISCLOSURE IN ANY FORM, IN WHOLE, OR IN PART, IS STRICTLY PROHIBITED
 * WITHOUT THE PRIOR EXPRESS WRITTEN PERMISSION OF WEBMETHODS, INC.
 */
package wm.wmSampleAdapter;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2003-05-15 08:56:02 EDT

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.adk.admin.AdapterAdmin;
import com.wm.adapter.wmSampleAdapter.WmSampleAdapter;
// --- <<IS-END-IMPORTS>> ---

public final class admin

{
    // ---( internal utility methods )---

    final static admin _instance = new admin();

    static admin _newInstance() { return new admin(); }

    static admin _cast(Object o) { return (admin)o; }

    // ---( server methods )---

    public static final void shutDown (IData pipeline)
        throws ServiceException
    {
        // --- <<IS-START(shutDown)>> ---
        // @subtype unknown
        // @sigtype java 3.5
        WmSampleAdapter instance = WmSampleAdapter.getInstance();
        instance.cleanup();
        AdapterAdmin.unregisterAdapter(instance);
        // --- <<IS-END>> ---                
    }

    public static final void startUp (IData pipeline)
        throws ServiceException
    {
        // --- <<IS-START(startUp)>> ---
        // @subtype unknown
        // @sigtype java 3.5
        AdapterAdmin.registerAdapter(WmSampleAdapter.getInstance());
        // --- <<IS-END>> ---         
    }
}