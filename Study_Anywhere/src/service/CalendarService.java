package service;

import static db.JDBCUtil.close;
import static db.JDBCUtil.getConnection;

import java.sql.Connection;

import org.json.simple.JSONArray;

import dao.CalendarDAO;

public class CalendarService {
	
	
	public int addEvent(String title,String start, String end) {

		CalendarDAO calendarDAO = CalendarDAO.getInstance();
		Connection con = getConnection();
		calendarDAO.setConnection(con);
		
		int result = calendarDAO.addEvent(title,start,end);
		
		
		close(con);
		
		return result;
	}
	
	public boolean removeEvent(String calnum) {

		CalendarDAO calendarDAO = CalendarDAO.getInstance();
		Connection con = getConnection();
		calendarDAO.setConnection(con);
		
		int result = calendarDAO.removeEvent(calnum);
		
		boolean flag = false;
		if(result==1) {
			flag = true;
		}
		
		
		close(con);
		
		return flag;
	}
	
	public boolean modifyEvent(String calnum, String title, String start, String end) {

		CalendarDAO calendarDAO = CalendarDAO.getInstance();
		Connection con = getConnection();
		calendarDAO.setConnection(con);
		
		int result = calendarDAO.modifyEvent(calnum, title, start, end);
		
		boolean flag = false;
		if(result==1) {
			flag = true;
		}
		
		
		close(con);
		
		return flag;
	}
	
	public JSONArray getAllEvent() {

		CalendarDAO calendarDAO = CalendarDAO.getInstance();
		Connection con = getConnection();
		calendarDAO.setConnection(con);
		
		JSONArray result = calendarDAO.getAllEvent();
		
		
		
		close(con);
		
		return result;
	}
	
}