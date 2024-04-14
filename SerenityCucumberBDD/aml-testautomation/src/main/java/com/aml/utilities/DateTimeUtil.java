package com.aml.utilities;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.Date;
import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;

public class DateTimeUtil {

	static public int getDayofMonth(String actualDate) {

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy", Locale.ENGLISH);
		LocalDate ld = LocalDate.parse(actualDate, dtf);
		return ld.getDayOfMonth();
	}

	static public int getMonthValue(String actualDate) {

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy", Locale.ENGLISH);
		LocalDate ld = LocalDate.parse(actualDate, dtf);
		return ld.getMonthValue();
	}

	static public int getYear(String actualDate) {

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy", Locale.ENGLISH);
		LocalDate ld = LocalDate.parse(actualDate, dtf);
		return ld.getYear();
	}

	public static String returnCurrentDateTime(String dateTimeFormat) {

		DateFormat dateFormat = new SimpleDateFormat(dateTimeFormat);

		return dateFormat.format(new Date());

	}
	
	
}

