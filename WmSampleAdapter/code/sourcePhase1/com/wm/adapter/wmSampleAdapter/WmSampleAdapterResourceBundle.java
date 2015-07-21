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

/*
 * This is the reource bundle for the Sample adapter
 */
public class WmSampleAdapterResourceBundle extends ListResourceBundle
  implements WmSampleAdapterConstants
{
    static final String IS_PKG_NAME = "/WmSampleAdapter1/";

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

        /* add adapter logging message here */

        /* add adapter exception messages here */
    };

    public Object[][] getContents() {
        return _contents;
    }
}