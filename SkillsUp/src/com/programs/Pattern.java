package com.programs;

public class Pattern {
	public static void main(String[] args) {
		int number = 1;
//		int i, j;
//		for (i = 1; i <6; i++) {
//			for (j=1;j<i;++j) {
//				System.out.print(number);
//				++number;
//			}
//			System.out.println();
//		}

		for(int i=1;i<9;i++)
		{
			for(int j=1;j<=i;j++)
			{
				System.out.print(number+" ");
				number++;
			}
			System.out.println();
		}
		
	//}

	}
}
