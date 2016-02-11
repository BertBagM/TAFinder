import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

// iunno wtf + means, so it gets set to 100 for inventory
// 
public class WriteToCSV {
	public static void mainNOT(String[] args) {

		// gravCYC
		String fileName = "GraveyardCYC.xlsx";// graveyard handles
		// ArrayList<String[]> handles = getHandles("getHandles.xlsx");
		ArrayList<String[]> handles = getHandles(fileName);
		Hashtable<Double, Product> CYCInv = createCYCInventory("CYC776_DealerPrice.csv.xlsx");
		System.out.println("Inv");
		ArrayList<Product> products = getProducts(handles, CYCInv);
		writeCSV(products, fileName);

		// sportCYC
		/*
		 * //fileName = "EverythingSportsterCYC.xlsx"; //ArrayList<String[]>
		 * handles = getHandles(fileName); //Hashtable<Double, Product> CYCInv =
		 * //ArrayList<Product> products = getProducts(handles, CYCInv);
		 * //writeCSV(products, fileName
		 */
	}

	// returns an arrayList of Handles
	private static ArrayList<String[]> getHandles(String fileName) {

		ArrayList<String[]> handles = new ArrayList<String[]>();
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(fileName);

			Workbook workbook = new XSSFWorkbook(fis);

			int i = 0; // for now...
			Sheet sheet = workbook.getSheetAt(i);

			Iterator<?> rowIterator = sheet.iterator();

			while (rowIterator.hasNext()) {
				String[] s = new String[19];
				Row row = (Row) rowIterator.next();

				Iterator<?> cellIterator = row.cellIterator();

				while (cellIterator.hasNext()) {

					Cell cell = (Cell) cellIterator.next();

					if (cell.getColumnIndex() == 0) {
						s[0] = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 1) {
						s[1] = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 2) {

						s[2] = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 4) {

						s[3] = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 5) {

						s[4] = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 7) {

						s[5] = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 8) {

						s[6] = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 9) {

						s[8] = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 10) {

						s[9] = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 11) {

						s[10] = cell.getStringCellValue();

					} else if (cell.getColumnIndex() == 12) {

						s[11] = cell.getStringCellValue();

					}

					else if (cell.getColumnIndex() == 24) {
						s[7] = cell.getStringCellValue();
					}

				}

				handles.add(s);
			}
			workbook.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return handles;

	}

	// creats Inventory based on string, maye only work for CYC atm
	private static Hashtable<Double, Product> createCYCInventory(String fileName) {

		Hashtable<Double, Product> inventory = new Hashtable<Double, Product>();

		FileInputStream fis = null;

		// ArrayList<Product> inventory = new ArrayList<Product>();
		try {
			fis = new FileInputStream(fileName);

			Workbook workbook = new XSSFWorkbook(fis);

			int i = 0; // for now...
			Sheet sheet = workbook.getSheetAt(i);

			Iterator<?> rowIterator = sheet.iterator();
			while (rowIterator.hasNext()) {

				Row row = (Row) rowIterator.next();

				Iterator<?> cellIterator = row.cellIterator();
				Product P = new Product();
				while (cellIterator.hasNext()) {

					Cell cell = (Cell) cellIterator.next();

					if (cell.getColumnIndex() == 1) {
						if (Cell.CELL_TYPE_NUMERIC == cell.getCellType()) {
							// P.setHandle((cell.getNumericCellValue()));
						} else if (Cell.CELL_TYPE_STRING == cell.getCellType()) {
							P.setHandle(cell.getStringCellValue());
						}
					} else if (cell.getColumnIndex() == 6) {
						P.setPrice(cell.getNumericCellValue());

					} else if (cell.getColumnIndex() == 7) {
						P.setCompareTo(cell.getNumericCellValue());

					} else if (cell.getColumnIndex() == 9) {
						double k = (cell.getNumericCellValue());
						double profit = P.price - k;
						P.setProfit(profit);
					} else if (cell.getColumnIndex() == 19) {

						if (Cell.CELL_TYPE_NUMERIC == cell.getCellType()) {
							P.setInventory((cell.getNumericCellValue()));
						} else {
							P.setInventory(100);
						}
					} else if (cell.getColumnIndex() == 24) {
						P.setWeight((cell.getNumericCellValue()));
					}
				}

				if (P.handle == null) {
					// uhhhh
				} else {
					Double k = getCompressionFunction(P.handle);
					inventory.put(k, P);
				}
			}
			workbook.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return inventory;

	}

	// takes list of handles
	// takes the invenotry we build,
	// searches handles, gets info, adds it to product list, reutrns the product
	// list to add
	private static ArrayList<Product> getProducts(ArrayList<String[]> handles, Hashtable<Double, Product> CYCInv) {

		ArrayList<Product> products = new ArrayList<Product>();

		for (String[] h : handles) {
			try {
				Product temp = new Product();

				double hashCode = getCompressionFunction(h[0]);
				temp = CYCInv.get(hashCode);
				temp.setTitle(h[1]);
				temp.setBody(h[2]);
				temp.setType(h[3]);
				temp.setTags(h[4]);
				temp.setOption1Name(h[5]);
				temp.setOption1Value(h[6]);
				temp.setOption2Name(h[8]);
				temp.setOption2Value(h[9]);
				temp.setOption3Name(h[10]);
				temp.setOption3Value(h[11]);
				temp.setUrl(h[7]);
				products.add(temp);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return products;
	}

	private static Double getCompressionFunction(String str) {
		Double polyHash = 0.0;
		Double x = 142.0;
		for (int i = 0; i < str.length(); i++) {
			polyHash = x * polyHash + str.charAt(i);
		}
		return polyHash;
	}

	private static void writeCSV(ArrayList<Product> Products, String fileName) {
		String[] headers = { "Handle", "Title", "Body(HTML)", "Vendor", "Type", "Tags", "Published", "Option1 Name",
				"Option1 Value", "Option2 Name", "Option2 Value", "Option3 Name", "Option3 Value", "Variant SKU",
				"Variant Grams", "Variant Inventory Tracker", "Variant Inventory Qty", "Variant Inventory Policy",
				"Variant Fulfillment Service", "Variant Price", "Variant Compare At Price", "Variant Requires Shipping",
				"Variant Taxable", "Variant Barcode", "Image Src", "Image Alt Text", "Gift Card",
				"Google Shopping / MPN", "Google Shopping / Age Group", "Google Shopping / Gender",
				"Google Shopping / Google Product Category", "SEO Title", "SEO Description",
				"Google Shopping / AdWords Grouping", "Google Shopping / AdWords Labels", "Google Shopping / Condition",
				"Google Shopping / Custom Product", "Google Shopping / Custom Label 0",
				"Google Shopping / Custom Label 1", "Google Shopping / Custom Label 2",
				"Google Shopping / Custom Label 3", "Google Shopping / Custom Label 4", "Variant Image",
				"Variant Weight Unit" };
		@SuppressWarnings("resource")
		Workbook workbook = new XSSFWorkbook();
		try {
			Sheet ProductSheet = workbook.createSheet();
			int rowIndex = 0;

			if (rowIndex == 0) {
				Row row = ProductSheet.createRow(rowIndex++);
				for (int i = 0; i < headers.length; i++) {
					row.createCell(i).setCellValue(headers[i]);

				}
			} /*
				 * row.createCell(51).setCellValue("profit"); }
				 */

			for (Product p : Products) {
				Row row = ProductSheet.createRow(rowIndex++);
				row.createCell(0).setCellValue(p.handle);
				row.createCell(1).setCellValue("title");
				row.createCell(2).setCellValue(p.body);
				row.createCell(3).setCellValue("CYC77");
				row.createCell(4).setCellValue(p.type);
				row.createCell(5).setCellValue(p.tags);
				row.createCell(6).setCellValue("TRUE");
				row.createCell(7).setCellValue(p.Option1Name);
				row.createCell(8).setCellValue(p.Option1Value);
				row.createCell(9).setCellValue(p.Option2Name);
				row.createCell(10).setCellValue(p.Option2Value);
				row.createCell(11).setCellValue(p.Option3Name);
				row.createCell(12).setCellValue(p.Option3Value);
				// ???
				row.createCell(14).setCellValue(p.weight);
				row.createCell(15).setCellValue("shopify");
				row.createCell(16).setCellValue(p.inventory);
				row.createCell(17).setCellValue("deny");
				row.createCell(18).setCellValue("manual");
				row.createCell(19).setCellValue(p.price);
				row.createCell(20).setCellValue(p.compareTo);
				row.createCell(21).setCellValue("TRUE");
				row.createCell(22).setCellValue("TRUE");
				row.createCell(24).setCellValue(p.url);
				row.createCell(26).setCellValue("FALSE");

				// row.createCell(51).setCellValue(p.profit);
			}

		} catch (Exception e) {
		}

		try {
			FileOutputStream fos = new FileOutputStream(fileName);

			workbook.write(fos);

			fos.close();

			System.out.println(fileName + " is successfully written");
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

}