package com.programs;

public class Meesho {

	public static void main(String[] args) throws Exception {
		String exclude="ohseeM";
		String in="Meesho flipkart";  // ohseeM trakpilf
		char[] st=in.toCharArray();
		int i;
		String rev="";
		for(i=st.length-1;i>=0;i--)
		{
			rev=rev+st[i];
		}
		if(rev.equals(exclude))
		{
			throw new Exception("This is not Allowed here");
		}
		System.out.println(rev);
		
	}
}
