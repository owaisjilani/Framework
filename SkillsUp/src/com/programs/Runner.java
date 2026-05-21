import java.util.ArrayList;
import java.util.List;

public class Runner {

	public static void main(String[] args) {
		 Runner.arr();
		
	}
	public static List<List<Integer>> arr() {
		List<List<Integer>> list=new ArrayList<>();
		int[] a = { 1, 2, 3, 4, 5 };
		int b = 7;
		int res = 0;
		int n = 0;
		for (int i = 0; i < a.length; i++) {
			for (int j = i + 1; j < a.length; j++) {
				res = a[i] + a[j];

				if (b == res) {
					System.out.println("The first index is " + i + "and second is " + j);
					List<Integer> l2=new ArrayList<>();
					l2.add(i);
					l2.add(j);
				   list.add(l2);
				}
				
			}
			
		}
		System.out.println("This is result "+list);
		return list;
	}

}
