DECLARE
    CURSOR item_cursor IS
    SELECT
        LD.LOOKUP_DET_NAME AS PRODUCT_CATEGORY,
        IM.ITEM_NAME,
        IM.UNIT AS UNIT,
        IM.PACKING_SIZE AS PACKING_SIZE
    FROM AB_ITEMS_MASTER IM
        JOIN AB_LOOKUP_DETAIL LD ON LD.DET_ID = IM.PRODUCT_CATEGORY_ID
    ORDER BY LD.LOOKUP_DET_NAME, IM.ITEM_NAME;

BEGIN
    htp.p('<!DOCTYPE html><html><head><title>Item Report</title></head>');
    htp.p('<style>
    @page {
      size: A4; /* Set the page size to A4 */
      margin: 10mm; /* Set page margins to reduce extra space */
    }
    body {
      margin: 0; /* Remove default margins */
      padding: 0;
      font-family: Arial, sans-serif;
    }
    .button {
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      border: none;
      cursor: pointer;
    }
    .button1 {
      font-size: 16px;
    }
    table {
      border-collapse: collapse;
      width: 100%;
      margin: 0; /* Remove margin around the table */
      padding: 0; /* Remove padding inside the table */
    }
    th, td {
      text-align: left; /* Align text to the left for better readability */
      padding: 3px; /* Reduce padding for tighter rows */
      font-size: 10px; /* Set font size for data to 10px */
      line-height: 1.1; /* Reduce line height to decrease row spacing */
    }
    th {
      border-bottom: 1px solid black; /* Simplify the row line by reducing the thickness */
      font-size: 10px; /* Set font size for headers to 10px */
      position: relative; /* Required for pseudo-elements */
    }
    th.conversion-header, td.conversion-data {
      text-align: right; /* Align header and data to the right */
    }
    th.unit-header, td.unit-column {
      text-align: right; /* Align UNIT header and data to the right */
    }
    td.product-cell {
      vertical-align: top; /* Align text to the top of the cell */
      padding-right: 10px; /* Adjust padding for PRODUCT column */
      border-right: none; /* Remove the right border */
      white-space: nowrap; /* Prevent text from wrapping */
    }
    td.item-name-column {
      padding-left: 5px; /* Adjust padding for ITEM NAME column */
      white-space: nowrap; /* Prevent text from wrapping */
      overflow: hidden; /* Hide overflowed content */
      text-overflow: ellipsis; /* Add ellipsis if text overflows */
    }
    td.unit-column {
      text-align: right; /* Align text to the right */
      padding-right: 5px; /* Adjust right padding */
    }
    .separator {
      border-top: 1px solid black; /* Simplify the separator line */
    }
    @media print {
      thead {display: table-header-group;}
      tfoot {display: table-footer-group;}
    }
    h2 {
      font-size: 20px; /* Increase font size */
      white-space: nowrap; /* Prevents line breaks */
      overflow: hidden; /* Hides overflowed content */
      text-overflow: ellipsis; /* Adds ellipsis if text overflows */
      margin: 0; /* Remove margin above and below h2 headings */
      padding: 0;
      text-align: center; /* Center-align text */
    }
    #div_print1 {
      margin: 0; /* Ensure no extra margin around the container */
      padding: 0;
    }
  </style>');

    htp.p('<script>
    function adjustColumnWidth() {
      var table = document.querySelector("table");
      var itemNameColumnIndex = 1; // Index for ITEM NAME column
      var maxWidth = 0;
      var rows = table.querySelectorAll("tbody tr");
      
      rows.forEach(function(row) {
        var itemNameCell = row.cells[itemNameColumnIndex];
        if (itemNameCell) {
          var cellWidth = itemNameCell.scrollWidth;
          if (cellWidth > maxWidth) {
            maxWidth = cellWidth;
          }
        }
      });
      
      var header = table.querySelector("thead th.item-name-column");
      if (header) {
        header.style.width = maxWidth + "px";
      }
      
      var dataCells = table.querySelectorAll("tbody td.item-name-column");
      dataCells.forEach(function(cell) {
        cell.style.width = maxWidth + "px";
      });
    }
   
    function printDiv(printpage) {
      adjustColumnWidth();
      var headstr = "<html><head><title></title><style>";
      headstr += "@page { size: A4; margin: 10mm; }";
      headstr += "body { margin: 0; padding: 0; font-family: Arial, sans-serif; }";
      headstr += ".button { padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }";
      headstr += ".button1 { font-size: 16px; }";
      headstr += "table { border-collapse: collapse; width: 100%; margin: 0; padding: 0; }";
      headstr += "th, td { text-align: left; padding: 3px; font-size: 10px; line-height: 1.1; }";
      headstr += "th { border-bottom: 1px solid black; }";
      headstr += "th.conversion-header, td.conversion-data { text-align: right; }";
      headstr += "th.unit-header, td.unit-column { text-align: right; }";
      headstr += "td.product-cell { vertical-align: top; padding-right: 10px; border-right: none; white-space: nowrap; }";
      headstr += "td.item-name-column { padding-left: 5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }";
      headstr += "td.unit-column { text-align: right; padding-right: 5px; }";
      headstr += ".separator { border-top: 1px solid black; }";
      headstr += "@media print { thead {display: table-header-group;} tfoot {display: table-footer-group;} }";
      headstr += "h2 { font-size: 20px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; margin: 0; padding: 0; text-align: center; }";
      headstr += "#div_print1 { margin: 0; padding: 0; }";
      headstr += "</style></head><body>";
      var footstr = "</body></html>";
      var newstr = document.getElementById(printpage).innerHTML;
      var oldstr = document.body.innerHTML;
      document.body.innerHTML = headstr + newstr + footstr;
      window.print();
      document.body.innerHTML = oldstr;
      return false;
    }
  </script></head><body>');

  

  htp.p('<button class="button button1 t-Icon t-Icon--right fa fa-print" id="print" type="button" onclick="printDiv(''div_print1'')">Print</button>');
  htp.p('<div id="div_print1" style="margin: 0; padding: 0;">');
  htp.p('<center><h2>AKBAR BROTHERS GROUP OF COMPANIES NEAR BC CHOWK</h2></center>');
  htp.p('<center><h2>Item Report</h2></center>');
  htp.p('<table>
    <thead>
      <tr>
        <th style="width: 10%;">Product</th>
        <th class="item-name-column">Item Name</th>
        <th class="unit-header" style="width: 15%;">Unit</th>
        <th class="conversion-header" style="width: 15%;">Conversion</th>
      </tr>
    </thead>
    <tbody>');

    DECLARE
        v_last_category VARCHAR2(100) := NULL;
        v_show_category BOOLEAN := TRUE;
    BEGIN
        FOR item_rec IN item_cursor LOOP
            -- Check if the product category has changed
            IF v_last_category IS NULL OR v_last_category != item_rec.PRODUCT_CATEGORY THEN
                -- Add separator line for the previous group
                IF v_last_category IS NOT NULL THEN
                    htp.p('<tr><td colspan="4" class="separator"></td></tr>');
                END IF;

                v_last_category := item_rec.PRODUCT_CATEGORY;
                v_show_category := TRUE; -- Show category for the first row of the group
            ELSE
                v_show_category := FALSE; -- Skip category for subsequent rows in the group
            END IF;

            -- Display item details
            HTP.P('<tr>');
            IF v_show_category THEN
                HTP.P('<td>' || v_last_category || '</td>'); -- Display product name once
            ELSE
                HTP.P('<td></td>'); -- Leave empty for subsequent rows
            END IF;
            HTP.P('<td>' || item_rec.ITEM_NAME || '</td>');
            HTP.P('<td class="unit-column">' || item_rec.UNIT || '</td>');
            HTP.P('<td class="conversion-data"">' || item_rec.PACKING_SIZE || '</td>');
            HTP.P('</tr>');
        END LOOP;

        -- Add a final separator line for the last category
        IF v_last_category IS NOT NULL THEN
            HTP.P('<tr><td colspan="4" class="separator"></td></tr>');
        END IF;
    END;

    htp.p('</tbody></table></body></html>');
END;
