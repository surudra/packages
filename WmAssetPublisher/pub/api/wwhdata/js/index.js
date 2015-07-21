function  WWHBookData_AddIndexEntries(P)
{
var A=P.fA("A",null,null,"002");
var B=A.fA("Assets services",new Array("1"));
A=P.fA("B",null,null,"002");
B=A.fA("bookmark a help topic",new Array("0#38826"));
A=P.fA("C",null,null,"002");
B=A.fA("contents frame, help system",new Array("0#38729"));
A=P.fA("D",null,null,"002");
B=A.fA("Developer");
var C=B.fA("documentation",new Array("0#39119"));
B=A.fA("documentation");
C=B.fA("for webMethods Developer",new Array("0#39119"));
A=P.fA("H",null,null,"002");
B=A.fA("help system");
C=B.fA("contents frame",new Array("0#38729"));
C=B.fA("create bookmark",new Array("0#38826"));
C=B.fA("index frame",new Array("0#38554"));
C=B.fA("navigation frame",new Array("0#38837"));
C=B.fA("search frame",new Array("0#38555"));
C=B.fA("show in contents",new Array("0#38810"));
C=B.fA("show navigation",new Array("0#38802","0#38818"));
C=B.fA("toolbar frame",new Array("0#38578"));
C=B.fA("webMethods documentation",new Array("0#39119"));
A=P.fA("I",null,null,"002");
B=A.fA("index frame, help system",new Array("0#38554"));
A=P.fA("N",null,null,"002");
B=A.fA("navigation");
C=B.fA("in help system",new Array("0#38837"));
B=A.fA("navigation frame, help system",new Array("0#38818"));
A=P.fA("P",null,null,"002");
B=A.fA("pub.asset");
C=B.fA("publish",new Array("3"));
B=A.fA("publish",new Array("3"));
A=P.fA("S",null,null,"002");
B=A.fA("search frame, help system",new Array("0#38555"));
B=A.fA("show help navigation frame",new Array("0#38802","0#38818"));
A=P.fA("T",null,null,"002");
B=A.fA("toolbar frame, help system",new Array("0#38578"));
A=P.fA("W",null,null,"002");
B=A.fA("webMethods products");
C=B.fA("documentation",new Array("0#39119"));
}

function  WWHBookData_MaxIndexLevel()
{
  return 3;
}
