<%
    id = Session("member_no")
    name = Request.Cookies("member_name")
    img = Request.Cookies("profile_url")
    other = request("otherid")
    roomid = request("roomid")

    if img = "" then
        img = "/images/my.png"
    end if
%>
<!Doctype html>
<html>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
    <link rel="stylesheet" href="/_css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <head>
        <title>W3W Chatting</title>
        <link rel="stylesheet" href="/_css/chat.css?ver=1" type="text/css">
        <style type="text/css">
            @import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
            *{ font-family: 'Jeju Gothic'; }
        </style>
        <script type="text/javascript">
            // 1 대 1 채팅
            <% if other then %>
            var id = new Array();
            id[0] = <%=id%>;
            id[1] = <%=other%>;
            <% else %>

            // 지역 별 채팅
            var rid = <%=roomid%>;
            <% end if %>
            var nick = '<%=name%>';
            var imgsrc = "<img id='img' src='<%=img%>' onclick='getRoute(<%=id%>)'/>";
        </script>
    </head>
    <body>
        <p align="left">위치조회 허용<input type="checkbox" onclick="setMyLocation()"></p>
        <ul id="chat"></ul>
        <div style="margin-bottom:5px;">
            <input id="o" style="height:89%;" onkeypress="if(event.keyCode==13){<% if other then %> sendOne(); <% else %> sendRoom(); <% end if %>}" autocomplete="off" />
            <button class="btn btn-info" style="font-size:80%; height:90%;" onclick="<% if other then %> sendOne(); <% else %> sendRoom(); <% end if %>">보내기</button>
        </div>
        <script type="text/javascript" src="http://tour.abcyo.kr:1337/socket.io/socket.io.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.1.js"></script>
        <script type="text/javascript" src="/_script/chatting.js?ver=2" onload="<% if other then %>sendSession();<% else %>joinRoom(<%=roomid%>);<% end if %>"></script>
    </body>
</html>