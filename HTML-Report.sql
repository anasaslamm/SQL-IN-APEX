-- This is simple table that is build in PL/SQL and using HTML to make table(Report) written in HTML used in PL/SQL

htp.p('<html>
    <head>
        <style>

            table, th, td{
            border: 1px solid black;
            border-collapse: collapse;
            margin: 0px;
            }
            td {
                padding-left: 2px;
               
             }
        </style>

        </head>
        <body>
            <center><h2>My First Reports</h2></center>
            <table border="1" style= "font-size: 13px; width:100%; /*text-align: center; */border-collapse: collapse">
                <th>APEX_ID</th>
                <th>APEX_NAME</th>
                <th>APEX_DATE</th>
                <th>JAPEX_DESC</th>
                <th>APEX_VERSION</th>
                 <th>START_DATE</th>
                 <th>END_DATE</th>');
                 declare
                 cursor cur_name is 
                 select apex_id , apex_name, apex_date, apex_desc , apex_version , start_date,
                  end_date from oracleapex order by apex_id;
                  begin
                 for x in cur_name loop
                 htp.p('<tr>
                     <td>'|| x.apex_id ||'</td>
                     <td>'|| x.apex_name ||'</td>
                     <td>'|| x.apex_date ||'</td>
                     <td>'|| x.apex_desc ||'</td>
                     <td>'|| x.apex_version ||'</td>
                     <td>'|| x.start_date ||'</td>
                     <td>'|| x.end_date  ||'</td>  </tr>');
                 
              end loop;
              end;
                htp.p('</table>');
           htp.p('</body>');

    htp.p('</html>');
