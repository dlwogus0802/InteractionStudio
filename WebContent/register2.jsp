<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Place Autocomplete</title>
    <meta name = "viewport" content="width-device-width", initial-sclae = "1">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="css/bootstrap.css">
    <meta charset="utf-8">
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 80%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #description {
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
      }

      #infowindow-content .title {
        font-weight: bold;
      }

      #infowindow-content {
        display: none;
      }

      #map #infowindow-content {
        display: inline;
      }

      .pac-card {
        margin: 10px 10px 0 0;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
        background-color: #fff;
        font-family: Roboto;
      }

      #pac-container {
        padding-bottom: 12px;
        margin-right: 12px;
      }

      .pac-controls {
        display: inline-block;
        padding: 5px 11px;
      }

      .pac-controls label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
      }

      #pac-input {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 400px;
      }

      #pac-input:focus {
        border-color: #4d90fe;
      }

      #title {
        color: #fff;
        background-color: #4d90fe;
        font-size: 25px;
        font-weight: 500;
        padding: 6px 12px;
      }
    </style>
    
    
    
    <script>
      // This example requires the Places library. Include the libraries=places
      // parameter when you first load the API. For example:
      // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">
      

      function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 37.5546788, lng: 126.9706069},
          zoom: 15
        });
        var card = document.getElementById('pac-card');
        var input = document.getElementById('pac-input');
        var types = document.getElementById('type-selector');
        var strictBounds = document.getElementById('strict-bounds-selector');

        map.controls[google.maps.ControlPosition.TOP_RIGHT].push(card);

        var autocomplete = new google.maps.places.Autocomplete(input);

        // Bind the map's bounds (viewport) property to the autocomplete object,
        // so that the autocomplete requests use the current map bounds for the
        // bounds option in the request.
        autocomplete.bindTo('bounds', map);

        // Set the data fields to return when the user selects a place.
        autocomplete.setFields(
            ['address_components', 'geometry', 'icon', 'name']);

        var infowindow = new google.maps.InfoWindow();
        var infowindowContent = document.getElementById('infowindow-content');
        infowindow.setContent(infowindowContent);
        var marker = new google.maps.Marker({
          map: map,
          anchorPoint: new google.maps.Point(0, -29)
        });

        autocomplete.addListener('place_changed', function() {
          infowindow.close();
          marker.setVisible(false);
          var place = autocomplete.getPlace();
          if (!place.geometry) {
            // User entered the name of a Place that was not suggested and
            // pressed the Enter key, or the Place Details request failed.
            window.alert("No details available for input: '" + place.name + "'");
            return;
          }

          // If the place has a geometry, then present it on a map.
          if (place.geometry.viewport) {
            map.fitBounds(place.geometry.viewport);
          } else {
            map.setCenter(place.geometry.location);
            map.setZoom(17);  // Why 17? Because it looks good.
          }
          marker.setPosition(place.geometry.location);
          marker.setVisible(true);

		document.getElementById('latclick').value = marker.getPosition().lat();
		document.getElementById('lngclick').value = marker.getPosition().lng();

          var address = '';
          if (place.address_components) {
            address = [
              (place.address_components[0] && place.address_components[0].short_name || ''),
              (place.address_components[1] && place.address_components[1].short_name || ''),
              (place.address_components[2] && place.address_components[2].short_name || '')
            ].join(' ');
          }
          
		document.getElementById('address').value = address;
		document.getElementById('place_name').value = place.name;
        	  
          infowindowContent.children['place-icon'].src = place.icon;
          infowindowContent.children['place-name'].textContent = place.name;
          infowindowContent.children['place-address'].textContent = address;
          infowindow.open(map, marker);
        });

        // Sets a listener on a radio button to change the filter type on Places
        // Autocomplete.
        function setupClickListener(id, types) {
          var radioButton = document.getElementById(id);
          radioButton.addEventListener('click', function() {
            autocomplete.setTypes(types);
          });
        }

        setupClickListener('changetype-all', []);
        setupClickListener('changetype-address', ['address']);
        setupClickListener('changetype-establishment', ['establishment']);
        setupClickListener('changetype-geocode', ['geocode']);

        document.getElementById('use-strict-bounds')
            .addEventListener('click', function() {
              console.log('Checkbox clicked! New state=' + this.checked);
              autocomplete.setOptions({strictBounds: this.checked});
            });
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC3nIysEb9waGit37Yc9lHQFOKvZF-5lE4&libraries=places&callback=initMap"
        defer></script>
    
    
  </head>
  <body bgcolor="#FFFAF0">
  	
    <div class="pac-card" id="pac-card">
      <div>
        <div id="title">
          Autocomplete search
        </div>
        <div id="type-selector" class="pac-controls">
          <input type="radio" name="type" id="changetype-all" checked="checked">
          <label for="changetype-all">All</label>

          <input type="radio" name="type" id="changetype-establishment">
          <label for="changetype-establishment">Establishments</label>

          <input type="radio" name="type" id="changetype-address">
          <label for="changetype-address">Addresses</label>

          <input type="radio" name="type" id="changetype-geocode">
          <label for="changetype-geocode">Geocodes</label>
        </div>
        <div id="strict-bounds-selector" class="pac-controls">
          <input type="checkbox" id="use-strict-bounds" value="">
          <label for="use-strict-bounds">Strict Bounds</label>
        </div>
      </div>
      <div id="pac-container">
        <input id="pac-input" type="text"
            placeholder="Enter a location">
      </div>
    </div>
    <div id="map"></div>
    <div id="infowindow-content">
      <img src="" width="16" height="16" id="place-icon">
      <span id="place-name"  class="title"></span><br>
      <span id="place-address"></span>
    </div>

        
    <div>
    <form id="frm" name="frm" action="write.jsp" method="post">
	
Latitude<input type="text" id="latclick" name="latclick" value="37.55594599999999">
<br>
	longitude<input type="text" id="lngclick" name="lngclick" value="126.972317">
	<br>
	address<input type="text" id="address" name="paddress" value="２ 세종대로18길 소공동">
	<br>
	place<input type="text" id="place_name" name="pname" value="서울역">
	<br>
	<br>
	</br>
	Food/Beverage availability
    <input type="radio" class = "btn-check" name = "beverage" value=0 checked = "checked"> 
    <label class = "btn btn-outlline-success" for="beverage">Nope</label> 
    <input type="radio" name = "beverage" value=1> Yes
    <br>
    <br>
    Outlet(콘센트) : 
    <input type="radio" name = "outlet" value=0 checked = "checked"> No
    <input type="radio" name = "outlet" value=1> Yes
    <br>
    <br>
    Network
    <input type="radio" name = "network" value=0 checked = "checked"> No
    <input type="radio" name = "network" value=1 > Yes
    <br>
    <br>
    Type of noise <br>
    <input type="radio" name = "silent" value=0 checked = "checked"> Noisy
    <input type="radio" name = "silent" value=1> Ambient noise or soft music
    <input type="radio" name = "silent" value=2> Quiet
    <br>
    <br>
    Type of tables and seats
    <br>
    --Are there partition desks?
    <input type="radio" name = "partition" value=0 checked = "checked"> No
    <input type="radio" name = "partition" value=1> Yes
    <br>
    --Are the seats spacious?
    <input type="radio" name = "spacious" value=0 checked = "checked"> No
    <input type="radio" name = "spacious" value=1> Yes
    <br>
    </br>
    Type of lighting
    <br>
    <input type="radio" name = "lighting" value=0 checked = "checked"> Bright
    <input type="radio" name = "lighting" value=1> Normal
    <input type="radio" name = "lighting" value=2> Dim
    <br>
    </br>
    Type of scenery
    <br>
    <input type="radio" name = "scenery" value=0 checked = "checked"> Nature View
    <input type="radio" name = "scenery" value=1> Ocean View
    <input type="radio" name = "scenery" value=2> No view
    <br>
    </br>
    Operating Time
    <input type="time" name="startTime" value = "09:00">
    -
    <input type="time" name="endTime" value = "20:00">
    <br>
    <input type="submit" value = "Register">
	</form>
    </div>    
  </body>
</html>