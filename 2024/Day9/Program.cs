using System;
using System.IO;
using System.Text;

Console.WriteLine("Hello, World!");
string data = File.ReadAllText("sample.txt");
Console.WriteLine(data+"\n");


int numf = data.Length/2 + (data.Length%2);
int totalSize = 0;
int[] counters = new int[numf];
int[] blks = new int[data.Length - numf - 1];
for(int i = 0; i<numf; i++)
{
  totalSize += (data[i*2] - '0');
  //Console.Write(String.Format("{0}", data[i*2]-'0'));
  counters[i] = (data[i*2] - '0');
  if(i*2 < data.Length-3)
  {
    blks[i] = (data[(i*2) + 1] - '0');
  }
}
Console.WriteLine(
    String.Format("Total Size : {0}", totalSize));

int[] FinalList = new int[totalSize];
for(int i = 0; i < totalSize; i++)
  FinalList[i] = -1;

int getLastnZero(int[] tab)
{
  for(int i = tab.Length-1; i >= 0; i--)
  {
    if(tab[i] != 0)
    {
      return i;
    }
  }
  return -1;
}

ulong checksum(int[] tab)
{
  ulong s = 0;
  for(int i = 0; i<tab.Length;i++)
  {
    s +=(ulong)(tab[i] *i);
  }
  return s;
}

bool finish = false;
int idx = 0;
int fidx = 0;
while(!finish)
{
  if(idx%2 == 0)
  {
    //Work with counters
//    Console.WriteLine(
//        String.Format("Counter {0}", idx/2)
//        );
    if(idx/2 < counters.Length){
      int s = 0;
      for(int i = 0; i < counters[idx/2]; i++)
      {
        if(fidx < FinalList.Length){
          FinalList[fidx] = idx/2;
          fidx++;
          s++;
        }
      }
      counters[idx/2]-=s;
    }
  }
  else
  { 
//    Console.WriteLine("Blanks");
    //Work with blks 
    if((idx-1)/2 < blks.Length){ 
      for(int i = 0; i < blks[(idx-1)/2]; i++)
      { 
        int fname = getLastnZero(counters);
        if(fname < 0){
          finish = true;
          break;
        }
        FinalList[fidx] = fname;
        counters[fname]--;
        fidx++;
      }
      blks[(idx-1)/2]=0;
    }else{finish = true;}
  }
  idx++; 
/*
  //  Console.Write("Counter : ");
//  for(int i = 0; i < counters.Length; i++)
//  {
//    Console.Write(
//        String.Format("{0}", counters[i]));
  }
  Console.WriteLine("");
  Console.Write("Blanks : ");
  for(int i = 0; i < blks.Length; i++)
  {
    Console.Write(
        String.Format("{0}", blks[i]));
  }
  Console.WriteLine("");
  Console.Write("Final : ");
  for(int i = 0; i < FinalList.Length; i++)
  {
    Console.Write(
        String.Format("{0}", FinalList[i]));
  }
  Console.WriteLine("\n------------------------");
*/
}
/*
for(int i = 0; i < FinalList.Length; i++)
{
  Console.Write(String.Format("{0}", FinalList[i]));
}
*/
Console.WriteLine("\nFinished");
Console.WriteLine(
    String.Format(
      "CheckSum : {0}", checksum(FinalList)
      )
    );
