﻿<% Response.Charset="UTF-8" %>  
<!--#include file="adminconn.inc"-->
<%
title=request.form("title")
classD=request.form("class")
mContent = trim(Request.form("content")) 
if mContent="" then mContent="无" end if
	mContent = Replace(mContent,"<script","<sscript") 
	mContent = Replace(mContent,"/script>","/scripts>")
	mContent = Replace(mContent,"/script >","/scripts>")

user=request.form("user")
set rs=server.createobject("adodb.recordset")
sql="select * from NEWS where id is null"
rs.open sql,conn,1,3
rs.addnew
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
		response.write "alert('添加成功！');" & Chr(13)
		response.write "window.document.location.href='admin_info.asp';"&Chr(13)
		response.write "</script>" & Chr(13)
Response.End
%>
