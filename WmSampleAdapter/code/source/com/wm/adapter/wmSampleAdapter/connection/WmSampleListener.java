/*
 * WmSampleListener.java
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

// Note: this class is added at Phase 5 to support listener feature
package com.wm.adapter.wmSampleAdapter.connection;

import com.wm.adapter.wmSampleAdapter.WmSampleAdapter;
import com.wm.adapter.wmSampleAdapter.WmSampleAdapterConstants;

import com.wm.adk.error.AdapterConnectionException;
import com.wm.adk.error.AdapterException;
import com.wm.adk.metadata.ResourceDomainValues;
import com.wm.adk.metadata.WmAdapterAccess;
import com.wm.adk.metadata.WmDescriptor;
import com.wm.adk.notification.WmConnectedListener;

import java.io.IOException;
import java.util.Locale;
import javax.resource.ResourceException;

// the Sample server client and document packages
import com.sample.client.Connection;
import com.sample.document.Document;

/*
 * This class represents WmSampleAdapter's listener connection type to Sample Server.
 * This class contains the property of the time out while wait to receive any event
 * notification from Sample Server.
 */
public class WmSampleListener extends WmConnectedListener
  implements WmSampleAdapterConstants
{   
    /*
     * Default constructor
     */
    public WmSampleListener() {
        super();
    }

    /*
     * Start up and initialize the listener
     */
    public void listenerStartup() throws ResourceException {
        // notify Sample Server to switch client connection to listen mode
        ((WmSampleConnection)retrieveConnection()).setToListenerMode(true);
    }

    /*
     * Shut down the listener
     */
    public void listenerShutdown() {
        try {
            // notify Sample Server to switch client connection to interaction mode
            ((WmSampleConnection)retrieveConnection()).setToListenerMode(false);
        } catch (ResourceException re) {
            // it does not matter anymore, since it is shutting down
        }
    }


    /*
     * This method populates the metadata object describing this listener
     * in the specified locale.
     *
     * d is the metadata object describing this adapter service.
     * l is the Locale in which the locale-specific metadata should be populated.
     * AdapterException is thrown if an error is encountered while populating the
     * metadata.
     */
    public void fillWmDescriptor(WmDescriptor d, Locale l) throws AdapterException {

        // Retrieves the i18n metadata information from the resource bundle and
        // replaces he non-localized metadata.
        // The metadata that needs to be internationalized (the parameter display
        // name, description, group name, etc.) will populate the administrative
        // interface, Adapter Service Editor, or Adapter Notification Editor.
        d.setDescriptions(
          WmSampleAdapter.getInstance().getAdapterResourceBundleManager(), l);  
    }


    /*
     * Wait for notification document from Sample Server
     */
    public Object waitForData() throws ResourceException {
        Document output = null;
        output = ((WmSampleConnection)retrieveConnection()).receiveDocumentAllowTimeout();
        return output;
    }
}