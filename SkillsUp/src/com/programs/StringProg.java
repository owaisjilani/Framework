package com.programs;

import java.util.Arrays;
import java.util.stream.Stream;

public class StringProg {
	public static void main(String[] args) {
		String b = "Owais 67 is alpha78_Numeric86 5 4 32";
		b=b.replaceAll("[^\\d]", " ");
		b=b.trim();
		b= b.replaceAll(" +", " ");
		System.out.println("this is arrayList number "+b);
		//String b = "Owais 67 is alpha78_Numeric86 5 4 32";
		String[] ak=b.split(" "); 
		int[] ar=Arrays.stream(ak)
                .mapToInt(Integer::parseInt)
                .toArray();
		System.out.println("Testing Interview EATON "+ ar[2]);
		
//		char[] s = b.toCharArray();
//		int sum=0;
//		for(int i=0;i<s.length;i++)
//		{
//			
//			if(Character.isDigit(s[i]))
//			{
//				sum=sum+Character. getNumericValue(s[i]);
//			}
//		}
		
		//System.out.println("Sum is "+ sum);

		String a = "\n" + "Generated Condition " + "\n" + "Multiline " + "\n" + "CustomerType Equal To Individual "
				+ "\n" + "AND RiskScore Start With 67";
		a = a.replaceAll("\n", "");
		a = a.substring(30);
		System.out.println(a);
	}

}
