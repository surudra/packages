/*
 * MessagePolling.java
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
package com.wm.adapter.wmSampleAdapter.notification;

import com.sample.document.Document;
import com.sample.document.Field;

import com.wm.adk.cci.record.WmRecord;
import com.wm.adk.cci.record.WmRecordFactory;
import com.wm.adk.error.AdapterException;
import com.wm.adk.metadata.WmTemplateDescriptor;
import com.wm.adk.notification.WmPollingNotification;

import com.wm.adapter.wmSampleAdapter.WmSampleAdapter;
import com.wm.adapter.wmSampleAdapter.WmSampleAdapterConstants;
import com.wm.adapter.wmSampleAdapter.connection.WmSampleConnection;
import com.wm.adapter.wmSampleAdapter.util.DocumentHelper;

import com.wm.data.IData;
import com.wm.data.IDataFactory;

import java.io.IOException;
import java.util.Locale;
import javax.resource.ResourceException;

/*
 * This class is the implementation of the polling notification template
 * for the WmSampleAdapter. It polls the Sample server for status changes of check
 * deposit or under balance wanring, and publishes any updated record it finds.
 *
 * Note: The notification template provides callback methods to interact with the 
 * Integration Server when the state of a notification changes. But this simple
 * example of a notification does not make use of these callbacks. For more
 * information on the available callbacks, refer to the Javadoc of the
 * WmNotification class.
 */
public class MessagePolling extends WmPollingNotification
  implements WmSampleAdapterConstants
{
    // pollingName property
    private String _pollingName;

    // inputParameterNames property
    private String[] _inputParameterNames;

    // inputFieldValues property
    private String[] _inputFieldValues;

    // inputFieldTypes property
    private String[] _inputFieldTypes;

    // outputParameterNames property
    private String[] _outputParameterNames;

    // outputFieldNames property
    private String[] _outputFieldNames;

    // outputFieldTypes property
    private String[] _outputFieldTypes;

    /*
     * Default Constructor
     */
    public MessagePolling() {
    }
    
    /*
     * Set pollingName property value.
     *
     * pollingName is pollingName property value
     */
    public void setPollingName(String pollingName) {
        _pollingName = pollingName;
    }

    /*
     * Get pollingName property value.
     *
     * return pollingName property value
     */
    public String getPollingName() {
        return _pollingName;
    }

    /**
     * Set inputParameterNames property value.
     *
     * inputParameterNames is inputParameterNames property value.
     * These parameters reflect the fully qualified structure names.
     */
    public void setInputParameterNames(String[] inputParameterNames) {
        _inputParameterNames = inputParameterNames;
    }

    /*
     * Get inputParameterNames property value.
     *
     * return inputParameterNames property value
     * These parameters reflect the fully qualified structure names
     */
    public String[] getInputParameterNames() {
        return _inputParameterNames;
    }

    /*
     * Set inputFieldValues property value
     *
     * inputFieldValues is inputFieldValues property value.
     * These values are used for run time polling criteria
     */
    public void setInputFieldValues(String[] inputFieldValues) {
        _inputFieldValues = inputFieldValues;
    }

    /*
     * Get inputFieldValues property value
     *
     * return inputFieldValues property value.
     * These values are used for run time polling criteria
     */
    public String[] getInputFieldValues() {
        return _inputFieldValues;
    }

    /*
     * Set inputFieldTypes property value
     *
     * inputFieldTypes is inputFieldTypes property value
     */
    public void setInputFieldTypes(String[] inputFieldTypes) {
        _inputFieldTypes = inputFieldTypes;
    }

    /*
     * Get inputFieldTypes property value
     *
     * return inputFieldTypes property value
     */
    public String[] getInputFieldTypes() {
        return _inputFieldTypes;
    }

    /**
     * Set outputParameterNames property value
     *
     * outputParameterNames is outputParameterNames property value
     */
    public void setOutputParameterNames(String[] outputParameterNames) {
        _outputParameterNames = outputParameterNames;
    }

    /*
     * Get outputParameterNames property value
     *
     * return outputParameterNames property value
     */
    public String[] getOutputParameterNames() {
        return _outputParameterNames;
    }

    /*
     * Set outputFieldNames property value
     *
     * outputFieldNames is outputFieldNames property value
     */
    public void setOutputFieldNames(String[] outputFieldNames) {
        _outputFieldNames = outputFieldNames;
    }

    /**
     * Get outputFieldNames property value
     *
     * return outputFieldNames property value
     */
    public String[] getOutputFieldNames() {
        return _outputFieldNames;
    }

    /*
     * Set outputFieldTypes property value
     *
     * outputFieldTypes is outputFieldTypes property value
     */
    public void setOutputFieldTypes(String[] outputFieldTypes) {
        _outputFieldTypes = outputFieldTypes;
    }

    /*
     * Get outputFieldTypes property value
     *
     * return outputFieldTypes property value
     */
    public String[] getOutputFieldTypes() {
        return _outputFieldTypes;
    }

    /*
     * This method populates the metadata object describing this polling
     * notification template in the specified locale.
     * This method will be called once for each polling notification template.
     *
     * d is the metadata object describing this adapter service.
     * l is the Locale in which the locale-specific metadata should be populated.
     * AdapterException is thrown if an error is encountered while
     * populating the metadata.
     */
    public void fillWmTemplateDescriptor(WmTemplateDescriptor d, Locale l)
      throws AdapterException {

        // create a group, essentially a tab in Developer
        d.createGroup(GROUP_MESSAGE_POLLING,
          new String[] {GROUP_MEMBER_POLLING_NAME,
                        GROUP_MEMBER_INPUT_PARAMETER_NAMES, 
                        GROUP_MEMBER_INPUT_FIELD_VALUES,
                        GROUP_MEMBER_INPUT_FIELD_TYPES,
                        GROUP_MEMBER_OUTPUT_PARAMETER_NAMES,
                        GROUP_MEMBER_OUTPUT_FIELD_NAMES,
                        GROUP_MEMBER_OUTPUT_FIELD_TYPES});

        // pollingName property is required and must be set
        d.setRequired(GROUP_MEMBER_POLLING_NAME);

        // list input parameters, field value and data types in table format
        d.createFieldMap(new String[] {GROUP_MEMBER_INPUT_PARAMETER_NAMES, 
                                       GROUP_MEMBER_INPUT_FIELD_VALUES, 
                                       GROUP_MEMBER_INPUT_FIELD_TYPES}, false);

        // list output parameters, field name and data types in table format
        d.createFieldMap(new String[] {GROUP_MEMBER_OUTPUT_PARAMETER_NAMES, 
                                       GROUP_MEMBER_OUTPUT_FIELD_NAMES,
                                       GROUP_MEMBER_OUTPUT_FIELD_TYPES}, false);
                                       
        // tie input parameter and data types together for resource domain lookup
        d.createTuple(new String[] {GROUP_MEMBER_INPUT_PARAMETER_NAMES, 
                                    GROUP_MEMBER_INPUT_FIELD_TYPES});

        // tie output parameter and data types together for resource domain lookup
        d.createTuple(new String[] {GROUP_MEMBER_OUTPUT_PARAMETER_NAMES, 
                                    GROUP_MEMBER_OUTPUT_FIELD_TYPES});
                                    
        // set resource domain for the pollingName property
        d.setResourceDomain(GROUP_MEMBER_POLLING_NAME, 
                            DOMAIN_POLLING_NAMES, null);

        // set resource domain for the inputParameterNames property
        // the resource domain look up has a dependency on the pollingName
        // property value
        d.setResourceDomain(GROUP_MEMBER_INPUT_PARAMETER_NAMES,
                            DOMAIN_INPUT_PARAMETER_NAMES,
                            new String[] {GROUP_MEMBER_POLLING_NAME});

        // set resource domain for the inputFieldTypes property
        // the resource domain look up has a dependency on the pollingName
        // property value
        d.setResourceDomain(GROUP_MEMBER_INPUT_FIELD_TYPES,
                            DOMAIN_INPUT_FIELD_TYPES,
                            new String[] {GROUP_MEMBER_POLLING_NAME});

        // compare with FucntionInvocation.java code
        // there is no input signature, because polling does not take run time
        // input. Therefore any polling criteria is set with the inputFieldValues
        // property at configuration time.
        
        // set resource domain for the outputParameterNames property
        // the resource domain look up has a dependency on the functionName
        // property value
        d.setResourceDomain(GROUP_MEMBER_OUTPUT_PARAMETER_NAMES,
                            DOMAIN_OUTPUT_PARAMETER_NAMES,
                            new String[] {GROUP_MEMBER_POLLING_NAME});

        // set resource domain for the outputFieldTypes property
        // the resource domain look up has a dependency on the functionName
        // property value
        d.setResourceDomain(GROUP_MEMBER_OUTPUT_FIELD_TYPES,
                            DOMAIN_OUTPUT_FIELD_TYPES,
                            new String[] {GROUP_MEMBER_POLLING_NAME});

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

    /*
     * Executes a poll. Reads polling result information from the Sample server
     * and publishes them.
     *
     * an AdapterException is thrown if it encounters any problem
     */
    public void runNotification() throws ResourceException {
        WmRecord output = null;

        // build a Sample server polling request document
        Document doc = new Document(Document.POLLING_REQUEST);
        doc.addField(new Field(Document.POLLING_NAME, _pollingName));
        
        // there is no runtime input, polling criteria must come from the configuration
        int inputFieldLength = _inputParameterNames.length;
        
        try {
            // retrieve all polling criteria values from the inputFieldValues property
            for (int i = 0; i < inputFieldLength; i++) {
                Field field = null;
                if (_inputFieldTypes[i].equals("java.lang.String"))
                    field = new Field(_inputParameterNames[i], _inputFieldValues[i]);
                else if (_inputFieldTypes[i].equals("java.lang.Integer"))
                    field = new Field(_inputParameterNames[i],
                                      Integer.valueOf(_inputFieldValues[i]));
                else if (_inputFieldTypes[i].equals("java.lang.Long"))
                    field = new Field(_inputParameterNames[i],
                                      Long.valueOf(_inputFieldValues[i]));   
                doc.addField(field);
            }
        } catch (Exception e) { // if encounter data conversion problem
            throw WmSampleAdapter.getInstance().createAdapterException(1003);
        }

        // send the polling request document to the Sample server
        WmSampleConnection connection = (WmSampleConnection)retrieveConnection();
        connection.sendDocument(doc);

        // receive the polling result document back from the Sample server
        Document resultDoc = connection.receiveDocument();
         // retrieve the result document type
        int documentType = resultDoc.getDocumentType();

        // if the result document type is NAK
        if (documentType == Document.NEGATIVE_ACKNOWLEDGMENT) {
            // throw an AdapterException indicating polling error
            throw WmSampleAdapter.getInstance().createAdapterException(1005, 
              new String[] {(String)resultDoc.getFieldValue(Document.ERROR_MESSAGE)});
        // else if there is polling result
        } else if (documentType == Document.POLLING_OUTPUT) {
            // move the result to output wmRecord
            output = WmRecordFactory.getFactory().createWmRecord("PollingOutput");
            IData outputRecord = IDataFactory.create();
            DocumentHelper.moveDocument2IData(resultDoc, outputRecord); 
            output.setIData(outputRecord);
        }
        //  else documentType is ACKNOWEDGMENT
        //  there is no output, keep the output as null

        // if polling output wmRecord is not null
        if (output != null)
            // publish the polling result
            doNotify(output);
    }
}