/*
 * WmSampleAdapterResourceBundle.java
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

import java.util.ListResourceBundle;

import com.wm.adk.ADKGLOBAL;
import com.wm.adapter.wmSampleAdapter.connection.*;

/*
 * This is the reource bundle for the Sample adapter
 */
public class WmSampleAdapterResourceBundle extends ListResourceBundle
  implements WmSampleAdapterConstants
{
    static final String IS_PKG_NAME = "/WmSampleAdapter2/";

    static final Object[][] _contents = {
        // adapter type display name.
        {ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Sample Adapter"}
        // adapter type descriptions.
        ,{ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION,
          "Adapter for Sample server (a Simulated Bank System)"}
        // adapter type vendor.
        ,{ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_VENDORNAME ,  "webMethods"}
        // copyright page url
        ,{ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_THIRDPARTYCOPYRIGHTURL,
          IS_PKG_NAME + "copyright.html" }
        // copyright page encoding
        ,{ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_COPYRIGHTENCODING,
          "UTF-8" }
        // release note url
        ,{ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_RELEASENOTEURL,
          IS_PKG_NAME + "ReleaseNotes.html" }
        //The online help link to the adapter's "help" information.
        ,{ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_HELPURL, 
          IS_PKG_NAME + "doc/OnlineHelp/WmSampleAdapterHelp.html"}

        //The online help link to the adapter's "about" information.
        ,{ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_ABOUT + ADKGLOBAL.RESOURCEBUNDLEKEY_HELPURL, 
          IS_PKG_NAME + "doc/OnlineHelp/WmSampleAdapterAboutHelp.html"}

        // online help link to the connection types supported. 
        ,{ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_LISTCONNECTIONTYPES + ADKGLOBAL.RESOURCEBUNDLEKEY_HELPURL, 
          IS_PKG_NAME + "doc/OnlineHelp/WmSampleAdapterConnectionTypeListHelp.html"}
        // online help link to adapter's list of connections (backend resource)
        ,{ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_LISTRESOURCES + ADKGLOBAL.RESOURCEBUNDLEKEY_HELPURL, 
          IS_PKG_NAME + "doc/OnlineHelp/WmSampleAdapterResourceListHelp.html"}

        // added at Phase 2 to support connector
        // the connection type display name.
        ,{CONNECTION_TYPE + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME,
          "Sample Server Connection"}
        // the connection type description.
        ,{CONNECTION_TYPE + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION,
          "connection for Sample server"}
        // connection type online help link. 
        ,{CONNECTION_TYPE + ADKGLOBAL.RESOURCEBUNDLEKEY_HELPURL,
          IS_PKG_NAME + "doc/OnlineHelp/WmSampleAdapterConnectionConfigurationHelp.html"}

        // added at Phase 2 to support connector
        // for connector properties,
        ,{GROUP_SAMPLE_CONNECTION + ADKGLOBAL.RESOURCEBUNDLEKEY_GROUP, "Sample Server Connection" }
        ,{GROUP_SAMPLE_CONNECTION + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Connection to a Sample server" }
        ,{SAMPLE_SERVER_HOST_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Sample Server Host Name" }
        ,{SAMPLE_SERVER_HOST_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Sample server host name" }
        ,{SAMPLE_SERVER_PORT_NUMBER + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Sample Server Port Number" }
        ,{SAMPLE_SERVER_PORT_NUMBER + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Sample server port number" }
        ,{SAMPLE_CONNECTOR_TIMEOUT + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Sample Connector Timeout" }
        ,{SAMPLE_CONNECTOR_TIMEOUT + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Sample connector timeout" }
        ,{SAMPLE_TRANSACTION_TYPE + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Local Transaction Control?" }
        ,{SAMPLE_TRANSACTION_TYPE + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Sample server transaction control" }


        // adapter logging message
         ,{"101", "Initializing Sample Connection"}
    
        // adapter exception messages
        // added at Phase 2 to support the connection
        ,{"1001", "Resource Connection Exception:"}
    };

    public Object[][] getContents() {
        return _contents;
    }
}