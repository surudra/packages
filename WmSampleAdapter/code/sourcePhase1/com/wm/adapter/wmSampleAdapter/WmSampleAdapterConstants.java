/*
 * WmSampleAdapterConstants.java
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

/*
 * This interface defines all the constants used within the WmSampleAdapter
 * packages
 */
public interface WmSampleAdapterConstants {

    static final int ADAPTER_MAJOR_CODE = 502;
    static final String ADAPTER_JCA_VERSION = "1.0";
    static final String ADAPTER_NAME = "WmSampleAdapter";
    static final String ADAPTER_VERSION = "6.1";

    // using next statement will create cyclic class loading dependency issue
    // therefore, the resource bundle class name is fully spelled out
    /*
    static final String ADAPTER_SOURCE_BUNDLE_NAME =
      WmSampleAdapterResourceBundle.class.getName();
    */
    static final String ADAPTER_SOURCE_BUNDLE_NAME =
      "com.wm.adapter.wmSampleAdapter.WmSampleAdapterResourceBundle";
}