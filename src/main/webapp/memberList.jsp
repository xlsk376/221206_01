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
		
		String sql = "select custno, custname, phone, address, to_char(joindate,'yyyy-mm-dd'), grade, city from member_tbl_02";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			String[] data = new String[7];
			data[0] = rs.getString(1);
			data[1] = rs.getString(2);
			data[2] = rs.getString(3);
			data[3] = rs.getString(4);
			data[4] = rs.getString(5);
			String grade = rs.getString(6);
			if(grade.equals("A") || grade.equals("a")){
				grade = "VIP";
			}else if(grade.equals("B")){
				grade = "일반";
			}else if(grade.equals("C")){
				grade = "직원";
			}
			data[5] = grade;
			String city = rs.getString(7);
			if(city.equals("01")){
				city = "서울";
			}else if(city.equals("10")){
				city = "인천";
			}else if(city.equals("20")){
				city = "성남";
			}else if(city.equals("30")){
				city = "대전";
			}else if(city.equals("40")){
				city = "광주";
			}else if(city.equals("60")){
				city = "부산";
			}
			data[6] = city;
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
					<td>전화번호</td>
					<td>통신사</td>
					<td>가입일자</td>
					<td>고객등급</td>
					<td>거주지역</td>
				</tr>
				
				<%
					for(int i = 0; i < list.size(); i++){
				%>
				<tr>
					<td>
					<a href="memberUpdate.jsp?custno=<%=list.get(i)[0] %>"><%=list.get(i)[0] %></a></td>				
					<td><%=list.get(i)[1] %></td>				
					<td><%=list.get(i)[2] %></td>				
					<td><%=list.get(i)[3] %></td>				
					<td><%=list.get(i)[4] %></td>				
					<td><%=list.get(i)[5] %></td>				
					<td><%=list.get(i)[6] %></td>				
				</tr>
				<%} %>
			</table>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>