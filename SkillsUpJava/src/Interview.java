
public class Interview {

	public static void main(String[] args) {
		
		String Input="He";
		String[] words=Input.split(" ");
		for (String word : words) {
			System.out.print(Interview.reverse(word)+" ");
		}
		
		
		
	}
	
	static String reverse(String word)
	{
		String result="";
		char[] c=word.toCharArray();
		for(int i=c.length-1;i>=0;i--)
		{
			result+= c[i];
		}
		return result;
		
	}
	
}
