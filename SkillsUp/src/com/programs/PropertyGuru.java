package com.programs;
public class PropertyGuru {
	private static int  x = 10;
	public static void main(String[] args) {
		
		class A {
			
			private int y = 15;

			public void increment() {
				x = x + 1; //
				y = y + 1;

			}

			public void display() {
				System.out.print(x +" ");
				System.out.print(y+" ");
				System.out.println();
			}
		}
		A a = new A();
		a.display(); // 10 15
		a.increment(); //
		a.display(); // 11 16
		A b = new A();
		b.display(); // 11 15
	}

	
}









//	public static void logic()
//	{
//		
//	}
//
//	/*<select id="country">
//	<option>India</option>
//	<option>Bangladesh</option>
//	<option>Singapore</option>
//</select> */
//	
//	List<WebElement> op= driver.findElements(By.getAttribute("option"));
//	
//	for(WebElement values:op)
//	{
//		System.out.println(values.getText() );
//		
//	}
//	-----------------------------------------------------------------------------------
