package com.programs;

class Validator {
	public static void main(String[] args) {
		Validator v=new Validator();
		//System.out.println(v.validate("Owais Jilani_?"));
		String a="owais";
		//System.out.println(a.charAt(1));
	}
    public boolean validate(String name) {
    	
        for (int i = 0; i < name.length(); i++) {
            char ch = name.charAt(i);
            
            if (ch != ' ' && !(Character.isLowerCase(ch) || Character.isUpperCase(ch))) {
                return false;
            }
        }
        
        return true;
    }
}