package com.programs;

public class Extend extends Iris {


public Extend(String a) {
		super(a);
		System.out.println("I m in Child Constructor calling Iris constructor");
	}


public String name="owais ";
	@Override
	void walk() {
		System.out.println("Walking in Extended");
	}
	
	
	public static void main(String[] args) {
	System.out.println("I m in Child Main");
		Iris r =new Extend("Owais");
		r.run();
		r.walk();
		r.Iris("Testing Method");
		System.out.println();
	}
	
	{
		System.out.println("Child Instantiation Block");
	}
	
	static {
		System.out.println("Child static child Block");
	}

}
