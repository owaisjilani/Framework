package Utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	public static void main(String[] args) throws ParseException {
		String file=" 07/29/2021 - 03:20 M";
		String[] ext=file.split("-");
		for (String string : ext) {
			System.out.println("Part of file "+string.trim());
		}
		String date_=ext[0].trim();
		System.out.println("The Date is in correct format ?"+isDateValid(file));
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
		

	}
	
	 public static boolean isDateValid(String dateStr) {
		 SimpleDateFormat sdf = new SimpleDateFormat("mm/dd/yyyy - hh:mm");
	        sdf.setLenient(false);
	        try {
	            sdf.parse(dateStr);
	        } catch (ParseException e) {
	            return false;
	        }
	        return true;
	    }
	}


