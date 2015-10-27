import React from 'react'; import {Gmaps, Marker, InfoWindow, Circle} from 'react-gmaps';

const coords = {
  lat: 42.018989,
  lng: -71.007821
};

var markers = "";
$authkey = $('#tokendiv').attr('data-idtoken');

function loadMapData() {
$.ajax({
      type: "GET",
      beforeSend: function (request)
      {
        request.setRequestHeader("authorization", $authkey);
      },
      url: "/contacts",
      dataType: 'json',
      cache: true,
      success: function(data) {
        markersFunction(data)
      }
    });
  };

function markersFunction(data) {
  markers = data["contacts"];
  Run();
}


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
        zoom={10}
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

            {markers.map(function(object, i){
                return <Marker lat={markers[i]["latitude"]} lng={markers[i]["longitude"]} />;
              })}

            {markers.map(function(object, i){
                return <InfoWindow lat={markers[i]["latitude"]} lng={markers[i]["longitude"]} content={markers[i]["first_name"]} />;
              })}

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
  loadMapData();
});
