package com.programs;

public class SubstringCount {
    public static int countSubstringOccurrences(String input) {
        String substring = "0110";
        int count = 0;
        int index = input.indexOf(substring);

        while (index != -1) {  
            count++;
            System.out.println("Index initial Value "+index);
            index = input.indexOf(substring, index + substring.length());
        }

        return count;
    }

    public static void main(String[] args) {
        String input = "210aabacaabaab11010110110";
        int occurrenceCount = countSubstringOccurrences(input);
        System.out.println("Occurrence count: " + occurrenceCount);
    }
}
