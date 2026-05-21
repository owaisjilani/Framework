package Utils;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.codoid.products.exception.FilloException;
import com.codoid.products.fillo.Connection;
import com.codoid.products.fillo.Fillo;
import com.codoid.products.fillo.Recordset;

public class ReadExl {

	public static void main(String[] args) throws FilloException {

		readEXL();
	}



	private static void map() {
		Map<Integer,String> team1 = new HashMap<Integer, String>();
		team1.put(1,"United");
		team1.put(5,"Owi");
		team1.put(7,"Owais");
		List<Integer> keys = new ArrayList<>(team1.keySet());
		//		for ( Integer key : team1.keySet() ) {
		//		    System.out.println( key );
		//		}

		System.out.println(keys.get(2));

	}



	public static void readEXL() throws FilloException
	{
		Fillo f=new Fillo();
		Connection con=f.getConnection("C:\\owais\\Automation\\src\\test\\Resources\\DataIntakeInput\\ACCOUNT.xlsx");
		Recordset rs;
		String query="Select * from Sheet1 where NUMBER=9999";
		rs=con.executeQuery(query);

		ArrayList<String> al=new ArrayList<>(rs.getFieldNames());
		int size=al.size();
		while(rs.next()){
			System.out.println(rs.getField("STATUS"));
		}
		System.out.println("");
	}



	//Read All data from Excel
	public static void readEXLSheet() throws FilloException
	{
		Fillo f=new Fillo();
		Connection con=f.getConnection("C:\\owais\\Automation\\src\\test\\Resources\\DataIntakeInput\\ACCOUNT.xlsx");
		Recordset rs;
		String query="Select * from Sheet1";
		rs=con.executeQuery(query);

		ArrayList<String> al=new ArrayList<>(rs.getFieldNames());
		int size=al.size();
		System.out.println(rs.getFieldNames());
		//int count=rs.getCount();
		while(rs.next()){

			for(int i=0;i<size;i++)
			{
				System.out.print(rs.getField(al.get(i))+ "\t");
			}
			System.out.println("");
		}

	}	
}
