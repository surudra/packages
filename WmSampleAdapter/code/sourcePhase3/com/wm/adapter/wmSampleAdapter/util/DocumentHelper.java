/*
 * DocumentHelper.java
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
package com.wm.adapter.wmSampleAdapter.util;

import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataFactory;

// the Sample server document package
import com.sample.document.Document;
import com.sample.document.Field;

import java.util.Vector;

/*
 * This utility class facilitates data structure conversion between a Sample
 * server Document and a webMethods Integration Server IData.
 */
public class DocumentHelper {
    /*
     * Move data elements from a webMethods Integration Server <code>IData</code>
     * to a Sample server <code>Document</code> structure.
     *
     * iData is a source webMethods Integration Server IData
     * document is a target Sample server Dcouement
     */
    public static void moveIData2Document(IData iData, Document document) {
        int length = 0;
        IDataCursor cursor = iData.getCursor();

        // count the field length of the iData
        if (cursor.first()) {
            length = 1;
            while (cursor.hasMoreData()) {
                cursor.next();
                length++;
            }
        }
        cursor.first();

        String keys[] = new String[length];

        // loop over each field of the iData
        for (int i = 0; i < length; i++) {
            keys[i] = cursor.getKey();
            Field field = null;
            Object value = cursor.getValue();
            cursor.next();
            
            // if the field value is an array
            if (value.getClass().isArray()) {
                int valueLength = ((Object[])value).length;
                Object fieldValues[];

                // this works because the top level iData would only have primitive
                // data wrapper type or IData or their array only
                if (value instanceof IData[]) {
                    fieldValues = new Document[valueLength];
                    for (int j = 0; j < valueLength; j++) {
                        Document doc = new Document();
                        moveIData2Document((IData)((Object[])value)[j], doc);
                        fieldValues[j] = doc;
                    }
                }
                else {
                    fieldValues = (Object[])value;
                }
              
                field = new Field(keys[i], fieldValues);
            }
            else {
                field = new Field(keys[i], value);
            }
            document.addField(field);
        }
        cursor.destroy();
    }

    /*
     * Move data elements from a Sample server Document to a webMethods Integration
     * Server IData structure.
     *
     * document is a source Sample server Dcouement
     * record is a target webMethods Integration Server IData
     */
    public static void moveDocument2IData(Document document, IData record) {
        // retrieve field length of the document
        int fieldLength = document.getFieldLength();
        IDataCursor cursor = record.getCursor();
        cursor.first();

        // loop over each field
        for (int i = 0; i < fieldLength; i++) {
            String fieldName = document.getField(i).getFieldName();
            Object fieldValue = document.getFieldValue(i);
            // if the field has a subdocument
            if (fieldValue instanceof Document) {
                IData subRecord = IDataFactory.create();

                moveDocument2IData((Document)fieldValue, subRecord);
                cursor.insertAfter(fieldName, subRecord);
            }
            else if (fieldValue instanceof Document[]) {
                int subFieldLength = ((Object[])fieldValue).length;
                IData subRecords[] = new IData[subFieldLength];
                for (int j = 0; j < subFieldLength; j++) {
                    subRecords[j] = IDataFactory.create();
                    moveDocument2IData(
                      (Document)((Object[])fieldValue)[j], subRecords[j]);
                }
                cursor.insertAfter(fieldName, subRecords);
            }
            else {                
                cursor.insertAfter(fieldName, fieldValue);
            }
        }
        cursor.destroy();
    }

    /*
     * Build servicesignature in the format that is required by the resource
     * domain loopup.
     * doc is a signature subdocument,
     * prefix is a subrecord prefix to indicate the structure this document is
     * contained
     * postfix is a string representation of a sequence of square bracket pairs
     * two string arrays are returned, the first array contains all the field names,
     * the second arrays contains all the field types
     * Note: this method is used in a recursive approach to build service signature
     */
    private static String[][] getSignature(
      Document doc, String prefix, String postfix) {

        Vector v1 = new Vector();
        Vector v2 = new Vector();

        String fieldName;
        Object fieldValue;
        int fieldLength = doc.getFieldLength();
   
        for (int i = 0; i < fieldLength; i++) {
            fieldValue = doc.getFieldValue(i);
            if (fieldValue instanceof Object[]) {
            // if (fieldValue.getClass().isArray()) {
                fieldName = prefix + doc.getField(i).getFieldName() + "[]";
                if (fieldValue instanceof String[]) {
                    v1.addElement(fieldName);
                    v2.addElement(((String[])fieldValue)[0]+postfix+"[]");
                }
                else {
                    String [][] signature = getSignature((((Document[])fieldValue)[0]), fieldName + ".", postfix + "[]");
                    for (int j = 0; j < signature[0].length; j++) {
                        v1.addElement(signature[0][j]);
                        v2.addElement(signature[1][j]);
                    }
                }
            }
            else {
                fieldName = prefix + doc.getField(i).getFieldName();
                v1.addElement(fieldName);
                v2.addElement(fieldValue+postfix);
            }
        }

        String signature[][] = new String[2][];
        signature[0] = new String[v1.size()];
        signature[1] = new String[v1.size()];
        for (int i = 0; i < v1.size(); i++) {
            signature[0][i] = (String)v1.elementAt(i);
            signature[1][i] = (String)v2.elementAt(i);
        }
        return signature;
    }

    /*
     * Build service signature in the format that is required by the resource
     * domain loopup.
     *
     * doc is a signature subdocument, this must be the field value of an
     * input signature or output signature field of a document received from the
     * Sample server when a service signature request is issued
     * two string arrays are returned, the first array contains all the field names,
     * the second arrays contains all the field types
     */
    public static String[][] getSignature(Document doc) {
        return getSignature(doc, "", "");
    }
}