package com.programs;

public class Interf implements Hilti {

	@Override
	public void methodA() {

	}

	public void methodC(){

	}

}

class C {
	public static void main(String[] args) {
		Hilti i=new Interf();
		//i.methodC();
	}


}