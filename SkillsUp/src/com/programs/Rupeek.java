package com.programs;

public class Rupeek {
	public static void main(String[] args) {
		
		String sb = "owais;June,Interview.";
		String str="Welcome to geeksforgeeks";
		System.out.println(str.replaceAll("(.*)geeks(.*)", "OWAIS JILANI "));
		sb=sb.replaceAll("[^a-zA-Z0-9]", " ");
//		sb=sb.replaceAll(",", " ");
//		sb=sb.replaceAll("[.]", " ");
		System.out.println(sb);
		for(int i=0;i<sb.length();i++)
		{
			char s=sb.charAt(i);
			if(s=='a'|s=='e'|s=='i'|s=='o'|s=='u')
			{
			System.out.println(s+"- "+i);	
			}
		}
		
	}
//		String[] srt = { "Jan", "Feb", "March", "April", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec" };
//		int s = srt.length;
//		String[] sort = new String[s];
//		String pivot = srt[0];
//		for (int i = 1; i < srt.length; i++) {
//			Rupeek.compare(pivot, srt[i]);
//		}
//
//	}
//
//	public static String compare(String a, String b) {
//		
//		return "";
//	}


}
