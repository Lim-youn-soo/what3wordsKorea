<!-- #include virtual="/_include/connect.inc" -->
  <%

    Server.ScriptTimeout=3600

    if request("search_lat") <> "" then
      search_lat = request("search_lat")
    else
      search_lat = "0"
    end if

    if request("search_lon") <> "" then
      search_lon = request("search_lon")
    else
      search_lon = "0"
    end if

    search_word = request("search_word")

    if request("lat_value") <> "" then
      lat_value = request("lat_value")
    else
      lat_value = 37.946976
    end if

    if request("lon_value") <> "" then
      lon_value = request("lon_value")
    else
      lon_value = 127.670702
    end if

    if request("lat1") <> "" then
      lat1 = request("lat1")
    else
      lat1 = "32.910549"
    end if

    if request("lon1") <> "" then
      lon1 = request("lon1")
    else
      lon1 = "123.715624"
    end if

    if request("lat2") <> "" then
      lat2 = request("lat2")
    else
      lat2 = "42.983403"
    end if

    if request("lon2") <> "" then
      lon2 = request("lon2")
    else
      lon2 = "131.625780"
    end if
      
    if request("pos_words") <> "" then
      pos_words = request("pos_words")
    else
      pos_words = "Korea"
    end if

    if request("zoom_level") <> "" then
      zoom_level = request("zoom_level")
    else
      zoom_level = 6
    end if

      


    'strSQL = "p_gmap_wordgrid_read  '" & search_lat & "','" & search_lon & "'" 
    strSQL = "p_gmap_wordgrid_read_lat  '" & search_lat & "','" & search_lon & "'" 

    '  response.write  strSQL
      'response.End 
  
    Set rsGrid = Server.CreateObject("ADODB.RecordSet")
    rsGrid.Open strSQL, DbCon, 1, 1     
        
    if rsGrid.EOF or rsGrid.BOF then
      NoDataGrid = True
    Else
	  NoDataGrid = False
    end if        

    strSQL = "p_gmap_wordgrid_list  '" & search_word & "'" 

    'response.write  strSQL
    'response.End 
  
    Set rsGridList = Server.CreateObject("ADODB.RecordSet")
    rsGridList.Open strSQL, DbCon, 1, 1     
        
    if rsGridList.EOF or rsGridList.BOF then
      NoDataGridList = True
    Else
	  NoDataGridList = False
    end if        

  %>

<html>
<head>
<title>지구촌 한글좌표</title>

<style>
       #map {
        height: 600px;
        width: 60%;
       }
</style>

</head>
<body>

<script src="https://maps.googleapis.com/maps/api/js?sensor=false&language=en"></script>

<SCRIPT LANGUAGE="JavaScript">

    var xhr;

    function gridSet() {

        var lat_value = document.getElementById("lat_value").value;
        var lon_value = document.getElementById("lon_value").value;


        if (lat_value == "") {
            alert("위도가 비었습니다.");
            document.getElementById("lat_value").focus();
            return false;
        }

        if (isNaN(lat_value) == true) {
            alert("위도가 숫자가 아닙니다.");
            document.getElementById("lat_value").focus();
            return false;
        }

        if (lat_value > 42.983403 || lat_value < 32.910549 ) {
            alert("위도는 32.910549 ~ 42.983403 범위입니다.");
            document.getElementById("lat_value").focus();
            return false;
        }

        if (lon_value == "") {
            alert("경도가 비었습니다.");
            document.getElementById("lon_value").focus();
            return false;
        }

        if (isNaN(lon_value) == true) {
            alert("경도가 숫자가 아닙니다.");
            document.getElementById("lon_value").focus();
            return false;
        }

        if (lon_value > 131.625780 || lon_value < 123.715624) {
            alert("경도는 123.715624 ~ 131.625780 범위입니다.");
            document.getElementById("lon_value").focus();
            return false;
        }


        if (pos_word1 == "") {
            alert("위치1 비었습니다.");
            document.getElementById("pos_word1").focus();
            return false;
        }

        if (pos_word2 == "") {
            alert("위치2 비었습니다.");
            document.getElementById("pos_word2").focus();
            return false;
        }

        if (pos_word3 == "") {
            alert("위치3 비었습니다.");
            document.getElementById("pos_word3").focus();
            return false;
        }

        strurl = "deafult.asp?search_lat=" + lat_value + "&search_lon=" + lon_value;
        alert(strurl);
        document.location.href = strurl;
    }



    function gridSet2() {

        if (pos_word1 == "") {
            alert("위치1 비었습니다.");
            document.getElementById("pos_word1").focus();
            return false;
        }

        if (pos_word2 == "") {
            alert("위치2 비었습니다.");
            document.getElementById("pos_word2").focus();
            return false;
        }

        if (pos_word3 == "") {
            alert("위치3 비었습니다.");
            document.getElementById("pos_word3").focus();
            return false;
        }


        //alert("2");

        str_url = "grid_set_ajax.asp?lat_value=" + lat_value + "&lon_value=" + lon_value
                                                 + "&pos_word1=" + pos_word1 + "&pos_word2=" + pos_word2 + "&pos_word3=" + pos_word3;

        //alert(str_url);
        //return false;

        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = gridSetResult;
        xhr.open("Get", str_url);
        xhr.send(null);
    }


    function gridSetResult() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            //alert(data);
            //alert("1");

            document.getElementById("result_msg").innerHTML = data;

            location.reload();
        }
    }

    function checkWord(elem) {
        elem.style.backgroundColor = "FFFF00";
    }

    function allocateWord(elem) {
        var word = elem.innerHTML;
        var pos_word1 = document.getElementById("pos_word1").value;
        var pos_word2 = document.getElementById("pos_word2").value;
        var pos_word3 = document.getElementById("pos_word3").value;

        if (pos_word1 == "") { 
            document.getElementById("pos_word1").value = word;
            document.getElementById("pos_word1").style.color = "FF6600";
            return false;
        }

        if (pos_word2 == "") {
            document.getElementById("pos_word2").value = word;
            document.getElementById("pos_word2").style.color = "FF6600";
            return false;
        }

        document.getElementById("pos_word3").value = word;
        document.getElementById("pos_word3").style.color = "FF6600";
    }

    function popupMap(elem) {
        
        var lat_value = elem.getAttribute("lat_value");
        var lon_value = elem.getAttribute("lon_value");
        var lat1 = elem.getAttribute("lat1");
        var lon1 = elem.getAttribute("lon1");
        var lat2 = elem.getAttribute("lat2");
        var lon2 = elem.getAttribute("lon2");
        var pos_words = elem.getAttribute("pos_words");

        //alert(lat1);
        //alert(lon1);

        var strurl = "default.asp?lat_value=" + lat_value + "&lon_value=" + lon_value + "&pos_words=" + pos_words
                                                     + "&lat1=" + lat1 + "&lon1=" + lon1 + "&lat2=" + lat2 + "&lon2=" + lon2 + "&search_lat=" + lat_value + "&search_lon=" + lon_value + "&zoom_level=15";
        //alert(strurl);
        document.location.href = strurl;

    }

    function searchGrid() {

        var slat = document.getElementById("search_lat").value;
        var slon = document.getElementById("search_lon").value;

        strurl = "default.asp?search_lat=" + slat + "&search_lon=" + slon;
        //alert(strurl);
        document.location.href = strurl;
    }
    
    function downloadGrid() {

        var slat = document.getElementById("search_lat").value;
        var slon = document.getElementById("search_lon").value;

        strurl = "download_map.asp?search_lat=" + slat + "&search_lon=" + slon;
        //alert(strurl);
        document.location.href = strurl;
    }

    function searchWords() {

        var word = document.getElementById("search_word").value;

        strurl = "default.asp?search_word=" + word;
        //alert(strurl);
        document.location.href = strurl;
    }

</SCRIPT>

    <!-- #include virtual="/_include/top_menu.asp" -->



<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" valign=top  align="center">  

    <div style="margin:5px 0;text-align:center;">(42.983403, 123.715624) ~ (32.910549, 131.625780)</div>

    <div style="margin:10px 0;text-align:center;font-size:12px;color:#3388cc;" id="result_msg">...</div>

    <div style="margin:20px 0;text-align:center;"> 
      <input type="text" style="width:80px;" id="search_word" value="<%=search_word %>" placeholder="검색 단어" />&nbsp;
      <input type="button"  value="SEARCH" onclick="searchWords();" />&nbsp;
    </div>

    <div style="margin:10px 0;text-align:center;">       

        <%   
        if NoDataGridList = False then     
        
    	Do While Not rsGridList.EOF 
        %>
                
        <div style="margin:10px 0;line-height:200%;">
            <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="20%" align="center"></td>
                    <td width="36%" align="center">
                    <span style="font-family:맑은 고딕,Arial;color:#3388cc;font-weight:normal;font-size:14px;margin-right:20px;"><%=rsGridList("word_grid")%></span>&nbsp;&nbsp;&nbsp;
                    <img src="/_images/mapmark.jpg" border="0" style="width:16px;" onclick="popupMap(this);" pos_words="<%=rsGridList("word_grid")%>" lat1="<%=rsGridList("lat1")%>" lon1="<%=rsGridList("lon1")%>" lat2="<%=rsGridList("lat2")%>" lon2="<%=rsGridList("lon2")%>" lat_value="<%=rsGridList("lat_value")%>" lon_value="<%=rsGridList("lon_value")%>"  >
                    </td>        
                    <td width="4%" align="center">
                    </td>        
                    <td width="20%" align="center">
                    <span style="font-family:맑은 고딕,Arial;color:#000000;font-weight:normal;font-size:14px;margin-right:20px;"><%=rsGridList("lat_value")%></span>
                    <span style="font-family:맑은 고딕,Arial;color:#000000;font-weight:normal;font-size:14px;margin-right:20px;"><%=rsGridList("lon_value")%></span>
                    </td>
                    <td width="20%" align="center"></td>
                </tr>
            </table>	    
	    </div>

        <%
        
        rsGridList.MoveNext
	    Loop  
	    %>
	    <%                                  
	    else
	    %>
	    <div style="padding:20px 0;color:#000000;font-weight:normal;">Grid가 없습니다.</div>
	    <%
	    end if
            
        set rsGridList = nothing
	    %>   
    
    </div>

    <div style="margin:20px 0;text-align:center;">
      <input type="text" style="width:80px;" id="search_lat" value="<%=search_lat %>" placeholder="경도" /> ~ <input type="text" style="width:80px;" id="search_lon"  value="<%=search_lon %>" placeholder="위도"   />&nbsp;
      <input type="button"  value="GO" onclick="searchGrid();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button"  value="DOWNLOAD" onclick="downloadGrid();" />
    </div>


    <div style="margin:10px 0;text-align:center;">       

        <div style="background-color:#e8e8e8;padding:10px 0 10px 50px;">
        <%   
        if NoDataGrid = False then     
        
        latgrid_low = rsGrid("latgrid_low")
        latgrid_high = rsGrid("latgrid_high")

'response.write latgrid_low & ":::::::" & latgrid_high

    	Do While latgrid_high * 1 - latgrid_low >= 0

            strSQL = "p_gmap_wordgrid_read_lon  '" & latgrid_low & "','" & search_lon & "'" 

            'response.write  strSQL
            'response.End 
  
            Set rs = Server.CreateObject("ADODB.RecordSet")
            rs.Open strSQL, DbCon, 1, 1     
        
            if NOT rs.EOF and NOT rs.BOF then
            Do While Not rs.EOF 
            %> 
            <div style="width:8%;padding:10px 3px;font-size:9px;border:solid 1px #000000;line-height:200%;background-color:#ffffff;float:left;" >
            <img src="/_images/mapmark.jpg" border="0" style="width:16px;cursor:pointer;" onclick="popupMap(this);" pos_words="<%=rs("word_grid")%>" lat1="<%=rs("lat1")%>" lon1="<%=rs("lon1")%>" lat2="<%=rs("lat2")%>" lon2="<%=rs("lon2")%>" lat_value="<%=rs("lat_value")%>" lon_value="<%=rs("lon_value")%>"   /><br />
            <span style="font-size:12px;color:#0000ff;"><%=rs("word_grid") %></span><br />
                (<%=rs("lat_value") %>,<%=rs("lon_value") %>)
            </div>
            <%
            rs.MoveNext
            Loop 

            end if        

            set rs = nothing
            %>

        <div style="clear:both;"></div>
        <%
        latgrid_low = latgrid_low + 1
        
	    Loop  
	    %>
	    <%                                  
	    else
	    %>
	    <div style="padding:20px 0;color:#000000;font-weight:normal;">선택하세요.</div>
	    <%
	    end if
            
        set rsGrid = nothing
	    %>   
        </div>
    
    </div>
    <div style="text-align:center;">

    <div id="map"  style="margin-left:20%;text-align:center;"></div>
    <script>
      function initMap() {
        var uluru = {lat: <%=lat_value %>, lng: <%=lon_value %>};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: <%=zoom_level %>,
          center: uluru
        });

        var contentString = '<div style="text-align:center;color:#000000;"><%=pos_words %></div>';

        var infowindow = new google.maps.InfoWindow({
          content: contentString
        });

        var marker = new google.maps.Marker({
          position: uluru,
          map: map,
          title: 'Words grid'
        });

        marker.addListener('click', function() {
          infowindow.open(map, marker);
        });

        var bounds = {
        north: <%=lon2 %>,
        south: <%=lon1 %>,
        east: <%=lat2 %>,
        west: <%=lat1 %>
        };

  
        // Define a rectangle and set its editable property to true.
        var rectangle = new google.maps.Rectangle({
          bounds: bounds,
          editable: false
        });
        //alert("1");
        rectangle.setMap(map);

      }

    </script>

    <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpEil7kuKIY3O4KzsWQkJ7fYFPkbyWLIc&callback=initMap">
    </script>

    </div>
    
	    <div style="height:50px;""></div>
</td>
</tr>
</table>

<!-- #include virtual="/_include/connect_close.inc" -->


</body>

</html>




