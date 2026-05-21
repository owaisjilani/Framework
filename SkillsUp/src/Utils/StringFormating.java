package Utils;

import java.io.File;

public class StringFormating {

	public static void main(String[] args) throws InterruptedException {
		String money = "$069,786.67";
		money = money.replaceAll("[^\\d.]", "").split("[.]")[0];
		System.out.println(money);
		String Inputdate = "10/03/2012";
		System.out.println("Is this parsable Date ? " + FileUtil.verifyDateTimeFormat(Inputdate, "mm/dd/yyyy"));
		// FileUtil.changeDateFormat(Inputdate, "", requiredDateFormat);
		// C:\Automation_Sprint54\aml-testautomation\src\test\resources\Download

		// System.out.println( "Lentgh od file is
		// "+FileUtil.getLatestFile("C:/Automation_Sprint54/aml-testautomation/src/test/resources/Download/").split("csv").length);
		int i = 1;
		do {
			System.out.println(i);
			i++;
		} while (i <= 10);

		File f = new File("C:/Automation_Sprint54/aml-testautomation/src/test/resources/Download/");
		File[] dir;
		do {
			dir = f.listFiles();
			i = dir.length;
			Thread.sleep(3000);
			System.out.println("Waiting for File Transfer from Server");
		} while (i == 0);

		do {
			for (File file : dir) {
				System.out.println("Chrome Started downloadinging " + file.getName());
			}
			Thread.sleep(2000);
			System.out.println("Waiting for File to Be downloaded Successfully");
		} while (FileUtil.getLatestFile("C:/Automation_Sprint54/aml-testautomation/src/test/resources/Download/")
				.split("csv").length == 2);
		System.out.println("*****Report Downloaded Successfully :) *******");

		// System.out.println(FileUtil.getLatestFile("C:/Automation_Sprint54/aml-testautomation/src/test/resources/Download/").split("csv").length
		// == 1);

	}

}
