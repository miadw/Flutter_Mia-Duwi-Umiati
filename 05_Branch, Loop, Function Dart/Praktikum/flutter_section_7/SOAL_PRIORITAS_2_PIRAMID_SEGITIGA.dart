import 'dart:io';
void main(){
    for (int i = 1; i <= 8; i++)
    {
        for(int j = 1; j <= 15; j++)
        {
          if (j >= 9-i && j <=7+i) 
             stdout.write("*");
             else
             stdout.write(" ");
        }
        print(" ");
    }
}