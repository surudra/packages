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

// added at Phase 2 to support connector
import com.wm.adapter.wmSampleAdapter.connection.WmSampleConnectionFactory;

// added at Phase 3 to support service template
import com.wm.adapter.wmSampleAdapter.service.FunctionInvocation;

// added at Phase 4 to support polling notification
import com.wm.adapter.wmSampleAdapter.notification.MessagePolling;

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
    
    // added at Phase 2 to support connector
    static final String CONNECTION_TYPE = WmSampleConnectionFactory.class.getName();
    
    // added at Phase 3 to support service template
    static final String SERVICE_TEMPLATE = FunctionInvocation.class.getName();

    // added at Phase 4 to support polling notification
    static final String POLLING_TEMPLATE = MessagePolling.class.getName();

    // for all the properties, make sure the value matches the get/set method
    // naming convention. you have to understand how a Java instrospection
    // build a property name using the names of the get and set methods

    // added at Phase 2 to support connector
    // connector properties
    static final String GROUP_SAMPLE_CONNECTION = "SampleServerConnection";
    static final String SAMPLE_SERVER_HOST_NAME = "sampleServerHostName";
    static final String SAMPLE_SERVER_PORT_NUMBER = "sampleServerPortNumber";
    static final String SAMPLE_CONNECTOR_TIMEOUT = "timeout";
    static final String SAMPLE_TRANSACTION_TYPE = "transactionType";

    // added at Phase 3 to support service template
    // group and properties for function invocation service template
    static final String GROUP_FUNCTION_INVOCATION = "FunctionInvocation";
    static final String GROUP_MEMBER_FUNCTION_NAME = "functionName";
    
    // added at Phase 3 to support service template
    // propertities for both the function invocation service
    // and the message pollication notification
    static final String GROUP_MEMBER_INPUT_PARAMETER_NAMES = "inputParameterNames";
    static final String GROUP_MEMBER_INPUT_FIELD_NAMES = "inputFieldNames";
    static final String GROUP_MEMBER_INPUT_FIELD_TYPES = "inputFieldTypes";
    static final String GROUP_MEMBER_OUTPUT_PARAMETER_NAMES = "outputParameterNames";
    static final String GROUP_MEMBER_OUTPUT_FIELD_NAMES = "outputFieldNames";
    static final String GROUP_MEMBER_OUTPUT_FIELD_TYPES = "outputFieldTypes";

    // added at Phase 4 to support polling notification
    // group and properties for message polling notification template
    static final String GROUP_MESSAGE_POLLING = "MessagePolling";
    static final String GROUP_MEMBER_POLLING_NAME = "pollingName";
    static final String GROUP_MEMBER_INPUT_FIELD_VALUES = "inputFieldValues";

    // added at Phase 3 to support service template
    // resource domain, names for function invocation service configuration
    static final String DOMAIN_FUNCTION_NAMES = "functionNames";

    // added at Phase 3 to support service template
    // resource domain, names for both the function invocation service
    // and the message pollication notification configuration
    static final String DOMAIN_INPUT_PARAMETER_NAMES = "inputParameterNames";
    static final String DOMAIN_INPUT_FIELD_NAMES = "inputFieldNames";
    static final String DOMAIN_INPUT_FIELD_TYPES = "inputFieldTypes";
    static final String DOMAIN_OUTPUT_PARAMETER_NAMES = "outputParameterNames";
    static final String DOMAIN_OUTPUT_FIELD_NAMES = "outputFieldNames";
    static final String DOMAIN_OUTPUT_FIELD_TYPES = "outputFieldTypes";
    
    // added at Phase 4 to support polling notification
    // resource domain, names for message polling notification configuration
    static final String DOMAIN_POLLING_NAMES = "pollingNames";
}