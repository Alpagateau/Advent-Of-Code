#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include "structs.h"

int main()
{
  char * buffer = 0;
  long length;
  FILE * f = fopen ("sample.txt", "rb");
  
  int width = 0;
  int height = 0;
  int found = 0;
  if (f)
  {
    fseek (f, 0, SEEK_END);
    length = ftell (f);
    fseek (f, 0, SEEK_SET);
    buffer = malloc (length);
    if (buffer)
    {
      fread (buffer, 1, length, f);
    }
    fclose (f);
  }

  if (buffer)
  {
    printf(buffer);
    while(buffer[width] != '\n')
    {
      width++;
    }
    width++;
    height = length / width; 
    printf("\nWidth = %d\n", width);
    
    pos_t* list = new(-1, -1);
    //count all exes
    for(int i = 0; i < length; i++)
    {
      if(buffer[i] == 'X')
      {
        //printf("X found at index %d\n", i);
        int x = i % width;
        int y = (i-x)/width;
        pos_t *n = new(x, y);
        push(list, n);
      }
    }
    printf("Lenght of X's : %d\n", p_length(list)-1);

    //for all Xs, check if the next four chars are XMAS
    int depth = p_length(list)-1; 
    for(int i = 0; i < depth; i++)
    {
      pos_t* pos = atIdx(list, i+1);
      char buf[4] = {0};
      //printf("X at %d %d \n", pos->x, pos->y);
      int dirx = 1, diry = 0;
      for(int j = 0; j < 4; j++)
      {
        int curx = pos->x + (dirx * j);
        int cury = pos->y + (diry * j);
        if(curx < width 
        && cury < height
        && curx >= 0
        && cury >= 0)
        {
          buf[j] = buffer[ cury * width + curx ];
        }
      }
      if(strcmp(buf, "XMAS") == 0)
      {
        found++;
      }
      memset(buf, 0, sizeof buf); 

      dirx = 1;
      diry = 1;

      for(int j = 0; j < 4; j++)
      {
        int curx = pos->x + (dirx * j);
        int cury = pos->y + (diry * j);
        if(curx < width 
        && cury < height
        && curx >= 0
        && cury >= 0)
        {
          buf[j] = buffer[ cury * width + curx ];
        }
      }
      if(strcmp(buf, "XMAS") == 0)
      {
        found++;
      }
      memset(buf, 0, sizeof buf);

      dirx = 0;
      diry = 1;

      for(int j = 0; j < 4; j++)
      {
        int curx = pos->x + (dirx * j);
        int cury = pos->y + (diry * j);
        if(curx < width 
        && cury < height
        && curx >= 0
        && cury >= 0)
        {
          buf[j] = buffer[ cury * width + curx ];
        }
      }
      if(strcmp(buf, "XMAS") == 0)
      {
        found++;
      }
      memset(buf, 0, sizeof buf);

      dirx = -1;
      diry = 1;

      for(int j = 0; j < 4; j++)
      {
        int curx = pos->x + (dirx * j);
        int cury = pos->y + (diry * j);
        if(curx < width 
        && cury < height
        && curx >= 0
        && cury >= 0)
        {
          buf[j] = buffer[ cury * width + curx ];
        }
      }
      if(strcmp(buf, "XMAS") == 0)
      {
        found++;
      }
      memset(buf, 0, sizeof buf);

      dirx = -1;
      diry = 0;

      for(int j = 0; j < 4; j++)
      {
        int curx = pos->x + (dirx * j);
        int cury = pos->y + (diry * j);
        if(curx < width 
        && cury < height
        && curx >= 0
        && cury >= 0)
        {
          buf[j] = buffer[ cury * width + curx ];
        }
      }
      if(strcmp(buf, "XMAS") == 0)
      {
        found++;
      }
      memset(buf, 0, sizeof buf);

      dirx = -1;
      diry = -1;

      for(int j = 0; j < 4; j++)
      {
        int curx = pos->x + (dirx * j);
        int cury = pos->y + (diry * j);
        if(curx < width 
        && cury < height
        && curx >= 0
        && cury >= 0)
        {
          buf[j] = buffer[ cury * width + curx ];
        }
      }
      if(strcmp(buf, "XMAS") == 0)
      {
        found++;
      }
      memset(buf, 0, sizeof buf);

      dirx = 0;
      diry = -1;

      for(int j = 0; j < 4; j++)
      {
        int curx = pos->x + (dirx * j);
        int cury = pos->y + (diry * j);
        if(curx < width 
        && cury < height
        && curx >= 0
        && cury >= 0)
        {
          buf[j] = buffer[ cury * width + curx ];
        }
      }
      if(strcmp(buf, "XMAS") == 0)
      {
        found++;
      }
      memset(buf, 0, sizeof buf);

      dirx = 1;
      diry = -1;

      for(int j = 0; j < 4; j++)
      {
        int curx = pos->x + (dirx * j);
        int cury = pos->y + (diry * j);
        if(curx < width 
        && cury < height
        && curx >= 0
        && cury >= 0)
        {
          buf[j] = buffer[ cury * width + curx ];
        }
      }
      if(strcmp(buf, "XMAS") == 0)
      {
        found++;
      }
      memset(buf, 0, sizeof buf);
    }
    printf("Found %d XMAS's\n", found);
  }
  return 0;
}
