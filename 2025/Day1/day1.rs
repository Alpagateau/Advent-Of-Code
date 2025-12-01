use std::fs;

fn main()
{
    let content = fs::read_to_string("./key.txt").expect("Should read a file");
    let mut counter = 0;
    let mut dial = 50;
    let lines = content.split("\n");
    for line in lines 
    {
        if line.len() >= 1 {
            let dir = &line[0..1];
            let mul = match dir {
                "L" => -1,
                "R" => 1,
                &_ => 0
            };
            
            let steps = &line[1..].parse::<i32>().unwrap();
            for i in 0..*steps {
                dial = (dial+(mul * 1)) % 100;
                if dial == 0 { counter += 1;}
            }
        }
    }
    println!("{counter}\n")
}
