package com.programs;

public class RandomMath {
	public static String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+=;'.,//";
	public static String  fun="OWAIS";
	public static void main(String[] args) {
		System.out.println("Random number "+(int)(Math.random() * (5)));
		String result=getRandomAlphanumericString(5);
		System.out.println("This is the random string "+result);
		
	}
	public static String getRandomAlphanumericString(int length) {
		StringBuilder builder = new StringBuilder();
		while (length--!= 0) {
			int character = (int) (Math.random() * ALPHA_NUMERIC_STRING.length());
			builder.append(ALPHA_NUMERIC_STRING.charAt(character));
		}
		return builder.toString();
	}

}
