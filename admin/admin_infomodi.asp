﻿<% Response.Charset="UTF-8" %>  
<!--#include file="adminconn.inc"-->
<%
  if session("aleave")="" then
      response.redirect "adminlogin.asp"
	  response.end
  end if
%>
<%
if request("no")="modi" then
newsid=request.form("newsid")

title=request.form("title")
classD=request.form("class")
user=request.form("user")

mContent = trim(Request.form("content")) 
  mContent = Replace(mContent,"<script","<sscript") 
  mContent = Replace(mContent,"/script>","/scripts>")
  mContent = Replace(mContent,"/script >","/scripts>")



set rs=server.createobject("adodb.recordset")
sql="select * from NEWS where id="&newsid
rs.open sql,conn,1,3
rs("title")=title
rs("content")=mcontent
rs("user")=user
rs("class")=classD
rs.update
rs.close
set rs=nothing
conn.close  
set conn=nothing


response.write "<script language='javascript'>" & chr(13)
		response.write "alert('修改成功！');" & Chr(13)
		response.write "window.document.location.href='admin_info.asp';"&Chr(13)
		response.write "</script>" & Chr(13)
Response.End
end if
%>


<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<link rel="stylesheet" type="text/css" href="../css/form.css">
    <link href="umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="umeditor/third-party/jquery.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="umeditor/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="umeditor/umeditor.min.js"></script>
<title>修改</title>

<script language = "JavaScript"> 
function CheckForm()
{
  if (document.addNEWS.title.value.length == 0) {
    alert("标题不能为空.");
    document.addNEWS.title.focus();
    return false;
  }
    if (document.addNEWS.user.value.length == 0) {
    alert("作者不能为空");
    document.addNEWS.user.focus();
    return false;
  }
  return true;
}
</script>

</head>

<body leftmargin="0" topmargin="0" bgcolor="#F7F7F7">
<% 
newsid=request("id")
Set rso=Server.CreateObject("ADODB.RecordSet") 
sql="select * from NEWS where  id="&newsid
rso.Open sql,conn,1,1
if rso.eof and rso.bof then
response.Write("文章查找失败")
else
%>
  <form name="addNEWS" method="post" action="admin_infomodi.asp?no=modi" class="basic-grey" onSubmit="return CheckForm();" >
    <label>
  <span>标题：</span>
  <input name="title" type="text" class="input" size="30" value="<%=rso("title")%>">
  </label>

  <label>
    <span>资讯类型：</span>
    <select name="class" id="">
      <option value="电台新闻" selected>电台新闻</option>
      <option value="校园资讯">校园资讯</option>
      <option value="其他">其他</option>
    </select>
  </label>

      <label>
        <span>新闻内容：</span><br/><br/><br/>
                <!--<textarea name="content">在这里输入内容</textarea>-->
        <!-- 加载编辑器的容器 -->
        <span>&nbsp;</span>
        <span>&nbsp;</span>
        <!--编辑器在这里-->
        <script id="container" name="content" type="text/plain" style="width:450px;height:230px;"><%=rso("content")%></script>
      </label>
      <br/><br/>
      <label>
        <span>发布者：</span>
        <input name="user" type="text" value=<%=rso("user")%>>
      </label>
      <br/>
      <label>
        <span>&nbsp;</span>
        <span>&nbsp;</span>
        <input name="newsid" type="text" value=<%=newsid%> hidden>
        <input type="submit" class="button" value="SEND" />
        <input type="reset" class="button" name="Submit2" value="RESET" > 
      </label>
  </form>

<% End If
rso.close
set rso=nothing
 %>
</body>
<script type="text/javascript">
    //实例化编辑器
    var um = UM.getEditor('container');
    um.addListener('blur',function(){
        $('#focush2').html('编辑器失去焦点了')
    });
    um.addListener('focus',function(){
        $('#focush2').html('')
    });
    //按钮的操作
    function insertHtml() {
        var value = prompt('插入html代码', '');
        um.execCommand('insertHtml', value)
    }
    function isFocus(){
        alert(um.isFocus())
    }
    function doBlur(){
        um.blur()
    }
    function createEditor() {
        enableBtn();
        um = UM.getEditor('myEditor');
    }
    function getAllHtml() {
        alert(UM.getEditor('myEditor').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UM.getEditor('myEditor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UM.getEditor('myEditor').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用umeditor')方法可以设置编辑器的内容");
        UM.getEditor('myEditor').setContent('欢迎使用umeditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UM.getEditor('myEditor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UM.getEditor('myEditor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UM.getEditor('myEditor').selection.getRange();
        range.select();
        var txt = UM.getEditor('myEditor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UM.getEditor('myEditor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UM.getEditor('myEditor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UM.getEditor('myEditor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UM.getEditor('myEditor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            domUtils.removeAttributes(btn, ["disabled"]);
        }
    }
    //实例化结束
</script>


</html>
