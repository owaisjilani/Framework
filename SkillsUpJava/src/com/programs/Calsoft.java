package com.programs;

public class Calsoft {

	public static void main(String[] args) {
		String a="Hello  World";
		//a=a.replace(" ", "");
		int count=0;
		for(int i=0;i<a.length();i++)
		{
			if (a.charAt(i)==' ') {
				System.out.println("Found Invalid Character");
			} else {
					count++;
			}
			
		}
		System.out.println("Result count  is "+count);
		
	}
}
