package com.programs;
import java.util.LinkedHashMap;
import java.util.Map;

public class CountName {


	public static void main(String[] args) {

		String str = "OWAIS--67";
		Map<Character, Integer> charCountMap = new LinkedHashMap<>();

		// Iterating through each character in the string
		for (char c : str.toCharArray()) {
			// Updating the count for each character
			charCountMap.put(c, charCountMap.getOrDefault(c, 0) + 1);
		}

		// Displaying the character occurrence count
		System.out.println("Character occurrence count:" +charCountMap );
		for (Map.Entry<Character, Integer> entry : charCountMap.entrySet()) {
			System.out.println("'" + entry.getKey() + "': " + entry.getValue());
		}


				/*String name="OWAIS--67";
				
				Map<Character,Integer> count = new LinkedHashMap<Character,Integer>();
				for (Character ch : name.toCharArray()) {
					if(count.containsKey(ch))
					{
					
						count.put(ch,count.get(ch)+1);
					}
					else{
						count.put(ch, 1);
					}
					
				}
				
				for (Map.Entry<Character, Integer> en : count.entrySet()) {
					System.out.println("Occurence of name " + en.getKey() + "its occurence is " + en.getValue());
					
				}*/


	}

}
