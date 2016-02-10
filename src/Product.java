
public class Product {

	String type = null;
	String url = null;
	String desc = null;
	String title = null;
	String handle = null;
	double price;
	double compareTo;
	double inventory;
	double weight;
	double profit;
	String body;
	String tags;
	String Option1Name;
	String Option1Value; // dbl?
	String Option2Name;
	String Option2Value; // dbl?
	String Option3Name;
	String Option3Value; // dbl?

	public Product(String handle, double price, double compareTo, double inventory, double weight) {
		this.handle = handle;
		this.price = price;
		this.compareTo = compareTo;
		this.inventory = inventory;
		this.weight = weight;

	}

	public Product() {
		// TODO Auto-generated constructor stub
	}

	public void setBody(String body) {
		this.body = body;

	}

	public void setPrice(double price) {
		this.price = price;

	}

	public void setTitle(String title) {
		this.title = title;

	}

	public void setWeight(double weight) {

		this.weight = weight;

	}

	public void setInventory(double inventory) {

		this.inventory = inventory;
	}

	public void setCompareTo(double compareTo) {
		this.compareTo = compareTo;
	}

	public void setHandle(String stringCellValue) {

		this.handle = stringCellValue;

	}

	public void setProfit(double profit) {
		this.profit = profit;

	}

	public void setType(String string) {
		this.type = string;

	}

	public void setUrl(String string) {
		this.url = string;

	}

	public void setTags(String string) {
		this.tags = string;

	}

	public void setOption1Name(String string) {
		this.Option1Name = string;

	}

	public void setOption1Value(String string) {
		this.Option1Value = string;
	}

	public void setOption2Name(String string) {
		this.Option2Name = string;

	}

	public void setOption2Value(String string) {
		this.Option2Value = string;
	}

	public void setOption3Name(String string) {
		this.Option3Name = string;

	}

	public void setOption3Value(String string) {
		this.Option3Value = string;
	}
}
