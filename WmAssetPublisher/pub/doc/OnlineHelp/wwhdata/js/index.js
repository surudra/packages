function  WWHBookData_AddIndexEntries(P)
{
var A=P.fA("A",null,null,"002");
var B=A.fA("Asset Publisher",new Array("2#1149144"));
var C=B.fA("configuration",new Array("3"));
C=B.fA("editing assets",new Array("6"));
C=B.fA("editing configuration",new Array("4"));
C=B.fA("Publish screen",new Array("7"));
C=B.fA("screens");
var D=C.fA("Latest Published Metadata",new Array("8"));
D=C.fA("Latest Retracted Assets",new Array("10"));
D=C.fA("Retract",new Array("9"));
C=B.fA("viewing assets",new Array("5"));
A=P.fA("B",null,null,"002");
B=A.fA("bookmark a help topic",new Array("0#38622"));
A=P.fA("C",null,null,"002");
B=A.fA("contents frame, help system",new Array("0#38729"));
A=P.fA("D",null,null,"002");
B=A.fA("Document objects");
C=B.fA("parsing",new Array("1#103615"));
B=A.fA("documents");
C=B.fA("parsing",new Array("1#103615"));
A=P.fA("E",null,null,"002");
B=A.fA("epf files");
C=B.fA("for storing PKI profiles",new Array("1#104327"));
A=P.fA("H",null,null,"002");
B=A.fA("help system");
C=B.fA("contents frame",new Array("0#38729"));
C=B.fA("create bookmark",new Array("0#38622"));
C=B.fA("index frame",new Array("0#38554"));
C=B.fA("navigation frame",new Array("0#38751"));
C=B.fA("search frame",new Array("0#38555"));
C=B.fA("show in contents",new Array("0#38614"));
C=B.fA("show navigation",new Array("0#38610","0#38618"));
C=B.fA("toolbar frame",new Array("0#38578"));
A=P.fA("I",null,null,"002");
B=A.fA("index frame, help system",new Array("0#38554"));
A=P.fA("N",null,null,"002");
B=A.fA("namespace name");
C=B.fA("in universal names",new Array("1#101269","1#101269","1#101269","1#101206"));
B=A.fA("navigation frame, help system",new Array("0#38751","0#38618"));
B=A.fA("node. See XML node");
A=P.fA("P",null,null,"002");
B=A.fA("parsing documents",new Array("1#103615"));
B=A.fA("proxy port");
C=B.fA("on Reverse Invoke Integration Server, definition",new Array("1#105366"));
A=P.fA("R",null,null,"002");
B=A.fA("registration port");
C=B.fA("on Reverse Invoke Integration Server, definition",new Array("1#105366"));
A=P.fA("S",null,null,"002");
B=A.fA("schema browser representation");
C=B.fA("element references",new Array("1#102021"));
B=A.fA("search frame, help system",new Array("0#38555"));
B=A.fA("show help navigation frame",new Array("0#38610","0#38618"));
A=P.fA("T",null,null,"002");
B=A.fA("toolbar frame, help system",new Array("0#38578"));
A=P.fA("U",null,null,"002");
B=A.fA("universal name");
C=B.fA("namespace portion of name",new Array("1#101206"));
A=P.fA("X",null,null,"002");
B=A.fA("XML node, definition");
}

function  WWHBookData_MaxIndexLevel()
{
  return 4;
}
