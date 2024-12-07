#include <iostream>
#include <vector>
#include <string>
#include <fstream>

#define UP 0
#define RIGHT 1
#define DOWN 2 
#define LEFT 3

int main()
{ 
  std::vector<std::string> _map;

  std::string myText;
  std::ifstream MyReadFile("sample.txt");
  while (getline (MyReadFile, myText)) {
    if(myText.size()>1)
    {
      std::cout <<"|"<< myText <<std::endl;
      //std::string temp = myText + "";
      _map.push_back(myText);
    }
  }

  std::cout << "[INFO] : Map size : " << _map.size() << "| map width : " << _map[0].size() << std::endl;
  /*for(int i = 0; i < _map.size(); i++)
  {
      std::cout << _map[i] << std::endl;
  }*/
  int posX = -1;
  int posY = -1;
  int dir = UP;
  //Set start position
  for(int i = 0; i < _map.size(); i++)
  {
    for(int j = 0; j < _map[0].size(); j++)
    {
      //std::cout << "*" << _map[i][j];
      if(_map[i][j] == '^')
      {
        posX = j;
        posY = i;
      }
    }
    //std::cout << std::endl;
  }
  std::cout << "Starting at : " << posX << " " << posY << std::endl; 
  bool isOut;
  int sum = 0; 
  while(!isOut)
  {
    int nxtx = posX;
    int nxty = posY;
    switch(dir)
    {
      case UP:
        nxty--;
        break;  
      case DOWN:
        nxty++;
        break;
      case RIGHT:
        nxtx++;
        break;
      case LEFT:
        nxtx--;
        break;
    }
    if(nxtx < 0 || nxty < 0){isOut = true; continue;}
    if(nxtx >= _map[0].size() || nxty >= _map.size()){isOut = true; continue;}
    
    switch(_map[nxty][nxtx])
    {
      case '#':
        dir = (dir+1)%4;
        nxtx = posX;
        nxty = posY;
        break;
      case 'X':
        break;
      default:
        _map[nxty][nxtx] = 'X';
        sum++;
        break; 
    }
    //std::cout << nxtx << " | " << nxty << std::endl;
    posX = nxtx;
    posY = nxty;
  }
  
  std::cout << "==PROCESSING==" << std::endl;
  for(int i = 0; i < _map.size(); i++)
  {
      std::cout << _map[i] << std::endl;
  }
  std::cout << "Result : "<<sum <<std::endl;

  MyReadFile.close(); 

  return 0;
}
