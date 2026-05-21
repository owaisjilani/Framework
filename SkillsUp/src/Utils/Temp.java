package Utils;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Temp {
	public static void main(String[] args) throws InterruptedException {
		
		String a1="Deleted a question: [xs+uT2brSSm6w89ZUcavIg: some testing que to check audit?] in the Customer Risk Profile template.";
		String b="Deleted a question:: some testing que to check audit?] in the Customer Risk Profile template.";
		String trimm=a1.split(":")[1];
		a1=a1.replace(trimm, "");
		
		System.out.println(a1);
		System.out.println(a1.contains(b));
		//		String path="C:\\Automation_Sprint52\\aml-testautomation\\src\\test\\resources\\Download";
//		//System.out.println(Temp.isFilePresent(path));
//		do {
//			Thread.sleep(3000);
//			System.out.println("Waiting for file");
//			
//		} while (Temp.isFilePresent(path));
		String value="Money Transfer-High,Online Banking-Low,Checking-Medium,Security Dealing-High,Direct Deposit Account-Very High/Sanction,Debit Card-Low,Other-Low";
		String check="Money Transfer-Medium";
		System.out.println("Pass if true "+value.contains(check));
		//value=value.replaceAll("\n", "");
		//System.out.println("Updated==="+value);
		System.out.println(value);
		File directory = new File("C:\\owais\\Automation\\src\\test\\java\\Download");
		if (!directory.exists()) {
			directory.mkdir();
		}
		
		List<String> names = new ArrayList<String>();
		String[] fil= {"owaso","jilani","owi"};
		String[] fi= {"ab","cd","ef"};
		int [] filter= {2,4,6,0,8,0,0,1};
		
		for(int j=0;j<filter.length-1;j++)
		{
			if(filter[j]==0)
			{
				
			}
		}
		System.out.println(filter[5]);
		
		
		int num = 12345;
		String rev = "";
		String nam="owaisJilani";
		
		Collections.reverseOrder();
		char res;
		String ar = Integer.toString(num);
		for (int i = ar.length() - 1; i >= 0; i--) {
			rev = rev + ar.charAt(i);
		}
		System.out.println(rev);

		String blogName = "coderolls.com";
		String reversedString = "";

		for (int i = blogName.length() - 1; i >= 0; i--) {
			reversedString = reversedString + blogName.charAt(i);
		}

		System.out.print("The reversed string of the '" + blogName + "' is: ");
		System.out.println(reversedString);

		System.out.println(ar.charAt(2) + ar.charAt(4));
		String sentence = "You are an ov";
		String[] a = sentence.split(" ");
		String temp = "";
		temp = a[0];
		for (int i = 1; i < a.length; i++) {
			if (a[i].length() > temp.length())

			{
				temp = a[i];
			}

		}
		System.out.println("This is the longest word " + temp);
	}

	public static boolean isFilePresent(String path) {
		File directory = new File(path);
		if (directory.isDirectory()) {
			String[] files = directory.list();
			if (files.length > 0) {
				System.out.println("The directory is not empty");
				return true;
			} else {
				System.out.println("The directory is empty");

			}
		}
		return false;
	}
}