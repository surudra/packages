/*
 * FunctionInvocation.java
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
package com.wm.adapter.wmSampleAdapter.service;

import java.util.Locale;
import javax.resource.ResourceException;

import com.wm.adk.cci.interaction.WmAdapterService;
import com.wm.adk.cci.record.WmRecord;
import com.wm.adk.cci.record.WmRecordFactory;
import com.wm.adk.connection.WmManagedConnection;
import com.wm.adk.error.AdapterException;
import com.wm.adk.metadata.WmTemplateDescriptor;

import com.wm.adapter.wmSampleAdapter.WmSampleAdapter;
import com.wm.adapter.wmSampleAdapter.WmSampleAdapterConstants;
import com.wm.adapter.wmSampleAdapter.connection.WmSampleConnection;
import com.wm.adapter.wmSampleAdapter.util.DocumentHelper;

import com.wm.data.IData;
import com.wm.data.IDataFactory;

// the Sample server document package
import com.sample.document.Document;
import com.sample.document.Field;

/*
 * This is an adapter service template class to facilitate the function invocation
 * on a Sample server.
 */
public class FunctionInvocation extends WmAdapterService
  implements WmSampleAdapterConstants
{
    // functionName property
    private String _functionName;

    // inputParameterNames property
    private String[] _inputParameterNames;

    // inputFieldName property
    private String[] _inputFieldNames;

    // inputFieldTypes property
    private String[] _inputFieldTypes;

    // outputParameterNames property
    private String[] _outputParameterNames;

    // outputFieldNames property
    private String[] _outputFieldNames;

    // outputFielTypes property
    private String[] _outputFieldTypes;

    /*
     * Default Constructor
     */
    public FunctionInvocation() {
    }

    /*
     * Set functionName property value
     *
     * functionName is a Sample Server service function name
     */
    public void setFunctionName(String functionName) {
        _functionName = functionName;
    }

    /*
     * Get functionName property value
     *
     * return Sample Server service function name
     */
    public String getFunctionName() {
        return _functionName;
    }

    /*
     * Set inputParameterNames property value
     *
     * inputParameterNames are Sample Server service invocation input parameter
     * names. These parameters reflect the fully qualified structure names
     */
    public void setInputParameterNames(String[] inputParameterNames) {
        _inputParameterNames = inputParameterNames;
    }

    /*
     * Get inputParameterNames property value
     *
     * return Sample Server service invocation input parameter names.
     * These parameters reflect the fully qualified structure names
     */
    public String[] getInputParameterNames() {
        return _inputParameterNames;
    }

    /*
     * Set inputFieldNames property value
     *
     * inputFieldNames are Sample Server service invocation input parameter
     * names. These names are used to build the input signature
     */
    public void setInputFieldNames(String[] inputFieldNames) {
        _inputFieldNames = inputFieldNames;
    }

    /*
     * Get inputFieldNames property value
     *
     * return Sample Server service invocation input field names.
     * These names are used to build the input signature
     */
    public String[] getInputFieldNames() {
        return _inputFieldNames;
    }

    /*
     * Set inputFieldTypes property value
     *
     * inputFieldTypes are Sample Server service invocation input
     * field types. These types are used to build the input signature
     */
    public void setInputFieldTypes(String[] inputFieldTypes) {
        _inputFieldTypes = inputFieldTypes;
    }

    /*
     * Get inputFieldTypes property value
     *
     * return Sample Server service invocation input field types.
     * These types are used to build the input signature
     */
    public String[] getInputFieldTypes() {
        return _inputFieldTypes;
    }

    /*
     * Set outputParameterNames property value
     *
     * outputParameterNames are Sample Server service invocation output parameter
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
     * Execute a Sample server function invocation service request.
     *
     * connection is a connection handle.
     * input is the input record of the adapter service.
     * ResourceException is thrown if encounter communication problem
     */
    public WmRecord execute(WmManagedConnection connection, WmRecord input)
      throws ResourceException {

        WmRecord output = null;

        // built a Sample service request document
        Document requestDoc = new Document(Document.SERVICE_REQUEST);
        requestDoc.addField(new Field(Document.SERVICE_NAME, _functionName));

        try {
            DocumentHelper.moveIData2Document(input.getIData(), requestDoc);
        } catch (Exception e) {
            throw WmSampleAdapter.getInstance().createAdapterException(1003);
        }

        // send the Sample service request document to the Sample server
        ((WmSampleConnection)connection).sendDocument(requestDoc);

        // receive the result document back from the Sample server
        Document resultDoc = ((WmSampleConnection)connection).receiveDocument();
        // retrieve the result document type
        int documentType = resultDoc.getDocumentType();

        // if the result document type is NAK
        if (documentType == Document.NEGATIVE_ACKNOWLEDGMENT) {
            // service execution failed, throw resource exception
            throw WmSampleAdapter.getInstance().createAdapterException(1004,
              new String[] {(String)resultDoc.getFieldValue(Document.ERROR_MESSAGE)});

        // else if there is service output
        } else if (documentType == Document.SERVICE_OUTPUT) {
            // move the result to output
            output = WmRecordFactory.getFactory().createWmRecord("Output");            
            IData outputRecord = IDataFactory.create();
            DocumentHelper.moveDocument2IData(resultDoc, outputRecord);
            output.setIData(outputRecord);
        }
        //  else documentType is ACKNOWEDGMENT
        //  there is no output, keep the output as null

        return output;
    }

    /*
     * This method populates the metadata object describing this service
     * template in the specified locale.
     * This method will be called once for each service template.
     *
     * d is the metadata object describing this adapter service.
     * l is the Locale in which the locale-specific metadata should be
     * populated.
     * AdapterException is thrown if an error is encountered while populating the
     * metadata.
     */
    public void fillWmTemplateDescriptor(WmTemplateDescriptor d, Locale l)
      throws AdapterException {

        // create a group, essentially a tab in Developer
        d.createGroup(GROUP_FUNCTION_INVOCATION,
          new String[] {GROUP_MEMBER_FUNCTION_NAME,
                        GROUP_MEMBER_INPUT_PARAMETER_NAMES,
                        GROUP_MEMBER_INPUT_FIELD_NAMES,
                        GROUP_MEMBER_INPUT_FIELD_TYPES,
                        GROUP_MEMBER_OUTPUT_PARAMETER_NAMES,
                        GROUP_MEMBER_OUTPUT_FIELD_NAMES,
                        GROUP_MEMBER_OUTPUT_FIELD_TYPES});

        // functionName property is required and must be set
        d.setRequired(GROUP_MEMBER_FUNCTION_NAME);

        // list input parameters, field name and data types in table format
        d.createFieldMap(new String[] {GROUP_MEMBER_INPUT_PARAMETER_NAMES,
                                       GROUP_MEMBER_INPUT_FIELD_NAMES,
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

        // set resource domain for the functionName property
        d.setResourceDomain(GROUP_MEMBER_FUNCTION_NAME,
                            DOMAIN_FUNCTION_NAMES, null);

        // set resource domain for the inputParameterNames property
        // the resource domain look up has a dependency on the functionName
        // property value
        d.setResourceDomain(GROUP_MEMBER_INPUT_PARAMETER_NAMES,
                            DOMAIN_INPUT_PARAMETER_NAMES,
                            new String[] {GROUP_MEMBER_FUNCTION_NAME});

        // set resource domain for the inputFieldTypes property
        // the resource domain look up has a dependency on the functionName
        // property value
        d.setResourceDomain(GROUP_MEMBER_INPUT_FIELD_TYPES,
                            DOMAIN_INPUT_FIELD_TYPES,
                            new String[] {GROUP_MEMBER_FUNCTION_NAME});

        /*
         * WmTemplateDescriptor.INPUT_FIELD_NAMES is a specialized resource domain.
         * Normally it has a dependency on two other types of resource domains
         * the first one is the input parameters the second one is the input data
         * types corresponding to the input parameters. The input parameters will
         * become the suggested name for the property input field names.
         * If you set the boolean flag to true in the createFieldMap() method, end
         * user will have the option to overwrite the suggest names. Input signature 
         * is then built with the combination of the final values of the input field
         * names and input field types and optionally with use column, which may be
         * declared in the createGroup(), createFieldMap() and setResourceDomain()
         * methods.
         */

        // set resource domain for the inputFieldNames property
        // inputFieldNames and inputFieldTypes are used to build the input signature
        // inputParameterNames is used as suggested names for inputFieldNames
        d.setResourceDomain(GROUP_MEMBER_INPUT_FIELD_NAMES,
                            WmTemplateDescriptor.INPUT_FIELD_NAMES,
                            new String[] {GROUP_MEMBER_INPUT_PARAMETER_NAMES,
                                          GROUP_MEMBER_INPUT_FIELD_TYPES});

        // set resource domain for the outputParameterNames property
        // the resource domain look up has a dependency on the functionName
        // property value
        d.setResourceDomain(GROUP_MEMBER_OUTPUT_PARAMETER_NAMES,
                            DOMAIN_OUTPUT_PARAMETER_NAMES,
                            new String[] {GROUP_MEMBER_FUNCTION_NAME});

        // set resource domain for the outputFieldTypes property
        // the resource domain look up has a dependency on the functionName
        // property value
        d.setResourceDomain(GROUP_MEMBER_OUTPUT_FIELD_TYPES,
                            DOMAIN_OUTPUT_FIELD_TYPES,
                            new String[] {GROUP_MEMBER_FUNCTION_NAME});

        /*
         * WmTemplateDescriptor.OUTPUT_FIELD_NAMES is a specialized resource domain.
         * See the comment for WmTemplateDescriptor.INPUT_FIELD_NAMES above
         */

        // set resource domain for the outputFieldNames property
        // outputFieldNames and outputFieldTypes are used to build the output
        // signature
        // outputParameterNames is used as suggested names for outputFieldNames
        d.setResourceDomain(GROUP_MEMBER_OUTPUT_FIELD_NAMES,
                            WmTemplateDescriptor.OUTPUT_FIELD_NAMES,
                            new String[] {GROUP_MEMBER_OUTPUT_PARAMETER_NAMES,
                                          GROUP_MEMBER_OUTPUT_FIELD_TYPES});

        // Retrieves the i18n metadata information from the resource bundle and
        // replaces the non-localized metadata.
        // The metadata that needs to be internationalized (the parameter display
        // name, description, group name, etc.) will populate the administrative
        // interface, Adapter Service Editor, or Adapter Notification Editor.
        d.setDescriptions(
          WmSampleAdapter.getInstance().getAdapterResourceBundleManager(), l);
    }
}