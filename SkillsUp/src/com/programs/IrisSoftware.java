package com.programs;

public class IrisSoftware {
	public static void main(String[] args) {
//		int exp =PropertyGuru.fibonaci(4);
//		System.out.println("Result : "+exp);
		IrisSoftware.printFibo(-2);
	}
	//1 2 3 5 8
	
	public static int fibonaci(int a)
	{
		if (a==1 | a==2)
		{
			return a;
		}
		else
			
		{
			return fibonaci(a-2)+fibonaci(a-1);
		}
		
	}
	
	static int n1=0,n2=1,n3=0;
	
	public static void printFibo(int c)
	{
		if(c>0)
		{
			n3=n1+n2;
			n1=n2;
			n2=n3;
			System.out.println(""+n3);
			printFibo(c-1);
		}
	}

}
