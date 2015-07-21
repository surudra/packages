/*
 * WmSampleConnectionFactory.java
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
package com.wm.adapter.wmSampleAdapter.connection;

import com.wm.adapter.wmSampleAdapter.WmSampleAdapter;
import com.wm.adapter.wmSampleAdapter.WmSampleAdapterConstants;
import com.wm.adapter.wmSampleAdapter.service.FunctionInvocation;

import com.wm.adk.connection.WmManagedConnection;
import com.wm.adk.connection.WmManagedConnectionFactory;
import com.wm.adk.error.AdapterException;
import com.wm.adk.info.ResourceAdapterMetadataInfo;
import com.wm.adk.metadata.WmDescriptor;

import java.util.Locale;
import javax.resource.ResourceException;
import javax.resource.spi.ConnectionRequestInfo;
import javax.security.auth.Subject;

/*
 * This class represents WmSampleAdapter's connection type to Sample server.
 * This class contains the properties of the connection type to make the
 * connection to a Sample server and the metadata that describes these properties.
 * It also provides the interfaces needed by the Integration Server to create the
 * connections to the resource. The Integration Server introspects the Bean
 * properties, gathers the extra metadata from fillWmDescriptor, and populates
 * the adapter's administrative interface with this information. Based on the
 * data entered in the administrative interface, the Integration Server will
 * generate the connection factory and establish the connection to the resource.
 */
public class WmSampleConnectionFactory extends WmManagedConnectionFactory
  implements WmSampleAdapterConstants
{
    private String _sampleServerHostName = null;
    private int _sampleServerPortNumber = 4444;
    private int _timeout = 20000;
    private boolean _transactionControl = false;

    /*
     * Set the sampleServerHostName property value
     *
     * serverHostName is the IP address of the computer where Sample Server is
     * running.
     */
    public void setSampleServerHostName(String serverHostName) {
        _sampleServerHostName = serverHostName;
    }

    /*
     * Get the sampleServerHostName property value
     */
    public String getSampleServerHostName() {
        return _sampleServerHostName;
    }

    /*
     * Set the sampleServerPortNumber property value.
     *
     * serverPortNumber is the port number that Sample Server is listening for
     * client connection request.
     */
    public void setSampleServerPortNumber(int serverPortNumber) {
        _sampleServerPortNumber = serverPortNumber;
    }

    /*
     * Get the sampleServerPortNumber property value.
     *
     * serverPortNumber is the port number that Sample Server is listening for
     * client connection request.
     */
    public int getSampleServerPortNumber() {
        return _sampleServerPortNumber;
    }

    /*
     * Set the timeout property value.
     *
     * timeout is the socket time out in milliseconds
     */
    public void setTimeout(int timeout) {
        _timeout = timeout;
    }

    /*
     * Get the timeout property value.
     *
     * timeout is the socket time out in milliseconds
     */
    public int getTimeout() {
        return _timeout;
    }

    /*
     * Set the transactionType property value.
     *
     * transactionControl has the value of "true" or "false" to indicate whether
     * the local transactional control needs to be activated.
     */
    public void setTransactionType(String transactionControl) {
        if (transactionControl.equals("true"))
            _transactionControl = true;
        else
            _transactionControl = false;
    }

    /*
     * Get the transactionType property value.
     */
    public String getTransactionType() {
        if (_transactionControl == true)
            return "true";
        else
            return "false";
    }

    /*
     * Creates and returns a connection instance to the Sample server.
     *
     * subject is not used in this release.
     * cxRequestInfo is not used in this release.
     * returns a WmSampleConnection object that represents a
     * connection to the Sample server. 
     * throws an AdapterConnectionException if an error occurred
     * while creating a connection to the Sample server.
     */
    public WmManagedConnection createManagedConnectionObject(
      javax.security.auth.Subject subject,
      javax.resource.spi.ConnectionRequestInfo connectionRequestInfo)
      throws AdapterException {

        return new WmSampleConnection(
          _sampleServerHostName, _sampleServerPortNumber, _timeout, _transactionControl);
    }

    /*
     * Returns the types of transactions that are supported by the connections 
     * that are created by this factory. WmSampleConnectionFactory supports either
     * a local transaction control or no transaction control (aka autocommit)
     */
    public int queryTransactionSupportLevel() {
        if (_transactionControl == true)
            return LOCAL_TRANSACTION_SUPPORT;
        else
            return NO_TRANSACTION_SUPPORT;
    }

    /*
     * This method populates the metadata object describing this connection
     * factory in the specified locale.
     * This method will be called once for each ManagedConnectionFactory.
     *
     * d is the metadata object describing this adapter service.
     * l is the Locale in which the locale-specific metadata should be
     * populated.
     * AdapterException is thrown if an error is encountered while populating the
     * metadata.
     */
    public void fillWmDescriptor(WmDescriptor d, Locale l)
      throws AdapterException {

        d.createGroup(GROUP_SAMPLE_CONNECTION,
          new String[] {SAMPLE_SERVER_HOST_NAME, SAMPLE_SERVER_PORT_NUMBER,
                        SAMPLE_TRANSACTION_TYPE, SAMPLE_CONNECTOR_TIMEOUT});
 
        //The Sample server host name is mandatory.
        d.setMinStringLength(SAMPLE_SERVER_HOST_NAME, 1);

        // this is not internationalized
        d.setValidValues(SAMPLE_TRANSACTION_TYPE, new String[] {"true", "false"});
       
        // Retrieves the i18n metadata information from the resource bundle and
        // replaces he non-localized metadata.
        // The metadata that needs to be internationalized (the parameter display
        // name, description, group name, etc.) will populate the administrative
        // interface, Adapter Service Editor, or Adapter Notification Editor.
        d.setDescriptions(
          WmSampleAdapter.getInstance().getAdapterResourceBundleManager(), l);  
    }

    /*
     * Registers the adapter service templates that this connection supports.
     * 
     * The info parameter is the metadata object used to register the adapter 
     * service templates supported by this connection.
     * The locale parameter is the Local object.
     * AdapterException is thrown if an error occurs while registering the
     * adapter service templates.
     *
     */
    public void fillResourceAdapterMetadataInfo(
      ResourceAdapterMetadataInfo info, Locale locale) throws AdapterException {

        WmSampleAdapter.getInstance().fillResourceAdapterMetadataInfo(info, locale);

        // added at Phase 3 to support service template
        // add adapter service templates supported by this connection.
        info.addServiceTemplate(FunctionInvocation.class.getName());
    }
}