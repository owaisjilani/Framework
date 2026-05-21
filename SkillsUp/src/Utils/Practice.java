package Utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;

public class Practice {

	public static void main(String[] args) throws ParseException {
		String a = "Test1,Test2,Test3";
		String file="04/07/2021 - 06:21 PM";
		String[] ext=file.split("-");
		for (String string : ext) {
			System.out.println("Part of file "+string.trim());
		}
		String date_=ext[0].trim();
		String fileType = ".xls";
		String[] FileExtensionArr = { "pdf", "csv", "doc", "ppt", "txt", "xls" };
		check(FileExtensionArr, "pdf");
		
		String[] res = a.split(",");
		List<String> exp = new ArrayList<String>();
		for (String string : res) {
			exp.add(string);
		}

		String dateStr1 = "24/06/1995";
		String dateStr2 = "24/07/1995";
		// Parsing the given String to Date object
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date date = new Date();
		System.out.println("Todays Date is " + formatter.format(date));
		//date = formatter.parse(dateStr1);
		date = formatter.parse(date_); //Ui getText() Date
		String today=formatter.format(date);
		Date todayDate=formatter.parse(formatter.format(date));
		Date date2 = formatter.parse(dateStr2);
		
		int bool1 = date.compareTo(date2);
		System.out.println(bool1);

		if (date.before((todayDate))) {
			System.out.println(date + " is before" + todayDate);
		}
		ArrayList n=new ArrayList();
		n.add("67Owais");
		n.add(10.00);
		n.add(786);
		n.add("abc");
		
		for (Object object : n) {
			System.out.println(object);
		}
		char as='a';
		char[] arrCharacter= {1,2,4,5};
		String s = String.valueOf(new char[]{'a','e','7','2'});
		System.out.println(s);
		StringBuilder sb=new StringBuilder();
		String conver=Character.toString(as);
		String myStr = String.valueOf(as);
		sb.append(as);
		ArrayList<String> firstList = new ArrayList<String>(Arrays.asList("Owais", "Java", "Python", "Ruby", "Go"));
		ArrayList<String> secondList = new ArrayList<String>(Arrays.asList("Java", "Python", "Ruby", "Go", "Owais"));
		Collections.sort(firstList);
		Collections.sort(secondList);
		System.out.println("When Lists are same: " + firstList.equals(secondList));
		System.out.println(exp.toString());
		System.out.println(fileType.contains("pdf") || fileType.contains("txt") || fileType.contains("csv")
				|| fileType.contains("xls") || fileType.contains("doc"));
	}

	private static Boolean check(String[] FileExtensionArr, String toCheckValue) {

		boolean test = false;
		for (String element : FileExtensionArr) {
			if (element == toCheckValue) {
				test = true;
				break;
			}
		}
		System.out.println("Is " + toCheckValue + " present in the array: " + test);
		return test;
	}

}
