<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	try{
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");
		System.out.println("DB check");
		
		request.setCharacterEncoding("utf-8");
		System.out.println(request.getParameter("custno"));
		System.out.println(request.getParameter("custname"));
		System.out.println(request.getParameter("phone"));
		System.out.println(request.getParameter("address"));
		System.out.println(request.getParameter("joindate"));
		System.out.println(request.getParameter("grade"));
		System.out.println(request.getParameter("city"));
		
		String sql = "update member_tbl_02 set custname=?, phone=?, address=?, joindate=?, grade=?, city=? ";
		sql += " where custno="+Integer.parseInt(request.getParameter("custno"));

		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, request.getParameter("custname"));
		ps.setString(2, request.getParameter("phone"));
		ps.setString(3, request.getParameter("address"));
		ps.setString(4, request.getParameter("joindate"));
		ps.setString(5, request.getParameter("grade"));
		ps.setString(6, request.getParameter("city"));
		
		ps.executeUpdate();
		
		con.close();
		ps.close();
		
		response.sendRedirect("memberList.jsp");
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>
