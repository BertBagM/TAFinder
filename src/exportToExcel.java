import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class exportToExcel {

	ArrayList<teachingAssistant> TAList = new ArrayList<teachingAssistant>();
	static ArrayList<Lab> labInfoList = new ArrayList<Lab>();
	static String inFile = "COSC 310 - Term 2 Course  and TA spreadsheet.xlsx";
	static String outFile = "TA spreadsheet.xlsx";
	static String headers = "Instructor Name	Subject	Course		Sec No	Term	Act Type	Days Met	Start Time	End time	TA Name		Hours per week			U/G		Est. Enrol	Release	Enrolment	Building	Room	Cap";

	public static void main(String[] args) {

		ImportLabDataIntoArrayLists(inFile);

		// assignTAtoLab();

		ExportDataToExcel(outFile);

	}

	/*
	 * private static void assignTAtoLab() {
	 * 
	 * 
	 * }
	 * 
	 */

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

				Lab labInfo = new Lab();
				while (cellIterator.hasNext()) {

					Cell cell = (Cell) cellIterator.next();

					if (cell.getColumnIndex() == 0) {
						String check;
						check = cell.getStringCellValue();
						if (check.equals(null)) {
							break;
						}
						labInfo.instructor = check;

					} else if (cell.getColumnIndex() == 1) {
						labInfo.subject = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 2) {

						Integer cNo = 0;
						try {

							cNo = (int) cell.getNumericCellValue();
						} catch (Exception e) {

						}
						labInfo.courseNo = cNo;

						// column D is empty
					} else if (cell.getColumnIndex() == 4) {

						String sNo;
						try {
							sNo = Double.toString(cell.getNumericCellValue());
						} catch (Exception e) {
							sNo = cell.getStringCellValue();
						}
						labInfo.secNo = sNo;

					} else if (cell.getColumnIndex() == 5) {

						Integer tNo = 0;
						try {

							tNo = (int) cell.getNumericCellValue();
						} catch (Exception e) {

						}

						labInfo.term = tNo;

					} else if (cell.getColumnIndex() == 6) {

						labInfo.activity = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 7) {

						labInfo.days = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 8) {

						String sTime = "";

						try {
							sTime = cell.getDateCellValue().toString();
							sTime = sTime.replace("Sun Dec 31 ", "");
							sTime = sTime.replace(" PST 1899", "");
						} catch (Exception e) {
						}

						labInfo.startTime = sTime;

					} else if (cell.getColumnIndex() == 9) {

						String eTime = "";

						try {
							eTime = cell.getDateCellValue().toString();
							eTime = eTime.replace("Sun Dec 31 ", "");
							eTime = eTime.replace(" PST 1899", "");
						} catch (Exception e) {
						}
						labInfo.endTime = eTime;

					} else if (cell.getColumnIndex() == 12) {

						labInfo.cM = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 13) {

						labInfo.cN = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 14) {

						labInfo.cO = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 16) { // Q

						int hNo;
						try {
							hNo = (int) cell.getNumericCellValue();
							labInfo.hours = hNo;

						} catch (Exception e) {
						}
					} else if (cell.getColumnIndex() == 17) {

						try {
							labInfo.cR = (int) cell.getNumericCellValue();
						} catch (Exception e) {

						}

					} else if (cell.getColumnIndex() == 18) {
						try {
							labInfo.cS = (int) cell.getNumericCellValue();
						} catch (Exception e) {

						}
					} else if (cell.getColumnIndex() == 19) {

						try {
							labInfo.cT = (int) cell.getNumericCellValue();
						} catch (Exception e) {

						}

					} else if (cell.getColumnIndex() == 20) {

						try {
							labInfo.cU = cell.getStringCellValue();
						} catch (Exception e) {

						}

					} else if (cell.getColumnIndex() == 21) {
						try {
							labInfo.cV = (int) cell.getNumericCellValue();
						} catch (Exception e) {

						}

					} else if (cell.getColumnIndex() == 22) {

						try {
							labInfo.cW = (int) cell.getNumericCellValue();
						} catch (Exception e) {

						}

					}
				}
				labInfoList.add(labInfo);
			}

			workbook.close();
		} catch (

		IOException e)

		{
			e.printStackTrace();
		}

		System.out.println("Excel Data Imported");

	}

	@SuppressWarnings("resource")
	private static void ExportDataToExcel(String outFile) {
		Workbook workbook = new XSSFWorkbook();
		try {
			Sheet ProductSheet = workbook.createSheet();
			int rowIndex = 0;

			for (Lab L : labInfoList) {
				Row row = ProductSheet.createRow(rowIndex++);
				row.createCell(0).setCellValue(L.instructor);
				row.createCell(1).setCellValue(L.subject);
				row.createCell(2).setCellValue(L.courseNo);
				row.createCell(3).setCellValue(L.cD);
				row.createCell(4).setCellValue(L.secNo);
				row.createCell(5).setCellValue(L.term);
				row.createCell(6).setCellValue(L.activity);
				row.createCell(7).setCellValue(L.days);
				row.createCell(8).setCellValue(L.startTime);
				row.createCell(9).setCellValue(L.endTime);
				row.createCell(10).setCellValue(L.taFirst);
				row.createCell(11).setCellValue(L.taLast);
				row.createCell(12).setCellValue(L.cM);
				row.createCell(13).setCellValue(L.cN);
				row.createCell(14).setCellValue(L.cO);
				row.createCell(15).setCellValue(L.taEducation);
				row.createCell(16).setCellValue(L.hours);
				row.createCell(17).setCellValue(L.cR);
				row.createCell(18).setCellValue(L.cS);
				row.createCell(19).setCellValue(L.cT);
				row.createCell(20).setCellValue(L.cU);
				row.createCell(21).setCellValue(L.cV);
				row.createCell(22).setCellValue(L.cW);

			}

		} catch (Exception e) {
		}

		try {
			FileOutputStream fos = new FileOutputStream(outFile);

			workbook.write(fos);

			fos.close();

			System.out.println(outFile + " is successfully written");
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}

	}
}
