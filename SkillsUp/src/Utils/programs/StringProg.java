package Utils.programs;

public class StringProg {
	public static void main(String[] args) {
		
		String a ="\n"+"Generated Condition "+"\n"+ "Multiline "+"\n"+ "CustomerType Equal To Individual "+"\n"+"AND RiskScore Start With 67";
		a=a.replaceAll("\n", "");
		a=a.substring(30);
		System.out.println(a);
	}

}
