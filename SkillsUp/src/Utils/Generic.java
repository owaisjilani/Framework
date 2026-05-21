package Utils;
class Generic {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        //{3,2,3,4,2,3,5,6}
        int count=1;
        int inc=0;
        int[] a= {3,2,3,4,2,3,5,6};
        int[] dup=new int[a.length];
        
        for(int i=0;i<a.length;i++)
        {
            for(int j=i+1;j<a.length;j++)
            {
            	
                if (a[i]==a[j])
                {
                    count++;
                }
            }
            System.out.println(a[i] + "-" + count );
            dup[inc]=a[i];
            count=1;
            
        }
    }
    
}