package com.programs;

public class Paytm {
	public static void main(String[] args) {
		String a="Hello World";
		String[] input=a.split(" ");
		System.out.println(input.length);
		for(int j=0;j<input.length;j++)
		{
			System.out.println("This is "+j+"-"+input[j]);
		Paytm.reverse(input[j]);
		}
		
	}
	public static void reverse(String inp) {
		char[] c=inp.toCharArray();
		String rev="";
		for(int i=inp.length()-1;i>=0;i--)
		{
			rev=rev+c[i];
		}
		System.out.print(rev+" ");
		
	}
	
	
			
			
//	driver.get("www.application.com")
//	driver.findElement(By.id("username")).click();
//	driver.findElement(By.id("username")).sendKeys("iamuser");
//	driver.findElement(By.id("password")).click();
//	driver.findElement(By.id("password")).sendKeys("password");
//	driver.findElement(By.id("button")).click();
//	driver.manage().wait.implicitly(10,TimeUnits.SECONDS);  //Implicit Wait
//	
//	

}



//olleH   dlroW
