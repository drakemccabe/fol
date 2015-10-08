var React = require('react');
var FixedDataTable = require('fixed-data-table');

var Table = FixedDataTable.Table;
var Column = FixedDataTable.Column;

// Table data as a list of array.
var rows = "";

    $.ajax({
      url: "//api.fol.dev/contacts",
      dataType: 'json',
      cache: true,
      success: function(data) {
        rowsFunction(data)
      }
    });

    function rowsFunction(data) {
      rows = data["contacts"];
      console.log(rows);
      React.render(
        <Table
          rowHeight={50}
          rowGetter={rowGetter}
          rowsCount={rows.length}
          width={1000}
          height={500}
          headerHeight={50}>
          <Column
            label="Col 1"
            width={300}
            dataKey="first_name"
          />
          <Column
            label="Col 2"
            width={300}
            dataKey="last_name"
          />
          <Column
            label="Col 3"
            width={300}
            dataKey="address"
          />
        </Table>,
        document.getElementById('table')
      );
    }


function rowGetter(rowIndex) {
  return rows[rowIndex];
}
