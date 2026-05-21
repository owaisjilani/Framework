
public class Qualys {
	public static void main(String[] args) {
		int[] a = { 1, 2, 3, 4 };
		int[] result=new int[a.length];
		
		for (int i = 0; i < a.length; i++) {
			int j = i + 1;
			int k = a[i];
			while (j < a.length) {
				k = k * a[j];
				j++;
			}
			result[i]=k;
		}
		
		System.out.println("This is result "+result[0]+","+ result[1]+","+result[2]+","+result[3]);
	}

}
