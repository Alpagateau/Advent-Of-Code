// See https://aka.ms/new-console-template for more information
Console.WriteLine("Hello, World!");

string content = File.ReadAllText("./key.txt");
string[] tokens = content.Split(',');

long acc = 0;

for(int t = 0; t < tokens.Length; t++)
{
  string[] sub_tokens = tokens[t].Split('-');
  long a = Int64.Parse(sub_tokens[0]);
  long b = Int64.Parse(sub_tokens[1]);

  for(long i = a; i <= b; i++)
  {
    //Test if i is a pattern
    long pattern_size = 10;
    while(pattern_size < i)
    {
      long pattern = i % pattern_size; 
      long j = i;
      bool is_pattern = false;
      while(j >= pattern_size)
      {
        j/=pattern_size;

      }
    }
  }
}

Console.WriteLine("The passcode is : {0}", acc);
