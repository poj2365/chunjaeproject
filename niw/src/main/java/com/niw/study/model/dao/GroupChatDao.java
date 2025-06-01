package com.niw.study.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.niw.common.JDBCTemplate;
import com.niw.study.model.dto.Message;

public enum GroupChatDao {
	DAO;
	
	private Properties sql = new Properties();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	{
		String path = GroupChatDao.class.getResource("/sql/study_sql.properties").getPath();
		try (FileReader fr = new FileReader(path)) {
			sql.load(fr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<Message> searchGroupChat(Connection conn, String groupNumber) {
		List<Message> msgList = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("searchGroupChat"));
			pstmt.setInt(1, Integer.parseInt(groupNumber));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				msgList.add(getMessage(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return msgList;
	}

	Message getMessage(ResultSet rs) throws SQLException {
		return Message.builder()
				.chatId(rs.getInt("chat_id"))
				.type(rs.getString("type"))
				.sender(rs.getString("sender"))
				.message(rs.getString("message"))
				.groupNumber(rs.getInt("group_number"))
				.sendTime(rs.getTimestamp("send_time"))
				.build();
	}
	
	public int insertGroupChat(Connection conn, Message msg) {
		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertGroupChat"));
			pstmt.setString(1, msg.getType());
			pstmt.setInt(2, msg.getGroupNumber());
			pstmt.setString(3, msg.getSender());
			pstmt.setString(4, msg.getMessage());
			pstmt.setTimestamp(5, msg.getSendTime());
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

}

