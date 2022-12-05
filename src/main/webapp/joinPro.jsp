<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");
	
	try{
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");
		System.out.println("DB");
		
		String sql = "insert into member_tbl_02 values (?,?,?,?,?,?,?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, request.getParameter("custno"));
		ps.setString(2, request.getParameter("custname"));
		ps.setString(3, request.getParameter("phone"));
		ps.setString(4, request.getParameter("address"));
		ps.setString(5, request.getParameter("joindate"));
		ps.setString(6, request.getParameter("grade"));
		ps.setString(7, request.getParameter("city"));
		
		ps.executeUpdate();
		
		con.close();
		ps.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("index.jsp");
%>
