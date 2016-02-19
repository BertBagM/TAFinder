import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.simple.parser.ParseException;

/*
 * 
 * Any modifcations should go in "printLabDataToHTML"
 * 
 * How to use:
 * 
 * Run
 * Crtl+A from console
 * Paste in notepad ++
 * Ctrl-F
 * Replace all * with "
 * 
 * 
 * Any problems, ask Brett
 */
public class LazyHTMLForm {

	static Connection con;

	String FileName = "ApplicationFormHtml";
	static ArrayList<Lab> labList = new ArrayList<Lab>();

	public static void main(String[] args) {

		openSqlConnection();

		getLabData();

		printLabDataToHTML();
	}

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

	private static void getLabData() {

		String sql = "SELECT * FROM lab;";
		PreparedStatement pstmt = null;
		ResultSet rst = null;
		try {
			pstmt = con.prepareStatement(sql);
			rst = pstmt.executeQuery();
			while (rst.next()) {
				Lab newLab = new Lab();
				newLab.instructor = rst.getString(1);
				newLab.subject = rst.getString(2);
				newLab.courseNo = rst.getInt(3);
				newLab.secNo = rst.getString(4);
				newLab.term = rst.getInt(5);
				newLab.activity = rst.getString(6);
				newLab.days = rst.getString(7);
				newLab.startTime = rst.getString(8);
				newLab.endTime = rst.getString(9); // might be weird / time
				newLab.hours = rst.getInt(10);
				labList.add(newLab);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void printLabDataToHTML() {

		String unique = null;

		System.out.println(
				"<!DOCTYPE html><html lang=*en*><head><meta charset=*UTF-8*><title>Teacher Assistant Application Page</title></head><body>");

		System.out.println("<form action=*action_page.php*>");
		System.out.println("<input name = *" + "studentNum" + "* type=*text* Value = *student number*> <br>");

		for (Lab L : labList) {

			// unused atm
			if (L.subject != unique) {
				unique = L.subject;
				// System.out.println("<p> Subject Course# Activity Type
				// LabNumber Days Time hours a week</p>");

			}

			System.out.println(
					"<input name = *" + L.subject + "-" + L.courseNo + "-" + L.secNo + "* type=*radio*> Course Name: "
							+ L.subject + " " + L.courseNo + " Activiy Type: " + L.activity + " Time : " + L.startTime
							+ "-" + L.endTime + " Days: " + L.days + " Term :" + L.term + " Hours a week : " + L.hours);

			System.out.println("<input name = *" + L.subject + "-" + L.courseNo + "-" + L.secNo
					+ ".GPA* type=*text* Value = *Grade obtained*>");

			System.out.println("<br>");

		}
		System.out.println("<input type=*submit* value=*Submit*>");
		System.out.println("</form>");
		System.out.println("</body></html>");
	}

}
