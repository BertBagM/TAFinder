public class lab {

	String instructor;
	String subject;
	String courseNo;		
	String secNo;
	int term;
	String activity;	
	String days;
	double startTime ;	
	double endTime	; // might be weird / time
			


	public lab(String instructor,String subject,String courseNo, String secNo, int term, String activity, String days, double startTime ,double endTime) {
	
		this.instructor = instructor;
		this.subject = subject;
		this.courseNo = courseNo;		
		this.secNo= secNo;
		this.term = term;
		this.activity = activity;	
		this.days = days;
		this.startTime = startTime;
		this.endTime = endTime;

	}

	public lab() {
		// TODO Auto-generated constructor stub
	}

}
