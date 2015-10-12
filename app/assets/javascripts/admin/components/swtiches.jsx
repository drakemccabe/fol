
var Controller = React.createClass({
  getInitialState: function(){
    return {
      data : null
    }
  },


  getDefaultProps: function () {
    return { feature: 1 };
  },

  // componentWillMount: function () {
  //   $.get("//api.fol.dev/contacts", function (contacts) {
  //     this.setState(contacts);
  //   }.bind(this));
  // },

  flipSwitch: function() {
    switch (this.props.feature) {
      case 1:
        return <Registration />
      case 2:
        console.log(this.props.contact);
        return <Registration2 />
    }
  },

  render: function() {


  return (
    <div>
      {this.flipSwitch()}
    </div>
  )
}
})

$( "#link3" ).click(function() {
  event.preventDefault();
  clearDiv();
  React.render(
    <Controller feature={1}/>,
    document.getElementById('table')
  )
});

$( "#link4" ).click(function() {
  event.preventDefault();
  clearDiv();
  React.render(
    <Controller feature={2}/>,
    document.getElementById('table')
  )
});

function clearDiv() {
  React.unmountComponentAtNode(table)
  };
