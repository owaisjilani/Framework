package com.programs;

import java.util.HashMap;
import java.util.Map;

public class CharacterCount {
	public static void main(String[] args) {
		HashMap<Character,Integer> result=new HashMap<Character,Integer>();
		String count ="owaisjilani@outlook";
		result=countString(count);
		for (Map.Entry entry: result.entrySet()) {
			System.out.println(entry.getKey() +" "+ entry.getValue());
		}
		
	}

	private static HashMap<Character, Integer> countString(String count) {
		HashMap<Character,Integer> countLetter=new HashMap<Character,Integer>();
		char[] characters=count.toCharArray();
		for (char c : characters) {
			if(countLetter.containsKey(c))
			//if(countLetter.get(c) != null)
			{
				countLetter.put(c,countLetter.get(c)+1 );
			}
			else
			{
				countLetter.put(c,1);
			}
		}
		return countLetter;
	}
//"aaabb"
}
