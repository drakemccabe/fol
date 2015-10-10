var React = require('react');
var Griddle = require('griddle-react');
var rows = "";
var contact;

function contacts() {
$.ajax({
      url: "//api.fol.dev/contacts",
      dataType: 'json',
      cache: true,
      success: function(data) {
        rowsFunction(data)
      }
    });
  };

    function rowsFunction(data) {
      rows = data["contacts"];

      React.render(
      <Griddle results={rows} tableClassName="table" showFilter={true}
 showSettings={true} columns={["id", "first_name", "last_name", "address", "city"]}
resultsPerPage={5} enableInfiniteScroll={true} bodyHeight={600} useFixedHeader={true} onRowClick={editContact}
 />,
      document.getElementById('table')
      )
    }


function editContact(event, row) {
  contact = row
}

$( "#link2" ).click(function() {
  event.preventDefault();
  clearDiv();
  contacts();
});

function clearDiv() {
  React.unmountComponentAtNode(table)
  };
