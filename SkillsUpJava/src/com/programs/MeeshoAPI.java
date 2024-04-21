package com.programs;

public class MeeshoAPI {
//	"customer": [
//	             {
//	               "customer_name": "Test_Customer",
//	               "customer_ids": [
//	                 599515
//	               ]
//	             }
//	           ],
//	           "shop": {
//	             "id": "78",
//	             "name": "Meesho_INDIA"
//	           }
//	         }'

	private String customer_name;
	public String getCustomer_name() {
		return customer_name;
	}

	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}

	public int getCustomer_ids() {
		return customer_ids;
	}

	public void setCustomer_ids(int customer_ids) {
		this.customer_ids = customer_ids;
	}

	private int customer_ids;
	
	public String getCustomerName()
	{
		return customer_name;
	}
	
}
