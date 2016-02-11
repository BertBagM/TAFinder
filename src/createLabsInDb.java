import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.parser.ParseException;

/*
 * Creates Labs in databases
 * Imports file from ashlees ta File
 * My credentials are in the connection managaer if you want to log into sqrl etc to check
 * 
 * 
 * Issues : 
 * Start / endtime are in doubles, need to be changed to time.
 * Set to doubles for error checking
 * Unknown if course/sec number need to be an integer
 * Having issues with "extra labs"
 * Attempting to deal with it during data - > database insertions unfinished
 * 
 * Last update 6:30 Feb 10 
 * Brett M
 */

public class createLabsInDb {

	// create arrays for all the excel data

	static ArrayList<String> instructor = new ArrayList<String>();
	static ArrayList<String> subject = new ArrayList<String>();
	static ArrayList<String> courseNo = new ArrayList<String>();
	static ArrayList<String> secNo = new ArrayList<String>();
	static ArrayList<String> term = new ArrayList<String>();
	static ArrayList<String> activity = new ArrayList<String>();
	static ArrayList<String> days = new ArrayList<String>();
	static ArrayList<String> startTime = new ArrayList<String>();
	static ArrayList<String> endTime = new ArrayList<String>(); // might be
																// weird / time

	ArrayList<lab> Labs;

	static Connection con;

	public static void main(String[] args) {

		String fileName = "COSC 310 - Term 2 Course  and TA spreadsheet.xlsx";

		openSqlConnection();

		ImportLabDataIntoArrayLists(fileName);

		dropLabTable();

		createLab();

		ImportLabDataIntoDb();

		System.out.println("finshed loading labs into db");

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

				// need to make a method for this

				if (instructor.get(i).equals("Instructor Name")) {
					i++;
				}

				if (subject.get(i).equals("Subject")) {
					i++;
				}
				if (subject.get(i).equals("")) {
					i++;
				}

				if (activity.get(i).equals("")) {
					i++;
				}

				if (instructor.get(i).equals("")) {
					i++;
				}

				if (instructor.get(i).equals("")) {
					i++;
				}

				// to here

				pstmt.setString(1, instructor.get(i));
				pstmt.setString(2, subject.get(i));
				pstmt.setString(3, courseNo.get(i));
				pstmt.setString(4, secNo.get(i));
				pstmt.setString(5, term.get(i));
				pstmt.setString(6, activity.get(i));
				pstmt.setString(7, days.get(i));
				pstmt.setString(8, startTime.get(i));
				pstmt.setString(9, endTime.get(i));
				pstmt.executeUpdate();

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// creates lab table
	private static void createLab() {

		String sql = "CREATE TABLE lab (instructor varChar(30), subject varChar(30), courseNo varChar(30), secNo varChar(30), term varChar(4), activity varChar(30), days varChar(30),startTime varChar(30), endTime varChar(30));";
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

	// iterates through excel work book and imports data into arrayLists
	private static void ImportLabDataIntoArrayLists(String fileName) {
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(fileName);

			Workbook workbook = new XSSFWorkbook(fis);

			int i = 0; // for now
			Sheet sheet = workbook.getSheetAt(i);

			Iterator<?> rowIterator = sheet.iterator();

			while (rowIterator.hasNext()) {
				Row row = (Row) rowIterator.next();

				Iterator<?> cellIterator = row.cellIterator();

				while (cellIterator.hasNext()) {

					Cell cell = (Cell) cellIterator.next();

					if (cell.getColumnIndex() == 0) {
						String check;
						check = cell.getStringCellValue();
						if (check.equals(null)) {
							break;
						}
						instructor.add(check);

					} else if (cell.getColumnIndex() == 1) {
						subject.add(cell.getStringCellValue());

					} else if (cell.getColumnIndex() == 2) {

						String course;
						try {
							course = Double.toString(cell.getNumericCellValue());
						} catch (Exception e) {
							course = cell.getStringCellValue();
						}

						courseNo.add(course);

					} else if (cell.getColumnIndex() == 4) {

						String sNo;
						try {
							sNo = Double.toString(cell.getNumericCellValue());
						} catch (Exception e) {
							sNo = cell.getStringCellValue();
						}
						secNo.add(sNo);

					} else if (cell.getColumnIndex() == 5) {

						String sNo;
						try {
							sNo = Double.toString(cell.getNumericCellValue());
						} catch (Exception e) {
							sNo = cell.getStringCellValue();
						}

						term.add(sNo);

					} else if (cell.getColumnIndex() == 6) {

						activity.add(cell.getStringCellValue());

					} else if (cell.getColumnIndex() == 7) {

						days.add(cell.getStringCellValue());

					} else if (cell.getColumnIndex() == 8) {

						String sNo;
						try {
							sNo = Double.toString(cell.getNumericCellValue());
						} catch (Exception e) {
							sNo = cell.getStringCellValue();
						}

						startTime.add(sNo);

					} else if (cell.getColumnIndex() == 9) {

						String sNo;
						try {
							sNo = Double.toString(cell.getNumericCellValue());
						} catch (Exception e) {
							sNo = cell.getStringCellValue();
						}

						endTime.add(sNo);

					}
					// gonna need to deal with hours at a later date
					else if (cell.getColumnIndex() == 11) {

					}

				}
			}
			workbook.close();
		} catch (

		IOException e)

		{
			e.printStackTrace();
		}

	}

}