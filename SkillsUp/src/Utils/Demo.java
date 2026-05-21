package com.programs;

import java.util.ArrayList;

class Demo {
	public static void main(String[] args) {
		System.out.println("Hello, World!");
		int[] ar = { 2, 4, 6, 9, 5 };
		int k = 8;
		ArrayList<Integer> al = new ArrayList<Integer>();
		for (int i = 0; i < ar.length; i++) {
			if (ar[i] < k) {
				al.add(ar[i]);
			}
		}

		int arrSize = al.size();
		for (int p = 0; p < arrSize; p++) {
			for (int m = p; m <= arrSize; m++) {
				for (int j = p; j < m; j++) {
					System.out.print(al.get(j) + " ");
				}
				System.out.println();
			}
		}
	}

}