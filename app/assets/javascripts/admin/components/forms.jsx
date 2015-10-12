
function newContactForm() {
  React.render(
    <div className="hidden">
    <Registration />
    </div>,
    document.getElementById('table')
  )
}

$( "#link5" ).click(function() {
  event.preventDefault();
  clearDiv();
  newContactForm();
});

function clearDiv() {
  React.unmountComponentAtNode(table)
  };




var fieldValues = {
  first_name     : null,
  email    : null,
  phone    : null,
  last_name : null,
  address   : null,
  city      : null,
  state     : null,
  zipcode   : null,
  amount    : null,
  interest  : null,
  note      : null
}

var Registration = React.createClass({
  getInitialState: function() {
    return {
      step : 1
    }
  },

  saveValues: function(field_value) {
    return function() {
      fieldValues = Object.assign({}, fieldValues, field_value)
    }.bind(this)()
  },

  nextStep: function() {
    this.setState({
      step : this.state.step + 1
    })
  },

  previousStep: function() {
    this.setState({
      step : this.state.step - 1
    })
  },

  submitRegistration: function() {
  console.log(fieldValues);

    this.nextStep()
  },


  submitDetails: function() {
  alert("taco")

    this.nextStep()
  },

  showStep: function() {
    switch (this.state.step) {
      case 1:
        return <AccountFields fieldValues={fieldValues}
                              nextStep={this.nextStep}
                              previousStep={this.previousStep}
                              saveValues={this.saveValues} />
      case 2:
        return <AddressFields fieldValues={fieldValues}
                             nextStep={this.nextStep}
                             previousStep={this.previousStep}
                             saveValues={this.saveValues} />
      case 3:
        return <Confirmation fieldValues={fieldValues}
                             previousStep={this.previousStep}
                             submitRegistration={this.submitRegistration} />

       case 4:
         return <DataFields fieldValues={fieldValues}
                              nextStep={this.nextStep}
                              previousStep={this.previousStep}
                              saveValues={this.saveValues} />

        case 5:
          return <Confirmation2 fieldValues={fieldValues}
                                previousStep={this.previousStep}
                                submitRegistration={this.submitDetails} />
      case 6:
        return <Success fieldValues={fieldValues} />
    }
  },

  render: function() {
    var style = {
      width : (this.state.step / 5 * 100) + '%'
    }

    return (
      <main>
        <span className="progress-step">Step {this.state.step} </span>
        <progress className="progress" style={style}></progress>
        {this.showStep()}
      </main>
    )
  }
})

var AccountFields = React.createClass({
  render: function() {
    return (
      <div>
        <h3>Add Contact Info</h3>
        <ul className="form-fields">
          <li>
            <label>First Name</label>
            <input type="text" ref="first_name" defaultValue={this.props.fieldValues.first_name} />
          </li>
          <li>
            <label>Last Name</label>
            <input type="text" ref="last_name" defaultValue={this.props.fieldValues.last_name} />
          </li>
          <li>
            <label>Email</label>
            <input type="email" ref="email" defaultValue={this.props.fieldValues.email} />
          </li>
          <li>
            <label>Phone</label>
            <input type="text" ref="phone" defaultValue={this.props.fieldValues.phone} />
          </li>
          <li className="form-footer">
            <button className="btn -primary pull-right" onClick={this.nextStep}>Save &amp; Continue</button>
          </li>
        </ul>
      </div>
    )
  },

  nextStep: function(e) {
    e.preventDefault()

    // Get values via this.refs
    var data = {
      first_name     : this.refs.first_name.getDOMNode().value,
      last_name : this.refs.last_name.getDOMNode().value,
      email    : this.refs.email.getDOMNode().value,
      phone    : this.refs.phone.getDOMNode().value,
    }

    this.props.saveValues(data)
    this.props.nextStep()
  }
})

var Confirmation = React.createClass({
  render: function() {
    return (
      <div>
        <h2>Confirm Registration</h2>
        <ul>
          <li><b>First Name:</b> {this.props.fieldValues.first_name}</li>
          <li><b>Last Name:</b> {this.props.fieldValues.last_name}</li>
          <li><b>Phone:</b> {this.props.fieldValues.phone}</li>
          <li><b>Email:</b> {this.props.fieldValues.email}</li>
          <li><b>Address:</b> {this.props.fieldValues.address}</li>
          <li><b>City:</b> {this.props.fieldValues.city}</li>
          <li><b>State:</b> {this.props.fieldValues.state}</li>
          <li><b>Zip:</b> {this.props.fieldValues.zip}</li>
        </ul>
        <ul className="form-fields">
          <li className="form-footer">
            <button className="btn -default pull-left" onClick={this.props.previousStep}>Back</button>
            <button className="btn -primary pull-right" onClick={this.props.submitRegistration}>Add Contact</button>
          </li>
        </ul>
      </div>
    )
  }
})


var Success = React.createClass({
  render: function() {
    return (
      <div>
        <h2>Successfully Registered!</h2>
        <p>Please check your email <b>{this.props.fieldValues.email}</b> for a confirmation link to activate your account.</p>
      </div>
    )
  }
})


var AddressFields = React.createClass({
  render: function() {
    return (
      <div>
        <h3>Add Address Info</h3>
        <ul className="form-fields">
          <li>
            <label>Address</label>
            <input type="text" ref="address" defaultValue={this.props.fieldValues.address} />
          </li>
          <li>
            <label>City</label>
            <input type="text" ref="city" defaultValue={this.props.fieldValues.city} />
          </li>
          <li>
            <label>State</label>
            <input type="text" ref="state" defaultValue={this.props.fieldValues.state} />
          </li>
          <li>
            <label>Zipcode</label>
            <input type="text" ref="zip" defaultValue={this.props.fieldValues.zip} />
          </li>
          <li className="form-footer">
            <button className="btn -default pull-left" onClick={this.props.previousStep}>Back</button>
            <button className="btn -primary pull-right" onClick={this.nextStep}>Save &amp; Continue</button>
          </li>
        </ul>
      </div>
    )
  },

  nextStep: function(e) {
    e.preventDefault()

    // Get values via this.refs
    var data = {
      address     : this.refs.address.getDOMNode().value,
      city : this.refs.city.getDOMNode().value,
      state    : this.refs.state.getDOMNode().value,
      zip    : this.refs.zip.getDOMNode().value,
    }

    this.props.saveValues(data)
    this.props.nextStep()
  }
})



var DataFields = React.createClass({
  render: function() {
    return (
      <div>
        <h3>Add Details to {this.props.fieldValues.first_name}'s Account.</h3>
        <ul className="form-fields">
          <li>
            <label>Donation</label>
            <input type="number" ref="amount" defaultValue={this.props.fieldValues.amount} />
          </li>
          <li>
            <label>Interest</label>
            <input type="text" ref="interest" defaultValue={this.props.fieldValues.interest} />
          </li>
          <li>
            <label>Note</label>
            <input type="text" ref="note" defaultValue={this.props.fieldValues.note} />
          </li>
          <li className="form-footer">
            <button className="btn -default pull-left" onClick={this.props.previousStep}>Back</button>
            <button className="btn -primary pull-right" onClick={this.nextStep}>Save &amp; Continue</button>
          </li>
        </ul>
      </div>
    )
  },

  nextStep: function(e) {
    e.preventDefault()

    // Get values via this.refs
    var data = {
      amount     : this.refs.amount.getDOMNode().value,
      interest : this.refs.interest.getDOMNode().value,
      note    : this.refs.note.getDOMNode().value,
    }

    this.props.saveValues(data)
    this.props.nextStep()
  }
})


var Confirmation2 = React.createClass({
  render: function() {
    return (
      <div>
        <h2>Confirm Details for {this.props.fieldValues.first_name} {this.props.fieldValues.last_name}'s Account.'</h2>
        <ul>
          <li><b>Donation:</b> {this.props.fieldValues.amount}</li>
          <li><b>Interest:</b> {this.props.fieldValues.interest}</li>
          <li><b>Note:</b> {this.props.fieldValues.note}</li>
        </ul>
        <ul className="form-fields">
          <li className="form-footer">
            <button className="btn -default pull-left" onClick={this.props.previousStep}>Back</button>
            <button className="btn -primary pull-right" onClick={this.props.submitRegistration}>Submit Registration</button>
          </li>
        </ul>
      </div>
    )
  }
})

var Registration2 = React.createClass({
  getInitialState: function() {
    return {
      step : 3
    }
  },

  saveValues: function(field_value) {
    return function() {
      fieldValues = Object.assign({}, fieldValues, field_value)
    }.bind(this)()
  },

  nextStep: function() {
    this.setState({
      step : this.state.step + 1
    })
  },

  previousStep: function() {
    this.setState({
      step : this.state.step - 1
    })
  },

  submitRegistration: function() {
  console.log(fieldValues);

    this.nextStep()
  },


  submitDetails: function() {
  alert("taco")

    this.nextStep()
  },

  showStep: function() {
    switch (this.state.step) {
      case 1:
        return <AccountFields fieldValues={fieldValues}
                              nextStep={this.nextStep}
                              previousStep={this.previousStep}
                              saveValues={this.saveValues} />
      case 2:
        return <AddressFields fieldValues={fieldValues}
                             nextStep={this.nextStep}
                             previousStep={this.previousStep}
                             saveValues={this.saveValues} />
      case 3:
        return <Confirmation fieldValues={fieldValues}
                             previousStep={this.previousStep}
                             submitRegistration={this.submitRegistration} />

       case 4:
         return <DataFields fieldValues={fieldValues}
                              nextStep={this.nextStep}
                              previousStep={this.previousStep}
                              saveValues={this.saveValues} />

        case 5:
          return <Confirmation2 fieldValues={fieldValues}
                                previousStep={this.previousStep}
                                submitRegistration={this.submitDetails} />
      case 6:
        return <Success fieldValues={fieldValues} />
    }
  },

  render: function() {
    var style = {
      width : (this.state.step / 5 * 100) + '%'
    }

    return (
      <main>
        <span className="progress-step">Step {this.state.step} </span>
        <progress className="progress" style={style}></progress>
        {this.showStep()}
      </main>
    )
  }
})
