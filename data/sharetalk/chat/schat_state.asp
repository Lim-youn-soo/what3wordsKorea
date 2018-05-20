<%
    id = Session("member_no")
    name = Request.Cookies("member_name")
    img = Request.Cookies("profile_url")
    roomid = request("roomid")

    if img = "" then
        img = "/images/my.png"
    end if
%>
<!Doctype html>
<html>
    <meta charset="UTF-8">
    <head>
        <title>W3W Chatting</title>
        <link rel="stylesheet" href="/_css/chat.css?Ver=1" type="text/css">
        <script type="text/javascript">
            var rid = <%=roomid%>;
            var nick = "<%=name%>";
            var imgsrc = "<img id='img' src='<%=img%>' onclick='getRoute(<%=id%>)'/>";
            var my = false;
        </script>
    </head>
    <body>
        <!--<p align="left">위치조회 허용<input type="checkbox" onclick="setMyLocation()"></p>-->
        <ul id="room"></ul>
        <div>
            <input id="r" onkeypress="if(event.keyCode==13){sendRoom()}" autocomplete="off" /><button onclick="sendRoom()">Send</button>
        </div>
        <script type="text/javascript" src="http://tour.abcyo.kr:1337/socket.io/socket.io.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.1.js"></script>
        <script type="text/javascript" src="/_script/chatting.js?ver=1" onload="joinRoom()"></script>
    </body>
</html>