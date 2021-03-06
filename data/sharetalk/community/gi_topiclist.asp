﻿<!-- #include virtual="/_include/connectgi.inc" -->
<%
    MENU = "GI"
    keyword = request("keyword")
    type_desc = request("type_desc")

      yyyymmdd = request("yyyymmdd")
      direction = request("direction")

      strSQL = "p_daymove_topic_read '" & direction  & "','" & yyyymmdd  & "'"
      'response.Write strSQL & ":::<br>"
   
      Set rs = Server.CreateObject("ADODB.RecordSet")
      rs.Open strSQL, giDbCon, 1, 1 

      yyyymmdd = rs("yyyymmdd")
        	
      set rs = nothing      


    strSQL = "p_gim_category_topic_type"

    Set rsCategory = Server.CreateObject("ADODB.RecordSet")
    rsCategory.Open strSQL,giDbCon, 1, 1
          
    'response.Write strSQL
    if rsCategory.EOF or rsCategory.BOF then
          NoDataCategory = True
    Else
	      NoDataCategory = False
    end if    

      'response.Write yyyymmdd & ":::<br>"


  strSQL = "p_gih_topic_link_read '" & yyyymmdd & "','" & _
                                       type_desc & "','" & _
                                       keyword & "'"
    
  'response.Write strSQL
  'response.end
    
  set rsTopic = Server.CreateObject("ADODB.Recordset")
  rsTopic.CursorLocation = 3  
  rsTopic.Open strSQL, giDbCon

  if rsTopic.EOF or rsTopic.BOF then
	NoDataTopic = True
  Else
	NoDataTopic = False
  end if  

      
  '페이징처리관련
  page =request("page")
  
  If NoDataTopic = False then
	Cus_pageSize = 20
	rsTopic.PageSize = Cus_pageSize

	pagecount=rsTopic.pagecount
	totalRecord = rsTopic.RecordCount

	cPage = page
	if page <> "" Then
		if cPage < 1 Then 
			cPage = 1
		end if
    else
		page = 1
		cPage = 1
	end If	
	rsTopic.AbsolutePage = cPage

	lastpg = int(((totalRecord -1) / rsTopic.PageSize) + 1)

	if page > lastpg then
		page = lastpg
	end If

  end if
  '페이징처리관련 끝    

%>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="S A Bokhari">
<meta name="description" content="글공유">
<meta name="keywords" content="글공유,글로벌정보">
<title>global intelligence</title>
<link rel="stylesheet" href="/_include/style.css" type="text/css">

<SCRIPT LANGUAGE=javascript>
<!--
    var xhr;

    function PostSearch() {

        var keyword = document.getElementById("keyword").value;

        var siteurl = "gi_topiclist.asp?keyword=" + keyword;

        window.location.href = siteurl;

        //alert(keyword);

    }


    //-->
</SCRIPT>

    
</head>

<body>
    
<input type="hidden" name="post_no" value="" id="post_no" /> 	
    <% top_menu = "글공유" %>
    <!-- #include virtual="/_include/top_menu.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
<div style="height:70px"></div>
<div class="content">
    <div style="width:100%;padding:5px 0px 5px 0px;display:flex;justify-content:center;">
        <table style="width:95%">
           <tr height="25px;">
           <td width="10%"></td>
           <td width="30%"><span style="font-size:18px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;color:#000000;">TOPIC</span></td>
           <td style="font-size:14px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;vertical-align:middle;text-align:center;">
                                  <a href="gi_topiclist.asp?yyyymmdd=<%=yyyymmdd %>&direction=B"><img src="images/left_arrow.png" style="height:15px;" border="0"/></a>
                                  &nbsp;
                                  <a href="gi_topiclist.asp?yyyymmdd=<%=yyyymmdd %>"><%=mid(yyyymmdd,5,2) %>월 <%=mid(yyyymmdd,7,2) %>일</a>
                                  &nbsp;
                                  <a href="gi_topiclist.asp?yyyymmdd=<%=yyyymmdd %>&direction=F"><img src="images/right_arrow.png" style="height:15px;" border="0"/></a>
           </td>
           <td width="10%"></td>
           </tr>
        </table>
    </div>

    <!-- 상단 카테고리 start -->
    <div style="padding:5px 0px 10px 0px;display:flex;justify-content:center;">
        <table style="width:95%;border:0px;">
            <tr>
            <td align="left">    
                    <%    
                    if NoDataCategory = False then 
                    %>
                    <a href="gi_topiclist.asp">
                    <span  style="margin-right:20px;font-size:12px;font-family:Arial,맑은 고딕,돋움;color:#808080;font-weight:bold;white-space: nowrap;">전체</span>
                    </a>
                    <%
                    Do While Not rsCategory.EOF  %>
                    <a href="gi_topiclist.asp?type_desc=<%=rsCategory("type_desc") %>"><span  style="margin-right:10px;font-size:12px;font-family:Arial,맑은 고딕,돋움;color:#808080;font-weight:bold;white-space: nowrap;"><%=rsCategory("type_desc")%></span></a>
                    <%    
                    rsCategory.MoveNext
                    Loop 

                    set rsCategory = nothing
                    end if
                    %>
                </td>
            </tr>
            <tr><td colspan="3" style="height:1px;background:solid 1px #CCCCCC"></td></tr>
        </table>
    </div>
    <!-- 상단 카테고리 end -->

    <!-- 하단 기사내용 start -->

        <% if NoDatatopic = False then 
        
           if FirstPage <> 1 then
	       RowCount = rsTopic.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
		   Do While Not rsTopic.EOF  and RowCount > 0 %>

    <div style="padding:15px 0px;border-top:solid 5px #EEEEEE;display:flex;justify-content:center;">
    <table style="width:95%;border:0px;">
        <tr height="45px"><td style="font-size:18px;font-family:Arial,맑은 고딕,돋움;font-weight:normal;"><%=rsTopic("topic_desc") %></td></tr>
        <tr height="35px"><td><a href="http://<%=rsTopic("source_link") %>"><span style="font-size:16px;font-family:Arial,맑은 고딕,돋움;font-weight:normal;color:#0000ff;"><%=rsTopic("topic_desc_en") %></span></a></td></tr>
            <% if rsTopic("topic_summary") <> "" then 
           topic_summary = rsTopic("topic_summary")
           topic_summary = Replace(topic_summary, "''", "'")
           topic_summary = Replace(topic_summary, "<BR>", chr(13))
        %>
        <tr height="25px"><td><a href="#"><%=topic_summary %> </a></td></tr>
        <%
           end if
        %>
        <tr height="25px"><td>
           <span  style="font-size:10px;font-family:Arial,맑은 고딕,돋움;color:#808080;">[<%=rsTopic("cat_name") %>] [<%=rsTopic("area_desc") %>]</span>
           <span  style="font-size:10px;font-family:Arial,맑은 고딕,돋움;color:#808080;">  <%=mid(rsTopic("register_date"),3,6) %></span>
        </td></tr>
        <tr height="25px"><td>
        <%        
        strSQL = "p_gih_topic_keynorm_read '" & rsTopic("topic_no")  & "'"
   
        Set rs = Server.CreateObject("ADODB.RecordSet")
        rs.Open strSQL, giDbCon, 1, 1 

        if NOT rs.EOF and NOT rs.BOF then      
            %>
            <span  style="margin-right:5px;font-size:12px;font-family:Arial,맑은 고딕,돋움;color:#000000;font-weight:bold;">$</span>
            <% 
		Do While Not rs.EOF   %> 		 
        <a href="gi_keynorm.asp?keynorm_no=<%=rs("keynorm_no") %>">
            <span  style="margin-right:5px;font-size:12px;font-family:Arial,맑은 고딕,돋움;color:#000000;font-weight:normal;"><%=rs("keynorm_name") %></span>
        </a>     
	    <%                                    
           rs.MoveNext
	       Loop 
        	
           end if 
           set rs = nothing
         %>

            </td></tr>

    </table>
    </div>
    
    
        <%     
            RowCount = RowCount-1       
            area_old = rsTopic("area_no") 
        	rsTopic.MoveNext
	        Loop 
        end if

        	set rsTopic = nothing         
            
        %>
  

    <!-- 하단 기사내용 start -->
    <!-- 페이징 처리-->					
    <%if NoDataTopic = false Then
	Cus_Tar = "keyword=" & keyword & "&type_desc=" & type_desc
    %>
    <!--#include virtual="/_include/asp_page_function.asp"-->
    <table cellSpacing="0" cellPadding="0" border="0" ID="Table9" width="100%">
	<tr>
		<td align="center">
			<table border="0" width="100%" cellpadding="0" cellspacing="0" ID="Table11" height="20">
				<tr>
					<td height="20" align="center" valign="middle">
    <%
	Response.Write ShowPageBar("gi_topiclist.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
    %>
					</td>
				</tr>
			</table>
		</td>
	</tr>
    </table>	
	<%end if%>		
	<!-- 페이징 처리 끝-->
    
<div style="height:50px;"></div>

<div class="bottom" style="margin-top:10px;padding:10px 0;border-top:solid 1px #dddddd;background-color:#ffffff;">
    <div style="text-align:center;width:100%;">
    <table style="width:100%;border:0px;">
        <tr>
            <td align="center"><span style="font-size:12px;font-family:Arial,맑은 고딕,돋움;color:darkgray;font-weight:normal;">Powered by  Global Intelligence . kr</span></td>
        </tr>
    </table>
    </div>
</div>
</body>
</html>

<!-- #include virtual="/_include/connectgi_close.inc" -->