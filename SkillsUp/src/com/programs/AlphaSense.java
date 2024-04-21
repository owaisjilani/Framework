package com.programs;

import java.io.IOException;

import javax.management.RuntimeErrorException;

public class AlphaSense {
	public static void main(String[] args) throws Exception {
		int[] a = {10,12,13,5};
		AlphaSense t = new AlphaSense();
		t.increment(a);
		System.out.println("Length is "+a.length);
		System.out.println("Incremented Value "+a[a.length - 1]);
		t.err();
		
		try {
			int x=0;
			for(x=1;x<4;x++);
			System.out.println("Value of X = "+x);
			
		} catch (Exception e) {
			System.out.println("Catched the Exception");
		}
		finally {
			System.out.println("This is Finally ");
		}
		//t.divide(4, 4);
		
		
	}

	
	
	
	
	
	private void increment(int[] i) {
		i[i.length - 1]++;
	}
	public int divide(int a,int b)
	{
		int c=0;
		try {
			c=a/b;
		} catch (ArithmeticException e) {
			System.out.println("java.lang.ArithmeticException: / by zero Occured");
		}
		
		finally {
			System.out.println("Finally");
			
		}
		
		System.out.println("This is the result "+c);
		return c;
	}
	
	int err() throws Exception {
		try {
			throw new IOException("IO Exception");
		} catch (RuntimeException e) {
			throw new RuntimeException(e);
		}
		finally {
			System.out.println("return -1");
			//return -1;
		}
		
	}
}
