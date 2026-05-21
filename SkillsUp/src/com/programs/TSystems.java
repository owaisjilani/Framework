
	class TSystems {
	    public static void main(String[] args) {
	        System.out.println("Hello, World!");
	        int[] a= {1,1,6,7,8,6,0,1};
	        int[] b=new int[10];
	        for(int i=0;i<a.length;i++)
	        {
	        	b[a[i]]++;
	        	
	        }
	        for(int j=0;j<b.length;j++)
	        {
	        	if(b[j]==0) {
	        		
	        		//System.out.println("NO NEED TO PROINT");
	        	}
	        	else {
	        System.out.println("This number "+j+ " occurs - " + b[j] +" times");
	        	}
	        }
	    }
	    
	}