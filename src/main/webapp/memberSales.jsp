<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<String[]> list = new ArrayList<>();
	
	try{
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","1234");
		System.out.println("DB");
		
		String sql = "select e.custno, e.custname, e.grade, sum(o.price) from member_tbl_02 e, money_tbl_02 o";
		sql += " where e.custno=o.custno";
		sql += " group by e.custno, e.custname, e.grade";
		sql += " order by sum(o.price) desc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			String[] data = new String[4];
			data[0] = rs.getString(1);
			data[1] = rs.getString(2);
			data[2] = rs.getString(3);
			String price = rs.getString(4);
			data[3] = price.substring(0, 1);
			data[3] += ",";
			data[3] += price.substring(1, price.length());
			
			list.add(data);
		}
		
		con.close();
		ps.close();
		rs.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.title{
		text-align : center;
	}
	
	.table{
		margin : auto;
	}
	td{
		text-align : center;
	}
</style>

<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_nav.jsp"></jsp:include>
	<div class="section">
		<h3 class="title">회원목록조회/수정</h3>
			<table class="table" border="1">
				<tr>
					<td>회원번호</td>
					<td>회원성명</td>
					<td>고객등급</td>
					<td>매출</td>
				</tr>
				
				<%
					for(int i = 0; i < list.size(); i++){
				%>
				<tr>
					<td>
					<%=list.get(i)[0] %></td>				
					<td><%=list.get(i)[1] %></td>				
					<td><%=list.get(i)[2] %></td>				
					<td><%=list.get(i)[3] %></td>				
				</tr>
				<%} %>
			</table>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>