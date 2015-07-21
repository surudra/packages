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
    static final String IS_PKG_NAME = "/WmSampleAdapter3/";

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
        // online help link to adapter's list of polling notification
        ,{ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_LISTPOLLINGNOTIFICATIONS + ADKGLOBAL.RESOURCEBUNDLEKEY_HELPURL, 
          IS_PKG_NAME + "doc/OnlineHelp/WmSampleAdapterPollingNotificationListHelp.html"}
        ,{ADAPTER_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_LISTPOLLINGNOTIFICATIONDETAILS + ADKGLOBAL.RESOURCEBUNDLEKEY_HELPURL, 
          IS_PKG_NAME + "doc/OnlineHelp/WmSampleAdapterPollingNotificationDetailsHelp.html"}

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

        // added at Phase 3 to support service template
        // for function invocation service template
        ,{SERVICE_TEMPLATE + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Function Invocation" }
        ,{SERVICE_TEMPLATE + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Invoke a function on Sample server" }
        ,{SERVICE_TEMPLATE + ADKGLOBAL.RESOURCEBUNDLEKEY_HELPURL,
          IS_PKG_NAME + "doc/OnlineHelp/WmSampleAdapterServiceTemplateHelp.html"}
        // for function invocation group
        ,{GROUP_FUNCTION_INVOCATION + ADKGLOBAL.RESOURCEBUNDLEKEY_GROUP, "Function Invocation" }
        ,{GROUP_FUNCTION_INVOCATION + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Invoke a function on Sample server" }

        // added at Phase 3 to support service template
        // property for function invocation service template
        ,{GROUP_MEMBER_FUNCTION_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Function Name" }
        ,{GROUP_MEMBER_FUNCTION_NAME + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Sample server function name" }

        // added at Phase 3 to support service template
        // properties for both function invocation service template and
        // message polling notification template        
        ,{GROUP_MEMBER_INPUT_PARAMETER_NAMES + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Input Parameter" }
        ,{GROUP_MEMBER_INPUT_PARAMETER_NAMES + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION,
          "Input for Sample server function invocation" }
        ,{GROUP_MEMBER_INPUT_FIELD_NAMES + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Input Field" }
        ,{GROUP_MEMBER_INPUT_FIELD_NAMES + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Input for Sample server function invocation" }
        ,{GROUP_MEMBER_INPUT_FIELD_TYPES + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Input Field Type" }
        ,{GROUP_MEMBER_INPUT_FIELD_TYPES + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Input type for Sample server function invocation" }
        ,{GROUP_MEMBER_OUTPUT_PARAMETER_NAMES + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Output Parameter" }
        ,{GROUP_MEMBER_OUTPUT_PARAMETER_NAMES + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Output for Sample server function invocation" }
        ,{GROUP_MEMBER_OUTPUT_FIELD_NAMES + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Output Field" }
        ,{GROUP_MEMBER_OUTPUT_FIELD_NAMES + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Output for Sample server function invocation" }
        ,{GROUP_MEMBER_OUTPUT_FIELD_TYPES + ADKGLOBAL.RESOURCEBUNDLEKEY_DISPLAYNAME, "Output Field Type" }
        ,{GROUP_MEMBER_OUTPUT_FIELD_TYPES + ADKGLOBAL.RESOURCEBUNDLEKEY_DESCRIPTION, "Output type for Sample server function invocation" }

        // adapter logging message
         ,{"101", "Initializing Sample Connection"}
    
        // adapter exception messages
        // added at Phase 2 to support the connection
        ,{"1001", "Resource Connection Exception:"}

        // added at Phase 3 to support function invocation service
        ,{"1002", "Register Resource Domain Exception:"}
        ,{"1003", "Invalid Input Parameters"}
        ,{"1004", "Function Invocation Exception: \"{0}\"."}
    };

    public Object[][] getContents() {
        return _contents;
    }
}