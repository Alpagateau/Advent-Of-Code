const fs = require('fs');

const data = fs.readFileSync('./sample.txt', 'utf8');

//do()
//don't()
//mul(a,b)

const re = /(do\(\))|(don't\(\))|(mul\(\d+,\d+\))/gm;

var sum = 0;
var enabled = true;
const matches = data.matchAll(re);
    
for (const match of matches) {
  if(match[0] == "do()")
  {
    enabled = true;
  }
  else if(match[0] == "don't()")
  {
    enabled = false;
  }
  else
  {
    if(enabled){
      var nums = match[0].match(/\d+/g);
      sum += parseInt(nums[0]) * parseInt(nums[1]);
    }
  }
}

console.log(sum);
