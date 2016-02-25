public class Lab {

	String instructor;
	String subject;
	int courseNo;
	String cD = " ";
	String secNo;
	int term;
	String activity;
	String days;
	String startTime;
	String endTime; // might be weird / time

	String taFirst = "first Name";
	String taLast = "last Name";

	String cM = " ";
	String cN = " ";
	String cO = " ";

	String taEducation = "G";// education

	int hours;
	int cR = 0;
	int cS = 0;
	int cT = 0;
	String cU = " ";
	int cV = 0;
	int cW = 0;

	public Lab(String instructor, String subject, int courseNo, String secNo, int term, String activity, String days,
			int hours, String startTime, String endTime) {

		this.instructor = instructor;
		this.subject = subject;
		this.courseNo = courseNo;
		this.secNo = secNo;
		this.term = term;
		this.activity = activity;
		this.days = days;
		this.startTime = startTime;
		this.endTime = endTime;
		this.hours = hours;

	}

	public Lab() {
		// TODO Auto-generated constructor stub
	}

}
