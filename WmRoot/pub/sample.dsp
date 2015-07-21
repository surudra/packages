
%value a%
%value b%


%invoke myDB:something%

  %value dbXXX%
  %value dbYYY%

  %value ../a%
  %value /a%

  <table>
  %loop table%
  <tr><td>%value day%</td><td>%value week%</td></tr>
  %endloop%
  </table>

  %scope myrecord%
  %endscope%

  <a href="sample.dsp?fred=%value fred%&foo=xxx">blah</a>

%endinvoke%

