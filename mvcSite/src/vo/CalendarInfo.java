package vo;

//일정 관리의 달력 출력에 필요한 정보들을 저장하는 클래스
public class CalendarInfo {
	private int cYear, cMonth, cDay, sYear, sMonth, sDay, lastDay;
	// 현재 연도, 현재 월, 현재 일, 검색 연도, 검색 월, 검색 일, 말일

	public int getcYear() {
		return cYear;
	}

	public void setcYear(int cYear) {
		this.cYear = cYear;
	}

	public int getcMonth() {
		return cMonth;
	}

	public void setcMonth(int cMonth) {
		this.cMonth = cMonth;
	}

	public int getcDay() {
		return cDay;
	}

	public void setcDay(int cDay) {
		this.cDay = cDay;
	}

	public int getsYear() {
		return sYear;
	}

	public void setsYear(int sYear) {
		this.sYear = sYear;
	}

	public int getsMonth() {
		return sMonth;
	}

	public void setsMonth(int sMonth) {
		this.sMonth = sMonth;
	}

	public int getsDay() {
		return sDay;
	}

	public void setsDay(int sDay) {
		this.sDay = sDay;
	}

	public int getLastDay() {
		return lastDay;
	}

	public void setLastDay(int lastDay) {
		this.lastDay = lastDay;
	}
	
}
