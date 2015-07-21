<HTML>
<BODY>

%!

int foo = 0;

%

                  %ifvar foo%
                  <p>Temp Exist%value Temp%</p>
                   %endif%
%invoke acmeSupport.xml:xmlAdd%


<A HREF=/Acme/second.dsp>Show Orders</A>
</BODY>
</HTML>