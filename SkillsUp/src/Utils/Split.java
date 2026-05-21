package Utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.regex.*;

public class Split {

	public static void main(String[] args) throws ParseException {
		String ele="xpath=owaiselementIsVisible";
		System.out.println(ele.substring(6));
		if (false) {
			System.out.println("oooooooooooooooooooo");

		} else if (true) {
			System.out.println("fffffffffffffffffffff");
		}

		System.out.println("this is name and tab" + "\t" + "this is surname");
		changeDateFormat("2020-8-9", "yyyy-mm-dd", "m/d/yyyy");
//		SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-mm-dd");
//		Date tempDate = inputDateFormat.parse("2020-12-09");
//		SimpleDateFormat outputFORMAT = new SimpleDateFormat("m/d/yyyy");
//		String date = outputFORMAT.format(tempDate);
//		System.out.println(date);
		ArrayList<String> al = new ArrayList<String>();
		String wOZero = Split.removeLeadingZeros("002000-10-17");
		System.out.println("This is w/o Zero " + wOZero);
		// System.out.println("This is parsable"+
		// Split.verifyDateTimeFormat(wOZero,"DD/MM/YYYY"));
		String[] aa = { "067670", "$55,948.00", "TRUE", "2020-12-09", "07/17/2021 - 12:31 PM", "07/08/2006	12:31 oo",
				"owais jilani", "ab,uk,us", "CREDIT_CARD", "24/10/1942 - 79 years old" };
		Collections.addAll(al, aa);
		System.out.println(al.get(0));
		String actualCsvValue;

		for (int i = 0; i < aa.length; i++) {
			actualCsvValue = aa[i].trim();
			if (FileUtil.verifyDateTimeFormat(actualCsvValue, "yyyy-mm-dd")) {
				try {
					System.out.println("Parsing the date*****************");
					actualCsvValue = changeDateFormat(actualCsvValue, "yyyy-mm-dd", "m/d/yyyy");
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (actualCsvValue.contains(" ") || actualCsvValue.contains("$") || actualCsvValue.contains("/")
					|| actualCsvValue.contains(";") || actualCsvValue.contains("\\t") || actualCsvValue.contains("-")) {
				actualCsvValue = actualCsvValue.split("\\t|;|-| ")[0];
				if (actualCsvValue.startsWith("$")) {
					actualCsvValue = actualCsvValue.replaceAll("[^\\d.]", "").split("[.]")[0];
				} else if (actualCsvValue.startsWith("0")) {
					actualCsvValue = Split.removeLeadingZeros(actualCsvValue);
				}
			} else if (actualCsvValue.contains("CREDIT_CARD")) {
				actualCsvValue="Credit-Card";
			}

			System.out.println("This is the =" + actualCsvValue);
		}

	}

	public static String removeLeadingZeros(String str) {
		String regex = "^0+(?!$)";
		str = str.replaceAll(regex, "");
		str = str.replaceAll("/0", "/");
		return str;
	}

	public static String changeDateFormat(String Inputdate, String iDateFormat, String requiredDateFormat) {
		SimpleDateFormat inputDateFormat = new SimpleDateFormat(iDateFormat);
		String date = "";
		try {
			Date tempDate;
			tempDate = inputDateFormat.parse(Inputdate);
			SimpleDateFormat outputFORMAT = new SimpleDateFormat(requiredDateFormat);
			date = outputFORMAT.format(tempDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	public static boolean verifyDateTimeFormat(String dateStr, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		sdf.setLenient(false);
		try {
			sdf.parse(dateStr);
		} catch (ParseException e) {
			return false;
		}
		return true;
	}

}
