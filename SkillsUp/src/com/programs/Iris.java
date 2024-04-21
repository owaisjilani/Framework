package com.programs;

public abstract class Iris {
	public static void main(String[] args) {
		System.out.println("I m in main iris");
		
	}
	public String s="";
	public void Iris(String a){
		System.out.println("Testing ");
		
	}
	
	public Iris(String a){
		this.s=a;
		System.out.println("I m in Constructor");
	}	
	
	public void run() {
		System.out.println("I m running in Iris");
		System.out.println("this os Iris S "+ s);
	}
	
	
	abstract  void walk();
	
	{
		System.out.println("Parent Instantiation Block");
	}
	
	static {
		System.out.println("Parent static block");
	}


}

