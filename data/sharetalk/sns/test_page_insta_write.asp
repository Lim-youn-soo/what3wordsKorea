﻿<!-- #include virtual="/_include/connect.inc" -->
<!-- #include virtual="/_include/login_check.inc" -->
<%
    input_user = Request.Cookies("member_name")
    input_userid = Session("member_no")
%>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>What3Words Home</title>
        <link rel="stylesheet" href="/_css/style.css" type="text/css"> 
        <link rel="stylesheet" href="../_font/font_folder.css" type="text/css">
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <link rel="stylesheet" href="/_css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/_script/account.js"></script>
        <style>  
            .info_box_1{
                margin-top:80px;
                text-align: center;
                font-family: jua, sans-serif;
                font-size:12pt;
            }
            .info_box_2{
                margin-top:10px;
                text-align: center;
                font-family: jua, sans-serif;
                font-size:12pt;
            }
            .content_info{
                background-color:rgba(248, 89, 100, 0.7);
                font-family: jua, sans-serif;
            }
            .content_input{
                text-align:center;
                margin:20px;
                font-family: THESusu, sans-serif;
            }
            #content_input_area{
                width:100%;
                min-height:180px;
                border:5px solid rgba(128,128,128,0.7);
                border-radius: 5px;
            }
            .file_info{
                background-color:rgba(248, 89, 100, 0.7);
                font-family: jua, sans-serif;
            }
            .file_upload{
                text-align:center;
                margin:20px;
                border:5px solid rgba(128,128,128, 0.7);
                border-radius: 5px;            
            }
            .file_upload_box{
                width:100%;              
            }
            .file_upload_box{
                text-align:center;
            }
            #file_upload_area{
                width:100%;
            }
            .location_info_1{
                background-color:rgba(248, 89, 100, 0.7);    
                font-family: jua, sans-serif;

            }
            .location_info_2{
                text-align:left;
                margin-left:35px;
                margin-right:35px;
                background-color:rgba(240, 237, 199, 0.7);   
                font-family: jua, sans-serif;

            }
            .address_input_box{
                margin:20px;
            }
            .address_button_box{
                margin-right:20px;
                margin-left:20px;
            }
            .my_location_info{
                margin-top:15px;
                background-color:rgba(100, 200, 100, 0.8);
            }
            .lat_input{
                text-align:left;
                margin-left:80px;
                margin-right:80px;
                margin-top:5px;
                background-color:rgba(100, 200, 100, 0.5);
            }
            .log_input{
                text-align:left;
                margin-left:80px;
                margin-right:80px;
                margin-top:5px;
                background-color:rgba(100, 200, 100, 0.5);
            }
            .button_box{
                text-align:center;
                margin:20px;
            }
            #map{
                border:10px solid rgba(100, 200, 100, 0.5);
                border-radius: 10px;
                width:100%;
                height:50%;
            }
        </style>
        <script type="text/javascript">
            var lat_r ="";
            var log_r = "";
            var map;
            function initialize() {
             var Y_point = 37.6388235; // Y 좌표
             var X_point = 127.0647555; // X 좌표
             var zoomLevel = 19; // 첫 로딩시 보일 지도의 확대 레벨

             var myLatlng = new google.maps.LatLng(Y_point, X_point);
             var mapOptions = {
                 zoom: zoomLevel,
                 center: myLatlng,
                 mapTypeId: google.maps.MapTypeId.ROADMAP
             }

             map = new google.maps.Map(document.getElementById('map'), mapOptions);
            }
            function geoFind() {
                //Geolocation API에 액세스할 수 있는지를 확인
                if (navigator.geolocation) {
                    //위치 정보를 얻기
                        navigator.geolocation.getCurrentPosition(function (pos) {
                            lat_r = pos.coords.latitude;
                            log_r = pos.coords.longitude;
                            $('#latitude').html(pos.coords.latitude);       // 위도
                            $('#longitude').html(pos.coords.longitude);  // 경도
                            alert(lat_r);
                        });
                } else {
                    alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.")
                }
                var geocoder = new google.maps.Geocoder;

            }
            function write_upload() {
                var content_input_area = document.getElementById("content_input_area").value;
                var file_upload_area_real;
                var latitude = lat_r;
                var longitude = log_r;

                if (latitude.length < 2) {
                    alert("please wait for location");
                    return false;
                }

                if (content_input_area == "") {
                    alert("content is empty");
                    return false;
                }
                else if (file_upload_area_real == "") {
                    alert("upload is empty");
                    return false;
                }
                else if (latitude == "") {
                    alert("lat is empty");
                    return false;
                }
                else if (longitude == "") {
                    alert("lat is empty");
                    return false;
                }
                else {
                    upload(2);
                    setTimeout(function(){
                        file_upload_area_real = document.getElementById('sns_url').value;
                        var content = content_input_area.replace(/\n/g, '<br/>');
                        var from_place = "what3words";
                        var address = "from_what3words";
                        var insta_link = "from_what3words";
                        var strurl = "test_send_write.asp?from_place=" + from_place + "&file_upload_area_real=" + file_upload_area_real + "&content_input_area=" + content + "&latitude=" + latitude + "&longitude=" + longitude + "&address=" + address + "&insta_link=" + insta_link;

                        var xhr = new XMLHttpRequest();
                        xhr.onreadystatechange = function(){
                            if (this.readyState == 4 && this.status == 200){
                                document.getElementById("result_msg").innerHTML = this.responseText;
                                xhr = null;
                            }
                        };
                        xhr.open("Get", strurl);
                        xhr.send(null);
                        location.href = "test_page_insta.asp";
                        return true;
                    },2000);
                }
            }
            function BacktoDefault() {
                location.href = "test_page_insta.asp";
            }
            function geoCode() {
                var latitude_x = document.getElementById("latitude");
                var longitude_y = document.getElementById("longitude");
                var faddr = document.getElementById("address").value;
                var geocoder;
           
                geocoder = new google.maps.Geocoder();
                geocoder.geocode({ "address": faddr }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        var faddr_lat = results[0].geometry.location.lat();
                        var faddr_lng = results[0].geometry.location.lng();
                    } else {
                        var faddr_lat = "";
                        var faddr_lng = "";
                    }

                    $('#latitude').html(faddr_lat);       // 위도
                    $('#longitude').html(faddr_lng);   // 경도
                    lat_r = faddr_lat;
                    log_r = faddr_lng;
                    var marker_selected = { lat: parseFloat(lat_r), lng: parseFloat(log_r) };
                    map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 19,
                        center: marker_selected
                    });
                    var marker_set = new google.maps.Marker({
                        position: marker_selected,
                        map: map,
                        title: "회원님의 위치입니다."
                    });
                    return;
                });
            }

            function reverseGeocode(geocoder) {
                if(lat_r == ""){
                    return false;
                }else{
                     geocoder.geocode({lat_r, log_r}, function(result, state){
                        if(status === 'OK'){
                            alert("회원님의 현재 위치는 [" + results[1].formatted_address + "] 로 확인됩니다.");
                        }
                    });
                    return true;             
                }
            }
        </script>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAwrfz2MVZoTgp-8XvRRrdSyba3_gV_4VU"></script>
    </head>

    <body onload="initialize();">
        <% top_menu = "HOME" %>
        <!-- #include virtual="/_include/top_menu.asp" -->
        <!-- #include virtual="/_include/top_menulist.asp" -->
        <div class="info_box_1 row">
            <div class="content_info row">
                글을 작성해주세요
             </div>        
            <div class="content_input row">
                <textarea id="content_input_area"></textarea>
            </div>
        </div>
        <div class="info_box_2 row">
            <div class="file_info row">
                사진을 업로드 해주세요
            </div>
            <div class="file_upload row">
                <input type="hidden" id="sns_url">
                <form id="uploadsns" method="POST" enctype="multipart/form-data">
                    <input id="sns" name="snsupload" type="file" accept=".jpg,.png,.bmp,.jpeg,.gif">
                </form>
            </div>
        </div>
        <div class="info_box_2 row">
            <div class="location_info row">
                <div class="location_info_1 row">
                    본인의 위치를 찾아주세요<br>
                </div>
                <div class="location_info_2 row">
                    [방법1] 간략한 주소를 입력 후 (주소변환) CLICK!<br>
                    [방법2] (위치 자동 찾기) CLICK! 으로 본인위치 확인<br>
                </div>
            </div>
            <div class="address_input_box row">
                <input id="address" style="width:95%;" type="text" placeholder="회원님 위치를 작성해주세요." />
            </div>
            <div class="address_button_box row">
                <div class="address_change_button col-xs-6">
                    <button type="button" class="btn btn-lg btn-block" style="background-color:rgba(248, 89, 100, 0.7); box-shadow: 3px 3px #888888;" onclick="geoCode();">주소 변환</button>
                </div>
                <div class="address_search_button col-xs-6">
                    <button type="button" class="btn btn-lg btn-block" style="background-color:rgba(248, 89, 100, 0.7); box-shadow: 3px 3px #888888;" onclick="geoFind();">위치 자동 찾기</button>
                </div>
            </div>
            <div class="my_location_info row">
                선택된 회원님의 위치입니다.
            </div>
            <div class="lat_input row">
                <ul>
                    <li>위도 :<span id="latitude"></span></li>
                </ul>
            </div>
            <div class="log_input row">
                <ul>
                    <li>경도 :<span id="longitude"></span></li>
                </ul>
            </div>
        </div>
        <div class="info_box_2 row">
            <div id="map">
            </div>
        </div>
        <hr style="border:3px solid rgba(128, 128, 128, 0.5);">
        <div class="info_box_2 row">
            <div class="button_box row">
                <div class="button_yes col-xs-6">
                <button type="button" class="btn btn-success btn-lg btn-block" style="box-shadow: 3px 3px #888888;" onclick="write_upload()">확인</button>
                </div>
                <div class="button_no col-xs-6">
                <button type="button" class="btn btn-danger btn-lg btn-block" style="box-shadow: 3px 3px #888888;" onclick="BacktoDefault()">취소</button>
                </div>   
            </div>
        </div>
    </body>
</html>
<!-- #include virtual="/_include/connect_close.inc" -->