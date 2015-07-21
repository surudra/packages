/*
 * WmSamploeAdapter.java
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
package com.wm.adapter.wmSampleAdapter;

import java.util.Locale;

import com.wm.adk.WmAdapter;
import com.wm.adk.error.AdapterException;
import com.wm.adk.info.AdapterTypeInfo;
import com.wm.adk.log.ARTLogger;

// add the connection factory in Phase 2
import com.wm.adapter.wmSampleAdapter.connection.WmSampleConnectionFactory;

/*
 * Sample Adapter main class
 */
public class WmSampleAdapter extends WmAdapter implements WmSampleAdapterConstants
{
    // to make sure the adapter would not be registerd multiple times with
    // the IS, it needs to be made a singleton
    // see the implementation details of the getInstance() method.
    private static WmSampleAdapter _instance = null;

    private ARTLogger _logger;

    /*
     * Default constructor
     */
    public WmSampleAdapter() throws AdapterException {
        super();
    }

    /*
     * Cleans up any adapter-specific resources during termination.
     * This method is invoked when the adapter is reloaded or disabled. 
     * This method closes the ARTLogger object, which causes the dynamically inserted 
     * Major Code to be removed from the Integration Server Journal Log Consumer. 
     * If we do not close the ARTLogger object, the next time the adapter is reloaded
     * or enabled, another logger instance would be created by the initialize() method
     * and inserted into the Integration Server. It will then causes an error due to
     * a duplicated Major Code (facility code).
     */
    public void cleanup()
    {
        if (_logger != null)
            _logger.close();
    } 

    /*
     * Retrieve the logger
     */
    public ARTLogger retrieveLogger()
    {
        return _logger;
    }

    /*
     * Get the version of the J2EE JCA specification this adapter implements.
     */
    public String getAdapterJCASpecVersion() {
        return ADAPTER_JCA_VERSION;
    }

   /*
    * Get the Major Code (facility code), which is an integer code 
    * that the adapter will use to perform journal logging.
    * The Major Code must be unique across all adapters installed 
    * on the Integration Server.
    */
    public int getAdapterMajorCode() {
        return ADAPTER_MAJOR_CODE;
    }

    /*
     * Get the non Locale-specific name for this adapter.
     */
    public String getAdapterName() {
        return ADAPTER_NAME;
    }

    /*
     * Get the version of the adapter.
     */
    public String getAdapterVersion() {
        return ADAPTER_VERSION;
    }

    /*
     * Get the base Java class name for the adapter's resource bundle.
     */
    public String getAdapterResourceBundleName() {
        return ADAPTER_SOURCE_BUNDLE_NAME;
    }

    /*
     * Initializes properties/resources associated with this adapter type.
     * We instantiate the ARTLogger class, which will dynamically 
     * insert the Major Code into the Integration Server Journal Consumer Listener.
     * The given resource bundle name tells the Journal logger where to find the
     * Journal entry text. 
     * The logger:
     * -- Ensures that there is only one ARTLogger object in the Integration Server 
     * Journal Consumer Listener, and that the ARTLogger object closes when the
     * adapter is disabled. 
     * -- Displays the debug message or any further information. 
     * For example, in WmSampleConnection, we have a log for initializeConnection().
     * The log entry indicates whether a connection is being established.
     */
    public void initialize() throws AdapterException {
        _logger = new ARTLogger(getAdapterMajorCode(), 
                                getAdapterName(), 
                                getAdapterResourceBundleName());
    }

    /*
     * Fills the AdapterTypeInfo object with the adapter-specific data in the
     * specified locale.
     *
     * info is the AdapterTypeInfo object
     * locale is the Local Object
     */
    public void fillAdapterTypeInfo (AdapterTypeInfo info, Locale locale) {
        /* add your connection factories here */
        // add at Phase 2 to support connector
        info.addConnectionFactory(WmSampleConnectionFactory.class.getName());

        /* add your listener types here */

        /* add your notification templates here */

        /* add your listener notification templates here */
    }

    /*
     * Get adapter instance. To make sure the adapter would not be registerd
     * multiple times with the IS, it needs to be made a singleton.
     */
    public static WmSampleAdapter getInstance() {
        synchronized(WmSampleAdapter.class) {
            if (_instance != null) {
                return _instance;
            }
            
            try {
                _instance = new WmSampleAdapter();
                return _instance;
            } catch (Throwable t) {
                t.printStackTrace();
                return null;
            }
        }
    }
}