import React from 'react';
import {Gmaps, Marker, InfoWindow, Circle} from 'react-gmaps';

const coords = {
  lat: 42.018989,
  lng: -71.007821
};

const App = React.createClass({

  onMapCreated(map) {
    map.setOptions({
      disableDefaultUI: true
    });
  },

  onDragEnd(e) {
    console.log('onDragEnd', e);
  },

  onCloseClick() {
    console.log('onCloseClick');
  },

  onClick(e) {
    console.log('onClick', e);
  },

  render() {
    return (
      <Gmaps
        width={'800px'}
        height={'600px'}
        lat={coords.lat}
        lng={coords.lng}
        zoom={14}
        loadingMessage={'Loading'}
        onMapCreated={this.onMapCreated}>
        <Marker
          lat={coords.lat}
          lng={coords.lng}
          draggable={true}
          onDragEnd={this.onDragEnd} />
        <InfoWindow
          lat={coords.lat}
          lng={coords.lng}
          content={'West Bridgewater'}
          onCloseClick={this.onCloseClick} />
          <Marker
            lat={42.036369}
            lng={-71.016838}
            draggable={true}
            onDragEnd={this.onDragEnd} />
      </Gmaps>
    );
  }

});

function Run() {
  React.render(<App />, document.getElementById('table'));
};

function clearDiv() {
  React.unmountComponentAtNode(table)
  };

$( "#link1" ).click(function() {
  event.preventDefault();
  clearDiv();
  Run();
});
