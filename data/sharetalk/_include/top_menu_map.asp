﻿<input type="checkbox" id="menuToggle">
<header>
        <div id="brand">
            <table width="100%" border="0">
                <tr height="3px;"><td colspan="6"></td></tr>
                <tr><td width="3%"></td>
                    <td width="17%">
                          <% if MENU = "HOME" then %>
                          <a href="/"><img src="/images/topicon_list_white.gif" border="0" style="height:25px;" /></a>
                          <% else %>
                          <a href="/"><img src="/images/topicon_list_white.gif" border="0" style="height:25px;opacity:0.5;" /></a>
                          <% end if %>
                    </td>
					<% if Session("member_no") <> "" then %>
  					<td width="17%">
                          <% if MENU = "MAP" then %>
                          <a href="/map/navigator.asp"><img src="/images/topicon_map.png" border="0" style="height:25px;" /></a>
                          <% else %>
                          <a href="/map/navigator.asp"><img src="/images/topicon_map.png" border="0" style="height:25px;opacity:0.5;" /></a>
                          <% end if %>
                    </td>
  					<td width="17%">
                          <% if MENU = "SNS" then %>
                          <a href="/sns/test_page_insta.asp"><img src="/images/topicon_sns.png" border="0" style="height:25px;" /></a>
                          <% else %>
                          <a href="/sns/test_page_insta.asp"><img src="/images/topicon_sns.png" border="0" style="height:25px;opacity:0.5;" /></a>
                          <% end if %>
                    </td>
  					<td width="17%">
                          <% if MENU = "BOARD" then %>
                          <a href="/sns/insta_board.asp"><img src="/images/topicon_write.png" border="0" style="height:25px;" /></a>
                          <% else %>
                          <a href="/sns/insta_board.asp"><img src="/images/topicon_write.png" border="0" style="height:25px;opacity:0.5;" /></a>
                          <% end if %>
                    </td>
  					<td width="17%">
                          <% if MENU = "CHAT" then %>
                          <a href="/chat/chat_state.html" target="_top" onclick="window.open(this.href, 'W3W Chatting','width=500,height=600,resizable=no,scrollbars=no,status=no');return false;"><img src="/images/topicon_chat.png" border="0" style="height:25px;" /></a>
                          <% else %>
                          <a href="/chat/chat_state.html" target="_top" onclick="window.open(this.href, 'W3W Chatting','width=500,height=600,resizable=no,scrollbars=no,status=no');return false;"><img src="/images/topicon_chat.png" border="0" style="height:25px;opacity:0.5;" /></a>
                          <% end if %>
                    </td>
					<% end if %>
                    <td width="12%">
                    </td>
                </tr>
            </table>
        </div>
		<div style="clear:both;"></div>
        <div style="padding:0px;margin:0px;">
            <table style="width:100%;border:0px;">
                <tr height="20px">
				
                    <td width="3%;"></td>
                    <td width="50px;" text-align="center" vertical-align="bottom;"><img src="/images/icon_search.png" border="0"  style="height:12px;" onclick="describeSearchType()"/></td>
                    <td width="89%" text-align="center">
					<!--
						<span onclick="toggle_visibility('popupBoxOnePosition');" style="cursor:pointer;" id="share_desc">외부공개</span>
						<span onclick="toggle_visibility('popupBoxOnePosition');" style="cursor:pointer;">▼</span>
					-->
						<select class="selectpicker" id="selectOption" data-style="btn-danger">
							<option value="1">주소로 검색</option>
							<option value="2">3Words로 검색</option>
						</select>
                        <input type="text" style="width:50%;height:20px;background-color:transparent;border:solid 0px #0CC738;border-bottom:solid 1px #DDDDDD;color:#FFFFFF" name="searchtext1" id="addressSpace" onkeypress="describeSearchType()"  />
                    </td>
                    <td width="3%;" text-align="center" vertical-align="bottom;"></td>
                </tr>
            </table>
        </div>
    <label for="menuToggle" class="menu-icon">&#9776;</label>
</header>