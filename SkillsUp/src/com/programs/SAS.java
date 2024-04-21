package com.programs;

public class SAS {
	public static void main(String[] args) {
		String String;
		int[] ar = { 5, 0, 11, 1 };
		int l = ar.length - 1; // l=3
		int[] rs = new int[ar.length];
		int k=0;
		for (int i = 0; i < ar.length; i++) {
			if (ar[i] == 0) {
				rs[l] = ar[i];
				l--;
				k--;
			} else {
				rs[k] = ar[i];
			}
			k++;
		}

		for (int kl : rs) {
			System.out.print(kl + " ");
		}
	}

	// ************************************************************************************
//		int temp;
//		for(int i=0;i<ar.length;i++) {
//			for(int j=i+1;j<ar.length;j++)
//			{
//				if(ar[i]==0)
//				{
//					temp=ar[j];
//					ar[j]=ar[i];
//					ar[i]=temp;
//				}
//			}
//		}
//		
//		for (int k : ar) {
//			System.out.print(k+" ");
//		}

}
