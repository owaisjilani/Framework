package Utils;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.collections.map.HashedMap;

public class MapConcept{
	public static void main(String[] args) {

		int[] a = { 10, 20, 30, 40 };
		Map<String, String> am = new HashMap<String, String>();
		am.put("2", "Owais");
		am.put("3", "A");
		am.put("1", "Shireen");
		am.put("4", "Siri");
		am.put("6", "Ow");
		am.put("7", "O");

		Iterator<String> it = am.keySet().iterator();
		while (it.hasNext()) {
			System.out.println("Iterating map Keys  " + it.next());
		}

		Iterator<String> its = am.values().iterator();
		while (its.hasNext()) {
			System.out.println("Iterating map Values  " + its.next());
		}

		for (String s : am.keySet()) {
			System.out.println("Keys are " + s);
		}

		for (String s : am.values()) {
			System.out.println("Values are " + s);
		}

		for (Map.Entry<String, String> en : am.entrySet()) {
			System.out.println("This is Entry Key " + en.getKey() + " and Value " + en.getValue());
		}

		// Creating a HashMap
		HashMap<String, String> languages = new HashMap<>();
		languages.put("Java", "Enterprise");
		languages.put("Python", "ML/AI");
		languages.put("JavaScript", "Frontend");
		System.out.println("HashMap: " + languages);

		// iterating through key/value mappings
		System.out.print("Entries in HashMap: ");
		for (Entry<String, String> entry : languages.entrySet()) {
			System.out.print(entry);
			System.out.print(", ");
		}

		for (Entry<String, String> es : am.entrySet()) {
			System.out.println("this is entry " + es);

		}

		for (int i = a.length - 1; i >= 0; i--) {
			System.out.println(a[i] + " ");
		}

	}

}
