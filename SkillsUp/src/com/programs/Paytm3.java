package com.programs;

public class Paytm3 {
	public static void main(String[] args) {
	String input="in-al-i-js-i-awo";
	char[] c=input.toCharArray();
	
	String rev="";
	
	for(int i=input.length()-1;i>=0;i--)
	{
		rev=rev+c[i];
	}
	rev=rev.replaceAll("&", "");
	System.out.println(rev);
	
		
	}

}
