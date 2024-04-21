package com.programs;

import java.util.HashMap;
import java.util.LinkedHashMap;

public class Calsoft2 {

	public static void main(String[] args)  {
		//int count =1;
		String s="This is nice actimize it's nice to meet you";
		String[] words=s.split(" ");
		HashMap<String,Integer> countMap=new LinkedHashMap<>();
		for (String string : words) {
			if(countMap.get(string) != null)
			{
				countMap.put(string,countMap.get(string)+1);
			}
			else
			{
				countMap.put(string,1);
			}

		}
		System.out.println(countMap);

		//		String[] words=s.split(" ");
		//		for(int i=0;i<words.length;i++)
		//		{
		//			
		//			for(int j=i+1;j<words.length;j++)
		//			{
		//				if(words[i].equalsIgnoreCase(words[j]))
		//				{
		//					count++;
		//				}
		//				
		//			}
		//			System.out.println(words[i] + "--->" +count);
		//		}

	}



}
