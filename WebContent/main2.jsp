<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1.0">
	<title> Place Search Service Page</title>

<style>

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

 </style>
 
 <%-- 구글 지도 위치찾기 스크립트 --%>	

	  <script>
      // This example requires the Places library. Include the libraries=places
      // parameter when you first load the API. For example:
      // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">
	
		function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 37.553878, lng: 126.969610},
          zoom: 9
        });
		

        var input = document.getElementById('pac-input');

        var autocomplete = new google.maps.places.Autocomplete(input);

        // Bind the map's bounds (viewport) property to the autocomplete object,
        // so that the autocomplete requests use the current map bounds for the
        // bounds option in the request.
        autocomplete.bindTo('bounds', map);

        autocomplete.addListener('place_changed', function() {

          var place = autocomplete.getPlace();
          if (!place.geometry) {
            // User entered the name of a Place that was not suggested and
            // pressed the Enter key, or the Place Details request failed.
            window.alert("정확한 장소명칭이 아닙니다");
            return;
          }

          // If the place has a geometry, then present it on a map.
          if (place.geometry.viewport) {
            map.fitBounds(place.geometry.viewport);            
          } else {
            map.setCenter(place.geometry.location);
            map.setZoom(17);  // Why 17? Because it looks good.
          }
		  // Googlemap get viewport
		  
		  document.getElementById('center_lat').value = map.getCenter().lat();
		  document.getElementById('center_lng').value = map.getCenter().lng();

        });

      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC3nIysEb9waGit37Yc9lHQFOKvZF-5lE4&libraries=places&callback=initMap"
        async defer>
    </script>

</head>
<body bgcolor="#FFFAF0">
<div>
	<form id = "frm" name = "frm" action="search2.jsp" method="post">
		
	<div id="pac-container"> Current place        				
        <input id="pac-input" type="text" placeholder="Enter a location" name="destination_search" required>
      	<div>
                        
      	<div id="map">
      	</div> 
      					
	<input type="hidden" id="center_lat" name="center_lat" value = "" required> 
	<input type="hidden" id="center_lng" name="center_lng" value = "" required>
					
	<p>
	<input type="submit" name="submit" value ="Search"></input>
	</p>

	</div>
	<div> Select services you need</div>
			</br>
	Food/Beverage availability
	<br>
    <input type="radio" name = "beverage" value=0 checked = "checked"> No 
    <input type="radio" name = "beverage" value=1> Yes
    <input type="radio" name = "beverage" value=-1> No Preference
    <br>
    <br>
    Outlet(콘센트) : 
    <input type="radio" name = "outlet" value=0 checked = "checked"> No
    <input type="radio" name = "outlet" value=1> Yes
    <input type="radio" name = "outlet" value=-1> No Preference
    <br>
    <br>
    Network
    <input type="radio" name = "network" value=0 checked = "checked"> No
    <input type="radio" name = "network" value=1 > Yes
    <input type="radio" name = "network" value=-1> No Preference
    <br>
    <br>
    Type of noise
    <br>
    <input type="radio" name = "silent" value=0 checked = "checked"> Noisy
    <input type="radio" name = "silent" value=1> Ambient noise or soft music
    <input type="radio" name = "silent" value=2> Quiet
    <input type="radio" name = "silent" value=-1> No Preference
    <br>
    <br>
    Type of tables and seats
    <br>
    --Are there partition desks?
    <br>
    <input type="radio" name = "partition" value=0 checked = "checked"> No
    <input type="radio" name = "partition" value=1> Yes
    <input type="radio" name = "partition" value=-1> No Preference
    <br>
    --Are the seats spacious?
    <br>
    <input type="radio" name = "spacious" value=0 checked = "checked"> No
    <input type="radio" name = "spacious" value=1> Yes
    <input type="radio" name = "spacious" value=-1> No Preference
    <br>
    </br>
    Type of lighting
    <br>
    <input type="radio" name = "lighting" value=0 checked = "checked"> Bright
    <input type="radio" name = "lighting" value=1> Normal
    <input type="radio" name = "lighting" value=2> Dim
    <input type="radio" name = "lighting" value=-1> No Preference
    <br>
    </br>
    Type of scenery
    <br>
    <input type="radio" name = "scenery" value=0 checked = "checked"> Nature View
    <input type="radio" name = "scenery" value=1> Ocean View
    <input type="radio" name = "scenery" value=2> No view
    <br>
    <input type="radio" name = "scenery" value=-1> No Preference
    <br>
    </br>
	
	</form>
</div>
</body>
</html>