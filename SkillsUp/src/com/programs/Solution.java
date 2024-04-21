package com.programs;

import java.util.*;

 abstract class Food{
    double proteins;
    double fats;
    double carbs;
    double tastyScore;
    public abstract void getMacroNutrients();
    
}
//=====================================================================================================
class Bread extends Food{
   
    public String type="Vegetarian";
    int tastyScore=8;
	public Bread(int i, double d, double e) {
		this.proteins=i;
		this.fats=d;
		this.carbs=e;
	}

	@Override
   public void getMacroNutrients(){
        System.out.println("A slice of bread has"+ this.proteins+" gms of protien,"+this.fats+" gms of fats and "+this.carbs+" gms of carbohydrates");
    }
}
//=====================================================================================================

class Egg extends Food{
	public String type="Non-Vegetarian";
	int tastyScore=7;
	public Egg(double p,double fats,double carbs) {
		this.proteins=p;
		this.fats=fats;
		this.carbs=carbs;
		
	}
    @Override
   public void getMacroNutrients(){
        System.out.println("An egg has "+ this.proteins+","+this.fats+"and " +this.carbs+ "gms of carbohydrates"  );
    }
}

//-=====================================================================================================
public class Solution {
    public static void main(String args[] ) throws Exception {
        Scanner sc = new Scanner(System.in);
        int cnt = Integer.parseInt(sc.nextLine());
        for (int i = 0; i < cnt; i++) {
            String name = sc.nextLine();

            if(name.equals("Bread")) {
                Bread breadObj = new Bread(4, 1.1, 13.8);
                for(int j = 0; j < 3; j++) {
                    String command = sc.nextLine();
                    if(command.equals("getMacros")) {
                        breadObj.getMacroNutrients();
                    } else if(command.equals("getTaste")) {
                        System.out.println("Taste: " + breadObj.tastyScore);
                    } else if(command.equals("getType")) {
                        System.out.println("Bread is " + breadObj.type);
                    }
                }
            } else if (name.equals("Egg")) {
                Egg eggObj = new Egg(6.3, 5.3, 0.6);
                for(int j = 0; j < 3; j++) {
                    String command = sc.nextLine();
                    if(command.equals("getMacros")) {
                        eggObj.getMacroNutrients();
                    } else if(command.equals("getTaste")) {
                        System.out.println("Taste: " + eggObj.tastyScore);
                    } else if(command.equals("getType")) {
                        System.out.println("Egg is " + eggObj.type);
                    }
                }
            }
        }
    }
}

//=====================================================================================================