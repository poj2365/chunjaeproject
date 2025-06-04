package com.niw.instructor.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.niw.instructor.model.Enums.ApplicationStatus;
import com.niw.instructor.model.dto.ApplicationReview;
import com.niw.instructor.model.dto.InstructorApplication;
import com.niw.instructor.model.dto.PortfolioFile;

public enum InstructorApplicationDao {
	DAO;

	private Properties sqlProp = new Properties();

	{
		String path = InstructorApplicationDao.class.getResource("/sql/instructor_sql.properties").getPath();
		try (FileReader fr = new FileReader(path)) {
			sqlProp.load(fr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int instructorApply(Connection conn, InstructorApplication instructorApplication) {
		int result = 0;

		try (PreparedStatement pstmt1 = conn.prepareStatement(sqlProp.getProperty("instructApply"),
				new String[] {"APPLICATION_ID"});
				PreparedStatement pstmt2 = conn.prepareStatement(sqlProp.getProperty("insertPortfolioFile"))) {
			pstmt1.setString(1, instructorApplication.userId());
			pstmt1.setString(2, instructorApplication.instructorName());
			pstmt1.setString(3, instructorApplication.bankName());
			pstmt1.setString(4, instructorApplication.accountHolder());
			pstmt1.setString(5, instructorApplication.accountNumber());
			pstmt1.setString(6, instructorApplication.introduction());
			pstmt1.setString(7,
					String.join(",", instructorApplication.porfolioFiles().stream().map(e -> e.filePath()).toList()));
			pstmt1.executeUpdate();

			int applicationId = 0;
			try (ResultSet rs = pstmt1.getGeneratedKeys()) {
				if (rs.next())
					applicationId = rs.getInt(1);
			}
			List<PortfolioFile> portfolioFiles = instructorApplication.porfolioFiles();
			if (portfolioFiles != null && !portfolioFiles.isEmpty()) {
				for (PortfolioFile p : portfolioFiles) {
					pstmt2.setInt(1, applicationId);
					pstmt2.setString(2, p.originalFileName());
					pstmt2.setString(3, p.storedFilename());
					pstmt2.setString(4, p.filePath());
					pstmt2.setInt(5, p.fileSize());
					pstmt2.setString(6, p.fileType());
					pstmt2.setString(7, p.fileExtension());
					pstmt2.executeUpdate();

				}
			}
			result=1;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;

	}

	public InstructorApplication getInstructorApplication(ResultSet rs) throws SQLException {
		int applicationId = rs.getInt("APPLICATION_ID");
		String userId = rs.getString("USER_ID");
		String instructorName = rs.getString("INSTRUCTOR_NAME");
		String bankName = rs.getString("BANK_NAME");
		String accountHolder = rs.getString("ACCOUNT_HOLDER");
		String accountNumber = rs.getString("ACCOUNT_NUMBER");
		String introduction = rs.getString("INTRODUCTION");
		List<PortfolioFile> portfolioFiles = new ArrayList<>();
		String rawFiles = rs.getString("PORTFOLIO_FILES");

		if (rawFiles != null && !rawFiles.trim().isEmpty()) {
			String[] filePaths = rawFiles.split(",");
			for (String path : filePaths) {
				PortfolioFile file = new PortfolioFile(0, applicationId, null, null, path, 0, null, null, null);
				portfolioFiles.add(file);
			}
		}

		ApplicationStatus applicationStatus = ApplicationStatus.valueOf(rs.getString("APPLICATION_STATUS"));
		Date applicationDate = rs.getDate("APPLICATION_DATE");
		Date updateDate = rs.getDate("UPDATE_DATE");

		return new InstructorApplication(applicationId, userId, instructorName, bankName, accountHolder, accountNumber,
				introduction, portfolioFiles, applicationStatus, applicationDate, updateDate);
	}
	public List<InstructorApplication> getApplicationList(Connection conn, int startRow, int endRow) {
	    List<InstructorApplication> applications = new ArrayList<>();
	    try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getApplicationList"))) {
	        pstmt.setInt(1, endRow);
	        pstmt.setInt(2, startRow);
	        
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                applications.add(getInstructorApplication(rs));
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return applications;
	}

	/**
	 * 상태별 신청서 목록 조회 (페이징)
	 */
	public List<InstructorApplication> getApplicationListByStatus(Connection conn, String status, int startRow, int endRow) {
	    List<InstructorApplication> applications = new ArrayList<>();
	    try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getApplicationListByStatus"))) {
	        pstmt.setString(1, status);
	        pstmt.setInt(2, endRow);
	        pstmt.setInt(3, startRow);
	        
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                applications.add(getInstructorApplication(rs));
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return applications;
	}

	/**
	 * 전체 신청서 개수 조회
	 */
	public int getTotalApplicationCount(Connection conn) {
	    int count = 0;
	    try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getTotalApplicationCount"))) {
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                count = rs.getInt(1);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return count;
	}


	public int getTotalCountByStatus(Connection conn, String status) {
	    int count = 0;
	    try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getTotalCountByStatus"))) {
	        pstmt.setString(1, status);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                count = rs.getInt(1);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return count;
	}


	public InstructorApplication getApplicationById(Connection conn, int applicationId) {
	    InstructorApplication application = null;
	    try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getApplicationById"))) {
	        pstmt.setInt(1, applicationId);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                application = getInstructorApplication(rs);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return application;
	}


	public List<PortfolioFile> getPortfolioFilesByApplicationId(Connection conn, int applicationId) {
	    List<PortfolioFile> files = new ArrayList<>();
	    try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getPortfolioFilesByApplicationId"))) {
	        pstmt.setInt(1, applicationId);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                files.add(getPortfolioFile(rs));
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return files;
	}


	public int updateApplicationStatus(Connection conn, int applicationId, ApplicationStatus newStatus) {
	    int result = 0;
	    try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("updateApplicationStatus"))) {
	        pstmt.setString(1, newStatus.name());
	        pstmt.setInt(2, applicationId);
	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return result;
	}


	public int updateUserRole(Connection conn, String userId) {
	    int result = 0;
	    try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("updateUserRole"))) {
	        pstmt.setString(1, userId);
	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return result;
	}


	public int insertApplicationReview(Connection conn, ApplicationReview review) {
	    int result = 0;
	    try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("insertApplicationReview"))) {
	        pstmt.setInt(1, review.applicationId());
	        pstmt.setString(2, review.previousStatus().name());
	        pstmt.setString(3, review.newStatus().name());
	        pstmt.setString(4, review.reviewerId());
	        pstmt.setString(5, review.reviewComment());
	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return result;
	}

	private PortfolioFile getPortfolioFile(ResultSet rs) throws SQLException {
	    return new PortfolioFile(
	        rs.getInt("PORTFOLIO_ID"),
	        rs.getInt("APPLICATION_ID"),
	        rs.getString("ORIGINAL_FILE_NAME"),
	        rs.getString("STORED_FILENAME"),
	        rs.getString("FILE_PATH"),
	        rs.getInt("FILE_SIZE"),
	        rs.getString("FILE_TYPE"),
	        rs.getString("FILE_EXTENSION"),
	        rs.getDate("UPLOAD_DATE")
	    );
	}
	
}
