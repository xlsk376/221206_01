<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

		String[] data = new String[7];
	try{
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");
		System.out.println("DB");
		
		request.setCharacterEncoding("utf-8");
		int custno = Integer.parseInt(request.getParameter("custno"));
		
		String sql = "select custno, custname, phone, address, to_char(joindate, 'yyyymmdd'), grade, city from member_tbl_02";
		sql += " where custno="+custno;
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		if(rs.next()){
			data[0] = rs.getString(1);
			data[1] = rs.getString(2);
			data[2] = rs.getString(3);
			data[3] = rs.getString(4);
			data[4] = rs.getString(5);
			data[5] = rs.getString(6);
			data[6] = rs.getString(7);
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
</style>
<script type="text/javascript">
	function checkVal(){
		if(!document.u_data.custno.value){
			alert("회원번호 입력");
			document.u_data.custno.focus();
			return false;
		}else if(!document.u_data.custname.value){
			alert("회원이름 입력");
			document.u_data.custname.focus();
			return false;
		}else if(!document.u_data.phone.value){
			alert("회원전화 입력");
			document.u_data.phone.focus();
			return false;
		}else if(document.getElementsByName("address")[0].checked == false&&
				document.getElementsByName("address")[1].checked == false&&
				document.getElementsByName("address")[2].checked == false){
			alert("통신사 선택");
			return false;
		}else if(!document.u_data.joindate.value){
			alert("가입일자 입력");
			document.u_data.joindate.focus();
			return false;
		}else if(!document.u_data.grade.value){
			alert("고객등급 입력");
			document.u_data.grade.focus();
			return false;
		}else if(!document.u_data.city.value){
			alert("도시코드 입력");
			document.u_data.city.focus();
			return false;
		}else{
			alert("수정이 완료되었습니다");
			document.getElementById("u_data").submit();
		}
	}
</script>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_nav.jsp"></jsp:include>
	<div class="section">
		<h3 class="title">홈쇼핑 회원 등록</h3>
		<form id="u_data" name="u_data" method="post" action="memberUpdatePro.jsp" onsubmit="return false">
			<table class="table" border="1">
				<tr>
					<td>회원번호</td>
					<td>
						<input type="text" name="custno" value="<%=data[0] %>" readonly>
					</td>
				</tr>
				<tr>
					<td>회원성명</td>
					<td>
						<input type="text" name="custname" value="<%=data[1] %>">
					</td>
				</tr>
				<tr>
					<td>회원전화</td>
					<td>
						<input type="text" name="phone" value="<%=data[2] %>">
					</td>
				</tr>
				<tr>
					<td>통신사[SK, KT, LG]</td>
					<td>
					<%if(data[3].equals("SK")){%>
						<input type="radio" name="address" value="SK" checked>SK
					<%}else{ %>
						<input type="radio" name="address" value="SK">SK
					<%} %>	
					<%if(data[3].equals("KT")){%>
						<input type="radio" name="address" value="KT" checked>KT
					<%}else{ %>
						<input type="radio" name="address" value="KT">KT
					<%} %>	
					<%if(data[3].equals("LG")){%>
						<input type="radio" name="address" value="LG" checked>LG
					<%}else{ %>
						<input type="radio" name="address" value="LG">LG
					<%} %>	
					</td>
				</tr>
				<tr>
					<td>가입일자</td>
					<td>
						<input type="text" name="joindate" value="<%=data[4] %>">
					</td>
				</tr>
				<tr>
					<td>고객등급[A:VIP,B:일반,C:직원]</td>
					<td>
						<input type="text" name="grade" value="<%=data[5] %>">
					</td>
				</tr>
				<tr>
					<td>도시코드</td>
					<td>
						<input type="text" name="city" value="<%=data[6] %>">
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<button onclick="checkVal()">수정</button>
						<button onclick="location.href='memberList.jsp'">조회</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>