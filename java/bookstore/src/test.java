
public class test {
	public static int aa(int i,int j)
	{
	  int x=0;
	  if(j==1||i==j)
	   x=1;
	  else x=aa(i-1,j-1)+aa(i-1,j);
	   return x;
	}
	public static void main(String[] args)
	{
	  for(int i=1;i<=10;i++)
	  {
	   for(int j=1;j<=i;j++)
	   {
	    if(aa(i,j)<10)
	    System.out.print("   "+aa(i,j)+" ");
	    else if(aa(i,j)<100)
	    System.out.print("  "+aa(i,j)+" ");
	    else
	    System.out.print(" "+aa(i,j)+" ");
	   }
	   System.out.println();
	  }
	}
	}

