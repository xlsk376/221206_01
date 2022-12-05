<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = 0;
	ArrayList<String> list = new ArrayList<>();

	try{
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");
		System.out.println("DB");
		
		String sql = "select max(custno) from member_tbl_02";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
			String data = rs.getString(1);
			list.add(data);
		}
		num = Integer.parseInt(list.get(0));
		num += 1;
		
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
		if(!document.data.custno.value){
			alert("회원번호 입력");
			document.data.custno.focus();
			return false;
		}else if(!document.data.custname.value){
			alert("회원이름 입력");
			document.data.custname.focus();
			return false;
		}else if(!document.data.phone.value){
			alert("회원전화 입력");
			document.data.phone.focus();
			return false;
		}else if(document.getElementsByName("address")[0].checked == false&&
				document.getElementsByName("address")[1].checked == false&&
				document.getElementsByName("address")[2].checked == false){
			alert("통신사 선택");
			return false;
		}else if(!document.data.joindate.value){
			alert("가입일자 입력");
			document.data.joindate.focus();
			return false;
		}else if(!document.data.grade.value){
			alert("고객등급 입력");
			document.data.grade.focus();
			return false;
		}else if(!document.data.city.value){
			alert("도시코드 입력");
			document.data.city.focus();
			return false;
		}else{
			document.getElementById("data").submit();
		}
	}
</script>
<body>
	<jsp:include page="_header.jsp"></jsp:include>
	<jsp:include page="_nav.jsp"></jsp:include>
	<div class="section">
		<h3 class="title">홈쇼핑 회원 등록</h3>
		<form id="data" name="data" method="post" action="joinPro.jsp" onsubmit="return false">
			<table class="table" border="1">
				<tr>
					<td>회원번호</td>
					<td>
						<input type="text" name="custno" value="<%=num %>" readonly>
					</td>
				</tr>
				<tr>
					<td>회원성명</td>
					<td>
						<input type="text" name="custname">
					</td>
				</tr>
				<tr>
					<td>회원전화</td>
					<td>
						<input type="text" name="phone">
					</td>
				</tr>
				<tr>
					<td>통신사[SK, KT, LG]</td>
					<td>
						<input type="radio" name="address" value="SK">SK
						<input type="radio" name="address" value="KT">KT
						<input type="radio" name="address" value="LG">LG
					</td>
				</tr>
				<tr>
					<td>가입일자</td>
					<td>
						<input type="text" name="joindate">
					</td>
				</tr>
				<tr>
					<td>고객등급[A:VIP,B:일반,C:직원]</td>
					<td>
						<input type="text" name="grade">
					</td>
				</tr>
				<tr>
					<td>도시코드</td>
					<td>
						<input type="text" name="city">
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<button onclick="checkVal()">등록</button>
						<button onclick="location.href='memberList.jsp'">조회</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>