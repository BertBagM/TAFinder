import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.json.simple.parser.ParseException;

public class createLabsInDb {

	// create arrays for all the excel data

	static ArrayList<String> instructor;
	static ArrayList<String> subject;
	static ArrayList<String> courseNo;
	static ArrayList<String> secNo;
	static ArrayList<Integer> term;
	static ArrayList<String> activity;
	static ArrayList<String> days;
	static ArrayList<Double> startTime;
	static ArrayList<Double> endTime; // might be weird / time

	ArrayList<lab> Labs;

	static Connection con;

	public static void main(String[] args) {

		String fileName = "COSC 310 - Term 2 Course  and TA spreadsheet.xlsx";

		openSqlConnection();

		ImportLabDataIntoArrayLists(fileName);
		
		dropLabTable();
		
		createLab();
		
		ImportLabDataIntoDb();

	}

// opens sql connection to the cosc 304 database using bretts credentials
	
	private static void openSqlConnection() {
		try {
			con = ConnectionManager.open();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	// inserts data into lab table

	private static void ImportLabDataIntoDb() {
		String sql = "INSERT INTO lab(instructor , subject , courseNo, secNo, term, activity, days, startTime, endTime) "
				+ "Values (?, ?, ?,?,?,?,?,?,?);";
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql);
			for (int i = 0; i < instructor.size(); i++) {

				pstmt.setString(1, instructor.get(i));
				pstmt.setString(2, subject.get(i));
				pstmt.setString(3, courseNo.get(i));
				pstmt.setString(4, secNo.get(i));
				pstmt.setInt(5, term.get(i));
				pstmt.setString(6, activity.get(i));
				pstmt.setString(7, days.get(i));
				pstmt.setDouble(8, startTime.get(i));
				pstmt.setDouble(9, endTime.get(i));
				pstmt.executeUpdate();

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// creates lab table
	private static void createLab() {

		String sql = "CREATE TABLE lab (instructor varChar(30), subject varChar(30), courseNo varChar(30), secNo varChar(30), term integer, activity varChar(30), days varChar(30),startTime Time, endTime Time);";
		Statement stmt = null;
		try {
			stmt = con.createStatement();
			stmt.execute(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// drops lab table if it exists
	private static void dropLabTable() {
		String sql = "DROP TABLE lab;";
		Statement stmt = null;
		try {
			stmt = con.createStatement();
			stmt.execute(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private static void ImportLabDataIntoArrayLists(String fileName) {
		// TODO Auto-generated method stub

		
	}

}
