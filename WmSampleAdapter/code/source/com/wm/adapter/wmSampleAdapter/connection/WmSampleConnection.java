/*
 * WmSampleConnection.java
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
import com.wm.adapter.wmSampleAdapter.util.DocumentHelper;

import com.wm.adk.connection.WmManagedConnection;
import com.wm.adk.error.AdapterConnectionException;
import com.wm.adk.error.AdapterException;
import com.wm.adk.metadata.WmAdapterAccess;
import com.wm.adk.metadata.ResourceDomainValues;

import java.io.InterruptedIOException;
import java.io.IOException;

import javax.resource.spi.ConnectionRequestInfo;
import javax.security.auth.Subject;
import javax.resource.ResourceException;
import javax.resource.spi.LocalTransaction;

// the Sample server client and document packages
import com.sample.client.Connection;
import com.sample.document.Document;

/*
 * This class represents WmSampleAdapter's connection to Sample Server.
 */
public class WmSampleConnection extends WmManagedConnection
  implements WmSampleAdapterConstants
{
    private Connection _sampleConnection = null;
    private String _serverHost = null;
    private int _serverPort = 0;
    private int _timeout = 20000;
    private boolean _localTransactionControl = false;
    private LocalTransaction _localTransaction = null;
    
    // added at Phase 5 to support listening notification
    private boolean _listenerMode = false;
    
    /*
     * Constructor a WmSampleConnection
     *
     * serverHost is the IP address of the computer where Sample Server is running.
     * serverPort is the port number that Sample Server is listening for client
     * connection request.
     * timeout is the socket time in milliseconds.
     * localTransactionControl is the flag indicates whether transactional contorl
     * is in effect for this connection.
     */
    public WmSampleConnection(String serverHost, int serverPort, int timeout,
      boolean localTransactionControl) {
        _serverHost = serverHost;
        _serverPort = serverPort;
        _timeout = timeout;
        _localTransactionControl = localTransactionControl;
    }

    /*
     * Destroys the connection.
     *
     * an AdapterConnectionException is thrown if it has communication trouble.
     */
    public void destroyConnection() throws ResourceException {
        try {
            _sampleConnection.close();
            _sampleConnection = null;
        } catch (IOException e) {
            AdapterConnectionException ace =
              WmSampleAdapter.getInstance().createAdapterConnectionException(
              1001, null, e);
        }
    }
    
    /*
     * Specifies that initialization is required immediately after a connection
     * is created for the first time.
     */
    protected boolean initializationRequired() {
        return true;
    }

    /*
     * Initializes a connection immediately after it is created for the first time.
     * This method will be invoked during the creation of a new connection
     * because the initializationRequired() method returns true.
     */
    protected void initializeConnection(Subject subject,
      ConnectionRequestInfo requestInfo) throws ResourceException {

        // generate a debug-level Journal log entry to indicate that a connection
        // is being initialized by the WmSampleAdapter. 
        // the parameter "101" in the logDebug(101) method invocation is used as
        // the key to lookup the actual text of the Journal Entry in the Resource
        // Bundle, com.wm.adapter.wmSampleAdapter.WmSampleAdapterResourceBundle/
        // If the Integration Server is running with a Logging level of 5 or higher,
        // the logDebug(101) generates a Journal log entry similar to the following
        // example:
        //
        // 2002-11-19 10:18:13 EST [ADA.0502.0101D] Initializing Sample Connection
        //
        // refer to the Javadoc of the ARTLogger class for more information on
        // Journal Logging and the available logging levels.
        ((WmSampleAdapter)WmSampleAdapter.getInstance()).retrieveLogger().logDebug(101);

        try {
            _sampleConnection = new Connection (_serverHost, _serverPort, _timeout);
            if (_localTransactionControl) {
                _localTransaction = new WmSampleLocalTransaction(_sampleConnection);
                _sampleConnection.setAutoCommit(false);
            }
            else
                _sampleConnection.setAutoCommit(true);
        } catch (IOException e) {
            AdapterConnectionException ace =
              WmSampleAdapter.getInstance().createAdapterConnectionException(
              1001, null, e);

            // set the fatal flag to true will force the pool manager to refresh all
            // the connection instance in the pool.
            // set the fatal flag to false will only trash this current connection
            // instance.
            // in the Sample Server communication, normally an IO failure indicates
            // the Sample Server probably has been shutdown. Therefore, it is appropriate
            // to flush the whole pool.
            // you have to make reasonable detection in your communication with the 
            // backend resource to determine the appropriate action.
            ace.setFatal(true);
            throw ace;
        }
    }

    // added at Phase 5 to support listening notification
    /*
     * Set the connection to listener mode
     *
     * flag is a boolean flag indacates it is listener mode or interation mode
     * an AdapterConnectionException is thrown if there is communication
     * problem.
     */
    public void setToListenerMode(boolean flag) throws AdapterConnectionException {
        if (_listenerMode != flag) {
            try {
                _sampleConnection.setToListenerMode(flag);
                _listenerMode = flag;
            } catch (IOException e) {
                // throw new ResourceException(e.getMessage());
                AdapterConnectionException ace =
                  WmSampleAdapter.getInstance().createAdapterConnectionException(
                  1001, null, e);

                 // see the comment of setFatal in initializeConnection method
                ace.setFatal(true);
                throw ace;
            }
        }        
        return;
    }

    /*
     * Register in the WmAdapterAccess object for the Resource domain look up support.
     * This method will be called after the constructor has been called, but before
     * any properties are set. The reference to WmAdapterAccess should be stored for
     * later use, if needed. Register resourceDomain, using
     * WmAdapterAccess.addResourceDomainLookup(), if the values need to query the
     * backend resource.
     *
     * The parameter access is a reference to a WmAdapterAccess object.
     * AdapterException is thrown if the method encounters an error.
     */
    public void registerResourceDomain(WmAdapterAccess access)
      throws AdapterException {
        // doing nothing at Phase 2

        // added at Phase 3 to support function invocation service
        try 
        {
            // register all the resource domain look up here
            access.addResourceDomainLookup(null, DOMAIN_FUNCTION_NAMES, this);
            access.addResourceDomainLookup(null, DOMAIN_INPUT_PARAMETER_NAMES, this);
            access.addResourceDomainLookup(null, DOMAIN_INPUT_FIELD_TYPES, this);
            access.addResourceDomainLookup(null, DOMAIN_INPUT_FIELD_NAMES, this);
            access.addResourceDomainLookup(null, DOMAIN_OUTPUT_PARAMETER_NAMES, this);
            access.addResourceDomainLookup(null, DOMAIN_OUTPUT_FIELD_TYPES, this);
            access.addResourceDomainLookup(null, DOMAIN_OUTPUT_FIELD_NAMES, this);
            
            // added at Phase 4 to support message polling notification
            access.addResourceDomainLookup(null, DOMAIN_POLLING_NAMES, this);

            // added at Phase 5 to support listener notification
            access.addResourceDomainLookup(null, DOMAIN_NOTIFICATION_NAMES, this);
        } catch (Exception ex) {
            throw WmSampleAdapter.getInstance().createAdapterException(1002, ex);
        }
    }

    /*
     * Looks up values for a resourceDomain. The Adapter Service Editor or Adapter
     * Notification Editor will call this method for the resource domains that are
     * registered using addResourceDomainLookup. This method will return the values
     * for tools to fill in each display widget.
     * Implement this method if your adapter implements resourceDomains. Returns
     * a com.wm.adk.metadata.ResourceDomainValues object with the proper data.
     * Returns multiple objects if you are using tuples.
     *
     * serviceName is the name of the adapter service/notification template.
     * resourceDomainName is the name of the resourceDomain.
     * values are the values for the dependency resourceDomain parameters.
     * AdapterException is thrown if the method encounters an error.
     */  
    public ResourceDomainValues[] adapterResourceDomainLookup(
      String serviceName, String resourceDomainName, String[][] values)
      throws AdapterException {

        // added at Phase 3 to support function invocation service
        try {
            if (resourceDomainName.equals(DOMAIN_FUNCTION_NAMES)) {
               Document doc = _sampleConnection.requestServiceList();
               return new ResourceDomainValues[] {
                 new ResourceDomainValues(resourceDomainName, (String[])doc.getFieldValue(0))};
            }
            // added at Phase 4 to support message polling notification
            else if (resourceDomainName.equals(DOMAIN_POLLING_NAMES)) {
               Document doc = _sampleConnection.requestPollingList();
               return new ResourceDomainValues[] {
                 new ResourceDomainValues(resourceDomainName, (String[])doc.getFieldValue(0))};
            }
            // added at Phase 5 to support listener notification
            else if (resourceDomainName.equals(DOMAIN_NOTIFICATION_NAMES)) {
               Document doc = _sampleConnection.requestNotificationList();
               return new ResourceDomainValues[] {
                 new ResourceDomainValues(resourceDomainName, (String[])doc.getFieldValue(0))};
            }
            // because input parameters and input field types have been declared as
            // tuple, they are looked up together
            else if (resourceDomainName.equals(GROUP_MEMBER_INPUT_PARAMETER_NAMES) ||
                     resourceDomainName.equals(GROUP_MEMBER_INPUT_FIELD_TYPES)) {
                // There is only one dependency for these resource domains.
                // values[0][0] is one of the function or polling Names.
                Document doc;
                // modified at Phase 4 to support message polling notification
                // when more than one template use the same resource domain name for
                // look up purpose, you have to differentiate the source of the lookup
                // request.
                if (serviceName.equals(SERVICE_TEMPLATE))
                    doc = _sampleConnection.requestServiceSignature(values[0][0]);
                // added at Phase 4 to support message polling notification
                else
                    doc = _sampleConnection.requestPollingSignature(values[0][0]);
                    
                Document signatureDoc = (Document)doc.getFieldValue(Document.INPUT_SIGNATURE);
                if (signatureDoc == null) {
                    return new ResourceDomainValues[] {
                      new ResourceDomainValues(GROUP_MEMBER_INPUT_PARAMETER_NAMES),
                      new ResourceDomainValues(GROUP_MEMBER_INPUT_FIELD_TYPES)};
                }
                else {
                    String signature[][] = DocumentHelper.getSignature(signatureDoc);
                    return new ResourceDomainValues[] {
                      new ResourceDomainValues(GROUP_MEMBER_INPUT_PARAMETER_NAMES, signature[0]),
                      new ResourceDomainValues(GROUP_MEMBER_INPUT_FIELD_TYPES, signature[1])};
                }
            }
            // because output parameters and output field types have been declared as
            // tuple, they are looked up together
            else if (resourceDomainName.equals(GROUP_MEMBER_OUTPUT_PARAMETER_NAMES) ||
                     resourceDomainName.equals(GROUP_MEMBER_OUTPUT_FIELD_TYPES)) {
                // There is only one dependency for these resource domains.
                // values[0][0] is either a function, polling, or event notification
                // names.
                Document doc;
                // modified at Phase 4 to support message polling notification
                // when more than one template use the same resource domain name for
                // look up purpose, you have to differentiate the source of the lookup
                // request.
                if (serviceName.equals(SERVICE_TEMPLATE))
                    doc = _sampleConnection.requestServiceSignature(values[0][0]);
                // modified at Phase 5 to support listener notification
                else if (serviceName.equals(POLLING_TEMPLATE))
                    doc = _sampleConnection.requestPollingSignature(values[0][0]);
                // added at Phase 5 to support listener notification
                else 
                    doc = _sampleConnection.requestNotificationSignature(values[0][0]);

                Document signatureDoc = (Document)doc.getFieldValue(Document.OUTPUT_SIGNATURE);
                if (signatureDoc == null) {
                    return new ResourceDomainValues[] {
                      new ResourceDomainValues(GROUP_MEMBER_OUTPUT_PARAMETER_NAMES),
                      new ResourceDomainValues(GROUP_MEMBER_OUTPUT_FIELD_TYPES)};
                }
                else {
                    String signature[][] = DocumentHelper.getSignature(signatureDoc); 
                    // returns the values of the "outputParameterNames" and
                    // "outputFieldTypes" together, because they are a tuple.
                    return new ResourceDomainValues[] {
                      new ResourceDomainValues(GROUP_MEMBER_OUTPUT_PARAMETER_NAMES,signature[0]),
                      new ResourceDomainValues(GROUP_MEMBER_OUTPUT_FIELD_TYPES,signature[1])};
                }
            }
            else
                // return nothing at Phase 2
                return null;

        } catch (IOException ie) {
            AdapterConnectionException ace =
              WmSampleAdapter.getInstance().createAdapterConnectionException(
              1001, null, ie);

            // see the comment of setFatal in initializeConnection method
            ace.setFatal(true);
            throw ace;
        }
    }
    
    /*
     * Check a resourceDomain value. This method returns Boolean.TRUE if
     * testValue is valid in this context, Boolean.FALSE if it is
     * not valid, or null if the value cannot be confirmed by the
     * adapter. The WmSampleAdapter doesn't use this feature.
     * Implement this method if your adapter implements resourceDomains and
     * needs to verify the user input. 
     * This method is called when a user types a value into 
     * the Adapter Service Editor or Adapter Notification Editor 
     * while the editor is displaying an incomplete resourceDomain 
     * (ResourceDomainValues.setComplete is false) and the
     * ResourceDomainValues.canValidate flag is set to true.
     *
     * serviceName is the name of the service/notification template.
     * resourceDomainName is the name of the resourceDomain.
     * values are the values for the resourceDomain parameters.
     * testValue is the value to test.
     * Returns Boolean.TRUE if testValue is valid in this context, Boolean.FALSE if it is not
     * valid, or null if the value cannot be confirmed by the adapter.
     *
     * AdapterException is thrown if the method encounters an error.
     */
    public Boolean adapterCheckValue(String serviceName,
      String resourceDomainName, String[][] values, String testValue)
      throws AdapterException {

        return null;
    }  

    /*
     * Send a document to Sample Server.
     * This is a wrapper method for underlining Sample client connection object.
     */
    public void sendDocument(Document doc) throws ResourceException {
        try {
            _sampleConnection.sendDocument(doc);
        } catch (IOException ie) {
            AdapterConnectionException ace =
              WmSampleAdapter.getInstance().createAdapterConnectionException(
              1001, null, ie);

            // see the comment of setFatal in initializeConnection method
            ace.setFatal(true);
            throw ace;
        }
    }
    
    /*
     * Receive a document from Sample Server.
     * This is a wrapper method for underlining Sample client connection object.
     */
    public Document receiveDocument() throws ResourceException {
        try {
            return _sampleConnection.receiveDocument();
        } catch (IOException ie) {
            AdapterConnectionException ace =
              WmSampleAdapter.getInstance().createAdapterConnectionException(
              1001, null, ie);

            // see the comment of setFatal in initializeConnection method
            ace.setFatal(true);
            throw ace;
        }
    }

    /*
     * Receive a document from Sample Server but catch time out
     *
     * This method will return null when timeout
     */
    public Document receiveDocumentAllowTimeout() throws ResourceException {
        try {
            return _sampleConnection.receiveDocument();
        } catch (InterruptedIOException ie) {
            // allow time out return null
            return null;
        } catch (IOException ie) {
            AdapterConnectionException ace =
              WmSampleAdapter.getInstance().createAdapterConnectionException(
              1001, null, ie);

            // see the comment of setFatal in initializeConnection method
            ace.setFatal(true);
            throw ace;
        }
    }

    // you must overwrite the defult implementation from the superclass to
    // support the local transaction control
    public LocalTransaction getLocalTransaction() {
        return _localTransaction;
    }
}
  
/*
 * This class represents a local transaction object.
 * You must create this class and implement the interface LocalTransaction to 
 * support the local transaction control
 */
class WmSampleLocalTransaction implements LocalTransaction
{
    private Connection _connection;

    /*
     * Constructor
     *
     * connection is a native Sample Server client connection
     */
    WmSampleLocalTransaction(Connection connection) {
        _connection = connection;
    }

    /*
     * Begin a transaction
     *
     * throws a ResourceException when it encounters a problem
     */
    public void begin() throws ResourceException {
        try {
            Document doc = _connection.beginTransaction();
        } catch (Exception e) {
            throw new ResourceException(e.getMessage());
        }
    }

    /*
     * Commit a transaction.
     *
     * throws a ResourceException when it encounters a problem
     */
    public void commit() throws ResourceException {
        try {
            Document doc = _connection.commitTransaction();
        } catch (Exception e) {
            throw new ResourceException(e.getMessage());
        }
    }

    /*
     * Rollback a transaction.
     *
     * throws a ResourceException when it encounters a problem
     */
    public void rollback() throws ResourceException {
        try {
            Document doc = _connection.rollbackTransaction();
        } catch (Exception e) {
            throw new ResourceException(e.getMessage());
        }
    }
}     