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
 * This program builds the "Lab" table from excel data. As long as input is in the same format as the original
 * spreadsheet. 
 * 
 * 
 * Last update Feb 11 
 * Brett M
 */

public class createLabsInDb {

	// create arrays for all the excel data

	static ArrayList<String> instructor = new ArrayList<String>();
	static ArrayList<String> subject = new ArrayList<String>();
	static ArrayList<Integer> courseNo = new ArrayList<Integer>();
	static ArrayList<String> secNo = new ArrayList<String>();
	static ArrayList<Integer> term = new ArrayList<Integer>();
	static ArrayList<String> activity = new ArrayList<String>();
	static ArrayList<String> days = new ArrayList<String>();
	static ArrayList<String> startTime = new ArrayList<String>();
	static ArrayList<String> endTime = new ArrayList<String>();
	static ArrayList<String> hours = new ArrayList<String>();

	static Connection con;

	public static void main(String[] args) {

		try {

			String fileName = "COSC 310 - Term 2 Course  and TA spreadsheet.xlsx";

			openSqlConnection();

			ImportLabDataIntoArrayLists(fileName);

			dropLabTable();

			createLab();

			ImportLabDataIntoDb();

			System.out.println("Finshed loading labs into db");

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
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
		String sql = "INSERT INTO lab(instructor , subject , courseNo, secNo, term, activity, days, startTime, endTime, hours) "
				+ "Values (?, ?, ?,?,?,?,?,?,?,?);";
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql);
			for (int i = 0; i < instructor.size(); i++) {
				Boolean valid = false;

				// filters and removes all the "extras"
				while (!valid) {
					if (!hours.get(i).equals("0.0") && !activity.get(i).equals("LEC") && term.get(i) > 0) {
						valid = true;
					} else {
						i++;
					}

				}

				pstmt.setString(1, instructor.get(i));
				pstmt.setString(2, subject.get(i));
				pstmt.setInt(3, courseNo.get(i));
				pstmt.setString(4, secNo.get(i));
				pstmt.setInt(5, term.get(i));
				pstmt.setString(6, activity.get(i));
				pstmt.setString(7, days.get(i));
				pstmt.setString(8, startTime.get(i));
				pstmt.setString(9, endTime.get(i));
				pstmt.setString(10, hours.get(i));
				pstmt.executeUpdate();

			}

		} catch (Exception e) {
			// e.printStackTrace();
		}

	}

	// creates lab table
	private static void createLab() {

		String sql = "CREATE TABLE lab (instructor varChar(30), subject varChar(30), courseNo Integer, secNo varChar(30), term Integer, activity varChar(30), days varChar(30),startTime varChar(30), endTime varChar(30), hours Double);";
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

						Integer cNo = 0;
						;
						try {

							cNo = (int) cell.getNumericCellValue();
						} catch (Exception e) {

						}
						courseNo.add(cNo);

					} else if (cell.getColumnIndex() == 4) {

						String sNo;
						try {
							sNo = Double.toString(cell.getNumericCellValue());
						} catch (Exception e) {
							sNo = cell.getStringCellValue();
						}
						secNo.add(sNo);

					} else if (cell.getColumnIndex() == 5) {

						Integer tNo = 0;
						;
						try {

							tNo = (int) cell.getNumericCellValue();
						} catch (Exception e) {

						}

						term.add(tNo);

					} else if (cell.getColumnIndex() == 6) {

						activity.add(cell.getStringCellValue());

					} else if (cell.getColumnIndex() == 7) {

						days.add(cell.getStringCellValue());

					} else if (cell.getColumnIndex() == 8) {

						String sTime = "";

						try {
							sTime = cell.getDateCellValue().toString();
							sTime = sTime.replace("Sun Dec 31 ", "");
							sTime = sTime.replace(" PST 1899", "");
						} catch (Exception e) {
						}

						startTime.add(sTime);

					} else if (cell.getColumnIndex() == 9) {

						String eTime = "";

						try {
							eTime = cell.getDateCellValue().toString();
							eTime = eTime.replace("Sun Dec 31 ", "");
							eTime = eTime.replace(" PST 1899", "");
						} catch (Exception e) {
						}
						endTime.add(eTime);

					}

					else if (cell.getColumnIndex() == 16) {

						String hNo;
						try {
							hNo = Double.toString(cell.getNumericCellValue());
						} catch (Exception e) {
							hNo = cell.getStringCellValue();
						}

						hours.add(hNo);
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