package com.programs;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PatternCount {
    public static int countPatternOccurrences(String input) {
        //String pattern = "0110";
        String pattern="10+1";
        //Pattern regexPattern = Pattern.compile(pattern);  //(?=)
        Pattern regexPattern = Pattern.compile("(?=" + pattern + ")");
        Matcher matcher = regexPattern.matcher(input);
        int count = 0;
        while (matcher.find()) {
            count++;
        }

        return count;
    }

    public static void main(String[] args) {
        String input = "01101100100010";
        int occurrenceCount = countPatternOccurrences(input);
        System.out.println("Occurrence count: " + occurrenceCount);
    }
}

