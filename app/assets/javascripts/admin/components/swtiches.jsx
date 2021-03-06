var Controller = React.createClass({
  getInitialState: function(){
    return {
      data : null
    }
  },

  getDefaultProps: function () {
    return { feature: 1 };
  },

  flipSwitch: function() {
    switch (this.props.feature) {
      case 1:
        return <Registration />
      case 2:
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
    <div>
    <Controller feature={1}/>
    </div>,
    document.getElementById('table')
  )
});

$( "#link40" ).click(function() {
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
