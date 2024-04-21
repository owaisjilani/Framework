//
//public class Duplicate {
//	public static void main(String[] args) {
//		Duplicate.duplicate();
//	}
//	public static void duplicate()
//	{
//		int a[] = {3,5,10,15,60,40,10,50,90,40,96};
//		for(int i=0;i<a.length;i++)
//		{
//			for(int j=i+1;j<a.length;j++)
//			{
//				if(a[i]==a[j])
//				{
//					System.out.println("Duplicate Number is"+a[i]);
//				}
//			}
//		}
//	}
//
//}

import java.util.HashSet;

public class FindDuplicates {
    public static void main(String[] args) {
        int[] nums = {1, 2, 3, 4, 5, 2, 6, 7, 8, 9, 1};
        HashSet<Integer> set = new HashSet<>();
        HashSet<Integer> dup = new HashSet<>();
    
        for(int i:nums)
        {
        	if(!set.add(i))
        	{
        		dup.add(i);
        	}
        	
        }
        System.out.println("Duplicate Number are "+ dup);
        
    }
}