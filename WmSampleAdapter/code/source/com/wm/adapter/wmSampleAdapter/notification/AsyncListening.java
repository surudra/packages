/*
 * AsyncListening.java
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
// this class is added at Phase 5 to support listener feature
package com.wm.adapter.wmSampleAdapter.notification;

import com.sample.document.Document;
import com.sample.document.Field;

import com.wm.adapter.wmSampleAdapter.WmSampleAdapter;
import com.wm.adapter.wmSampleAdapter.WmSampleAdapterConstants;
import com.wm.adapter.wmSampleAdapter.util.DocumentHelper;

import com.wm.adk.cci.record.WmRecord;
import com.wm.adk.cci.record.WmRecordFactory;
import com.wm.adk.error.AdapterException;
import com.wm.adk.metadata.WmTemplateDescriptor;
import com.wm.adk.notification.AsyncNotificationResults;
import com.wm.adk.notification.NotificationEvent;
import com.wm.adk.notification.NotificationResults;
import com.wm.adk.notification.WmAsyncListenerNotification;

import com.wm.data.IData;
import com.wm.data.IDataFactory;

import java.util.Locale;
import javax.resource.ResourceException;

/*
 * This class is the implementation of the asynchronous listener notification template
 * for the WmSampleAdapter. It receive listener notification event of the types of either
 * check deposit or under balance wanring, and publishes the message.
 *
 * ????Note: The notification template provides callback methods to interact with the 
 * Integration Server when the state of a notification changes. But this simple
 * example of a notification does not make use of these callbacks. For more
 * information on the available callbacks, refer to the Javadoc of the
 * WmNotification class.
 */
public class AsyncListening extends WmAsyncListenerNotification
  implements WmSampleAdapterConstants
{
    // eventName property
    private String _eventName;

    // outputParameterNames property
    private String[] _outputParameterNames;

    // outputFieldNames property
    private String[] _outputFieldNames;

    // outputFieldTypes property
    private String[] _outputFieldTypes;

    /*
     * Set eventName property value
     *
     * eventName is Sample Server service event name
     */
    public void setEventName(String eventName) {
        _eventName = eventName;
    }

    /*
     * Get eventName property value
     *
     * return Sample Server service event name
     */
    public String getEventName() {
        return _eventName;
    }

    /*
     * Set outputParameterNames property value
     *
     * outputParameterName are Sample Server service invocation output parameter
     * names. These parameters reflect the fully qualified structure names
     */
    public void setOutputParameterNames(String[] outputParameterNames) {
        _outputParameterNames = outputParameterNames;
    }

    /*
     * Get outputParameterNames property value
     *
     * return Sample Server service invocation output parameter names.
     * These parameters reflect the fully qualified structure names
     */
    public String[] getOutputParameterNames() {
        return _outputParameterNames;
    }

    /*
     * Set outputFieldNames property value
     *
     * outputFieldNames are Sample Server service invocation output field
     * names. These names are used to build the output signature
     */
    public void setOutputFieldNames(String[] outputFieldNames) {
        _outputFieldNames = outputFieldNames;
    }

    /*
     * Get outputFieldNames property value
     *
     * return Sample Server service invocation output field names.
     * These names are used to build the output signature
     */
    public String[] getOutputFieldNames() {
        return _outputFieldNames;
    }

    /*
     * Set outputFieldTypes property value
     *
     * outputFieldTypes are Sample Server service invocation output
     * field types. These types are used to build the output signature
     */
    public void setOutputFieldTypes(String[] outputFieldTypes) {
        _outputFieldTypes = outputFieldTypes;
    }

    /*
     * Get outputFieldTypes property value
     *
     * return Sample Server service invocation output field types.
     * These types are used to build the output signature
     */
    public String[] getOutputFieldTypes() {
        return _outputFieldTypes;
    }

    /*
     * This method populates the metadata object describing this listening
     * notification template in the specified locale.
     * This method will be called once for each listening notification template.
     *
     * d is the metadata object describing this adapter service.
     * l is the Locale in which the locale-specific metadata should be populated.
     * AdapterException is thrown if an error is encountered while populating the
     * metadata.
     */
    public void fillWmTemplateDescriptor(WmTemplateDescriptor d, Locale l)
      throws AdapterException {

        // create a group, essentially a tab in Developer
        d.createGroup(GROUP_ASYNC_LISTENING,
          new String[] {GROUP_MEMBER_EVENT_NAME,
                        GROUP_MEMBER_OUTPUT_PARAMETER_NAMES,
                        GROUP_MEMBER_OUTPUT_FIELD_NAMES,
                        GROUP_MEMBER_OUTPUT_FIELD_TYPES});

        // eventName property is required and must be set
        d.setRequired(GROUP_MEMBER_EVENT_NAME);

        // list output parameters, field name and data types in table format
        d.createFieldMap(new String[] {GROUP_MEMBER_OUTPUT_PARAMETER_NAMES, 
                                       GROUP_MEMBER_OUTPUT_FIELD_NAMES,
                                       GROUP_MEMBER_OUTPUT_FIELD_TYPES}, false);

        // tie output parameter and data types together for resource domain lookup
        d.createTuple(new String[] {GROUP_MEMBER_OUTPUT_PARAMETER_NAMES, 
                                    GROUP_MEMBER_OUTPUT_FIELD_TYPES});
                                    
        // set resource domain for the eventName property
        d.setResourceDomain(GROUP_MEMBER_EVENT_NAME, 
                            DOMAIN_NOTIFICATION_NAMES, null);


        // set resource domain for the outputParameterNames property
        // the resource domain look up has a dependency on the eventName
        // property value
        d.setResourceDomain(GROUP_MEMBER_OUTPUT_PARAMETER_NAMES,
                            DOMAIN_OUTPUT_PARAMETER_NAMES,
                            new String[] {GROUP_MEMBER_EVENT_NAME});

        // set resource domain for the outputFieldTypes property
        // the resource domain look up has a dependency on the eventName
        // property value
        d.setResourceDomain(GROUP_MEMBER_OUTPUT_FIELD_TYPES,
                            DOMAIN_OUTPUT_FIELD_TYPES,
                            new String[] {GROUP_MEMBER_EVENT_NAME});

        // set resource domain for the outputFieldNames property
        // outputFieldNames and outputFieldTypes are used to build the output
        // signature
        // outputParameterNames is used as suggested names for outputFieldNames
        d.setResourceDomain(GROUP_MEMBER_OUTPUT_FIELD_NAMES, 
                            WmTemplateDescriptor.OUTPUT_FIELD_NAMES,
                            new String[] {GROUP_MEMBER_OUTPUT_PARAMETER_NAMES, 
                                          GROUP_MEMBER_OUTPUT_FIELD_TYPES});
                                          
        // Retrieves the i18n metadata information from the resource bundle and
        // replaces he non-localized metadata.
        // The metadata that needs to be internationalized (the parameter display
        // name, description, group name, etc.) will populate the administrative
        // interface, Adapter Service Editor, or Adapter Notification Editor.
        d.setDescriptions(
          WmSampleAdapter.getInstance().getAdapterResourceBundleManager(), l);
    }

    /**
     * Check whether this notification is able to handle the listener event
     *
     * o is the listener event
     * return ture if able to hanndle it, otherwise a false
     */
    public boolean supports(Object o) {
        if (o instanceof Document) {
            Document doc = (Document)o;
            
            // if document type is not notification output
            if (doc.getDocumentType() != Document.NOTIFICATION_OUTPUT) {
                return false;
            }
            // else if the event type does not match
            else if (!_eventName.equals(doc.getFieldValue(Document.NOTIFICATION_NAME))) {
                return false;
            }
            else {
                return true;
            }
        }
        else {
            return false;
        }
    }
    
    /*
     * Process the notification event and publishes them.
     *
     * an AdapterException is thrown if it encounters any problem
     * return an AsyncNotificationResults
     */
    public NotificationResults runNotification(NotificationEvent event)
      throws ResourceException {

        AsyncNotificationResults asnr = null;
        WmRecord output = null;

        try {
            Document eventDoc = (Document)event.getData();
            output = 
              WmRecordFactory.getFactory().createWmRecord("NotificationOutput");

            IData outputRecord = IDataFactory.create();
            DocumentHelper.moveDocument2IData(eventDoc, outputRecord); 
            output.setIData(outputRecord);
        } catch (Exception e) {
            throw WmSampleAdapter.getInstance().createAdapterException(1007, e);
        }

        try {
            doNotify(output);
            asnr = new AsyncNotificationResults(this.nodeName(), true, null);
        } catch (Throwable t) {
            asnr = new AsyncNotificationResults(this.nodeName(), false, t);
            asnr.setHadError(true);
        }

        return asnr;
    }
}