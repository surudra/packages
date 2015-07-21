function writeTDwidth(c, width)
{
    var line = "<TD CLASS=\"" + row + c + "\" width=\"" + width + "\"/>";
    w(line);
    return true;
}

function writeInput(type, name, value, isDisabled) {
    writeInputSize(type, name, value, isDisabled, null);
}

function writeInputSize(type, name, value, isDisabled, size) {
    var valesc = unescape(value);
    var str = "<input type=\"" + type + "\" name=\"" + name + "\" value=\"" + valesc + "\"";

    if (size) {
        str += " size=\"" + size + "\"";
    }

    if (isDisabled == true || isDisabled == "true") {
        str += " disabled";
    }

    str += "/>";

    w(str);
}

function writeCheckboxRow(name, value, text, checked, disabled) {
    w("<tr>");
    writeCheckboxCell(name, value, text, checked, disabled);
    w("</tr>");
}

function writeCheckboxCell(name, value, text, checked, disabled) {
    writeTD('rowdata');
    w("<input type=\"checkbox\" id=\"" + name + "\"  name=\"" + name + "\" value=\"" + value + "\"");
    if (checked) {
        w(" checked ");
    }
    if (disabled) {
        w(" disabled ");
    }
    w("/>");
    w("<br>");
    w("</td>");
    writeTD('rowdata-l');
    w(text);
    swapRows();
}

function setChecked(form, checked) {
    for (opt in form) {
        var el = form[opt];
        if (el && el.type == "checkbox" && (el.name == "tnassets" || el.name == "default" || el.name.indexOf("pkg-") == 0)) {
            el.checked = checked;
        }
    }
}    

function hasCheck(form) {
    for (opt in form) {
        var el = form[opt];
        if (el && el.type == "checkbox" && el.checked) {
            return true;
        }
    }
    return false;
}

var xmlhttp;

function loadXMLDoc(url, onChange) {
    if (window.XMLHttpRequest) {
        // Mozilla.
        xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = onChange;
        xmlhttp.open("GET", url, true);
        xmlhttp.send(null);
    }
    else if (window.ActiveXObject) {
        // IE
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        if (xmlhttp) {
            xmlhttp.onreadystatechange = onChange;
            xmlhttp.open("GET", url, true);
            xmlhttp.send();
        }
    }
}

function setHelpPage(helpee, helper) {
    setNavigation("/WmAssetPublisher/" + helpee, "/WmAssetPublisher/doc/OnlineHelp/Menu_Solutions_AssetPub_" + helper);
}

// Modified from WmRoot/pub/settings-remote-addedit.dsp.

function checkMachineName(field, fieldName)
{
    var name = field.value;
    var illegalChars = " #&@^!%*:$/\\`;,~+=)(|}{][><\"";

    for (var i=0; i<illegalChars.length; i++) {
        if (name.indexOf(illegalChars.charAt(i)) >= 0) {
            alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
            return false;
        }
    }
    return true;
}

function checkNonNegNumber(field)
{
    var str = field.value;

    if (isblank(str) || !isNum(str) || str < 0) {
        field.focus();
        return false;
    }

    return true;
}
