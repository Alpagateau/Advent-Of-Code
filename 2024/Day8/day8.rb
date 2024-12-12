
class Antinode

  def initialize(px, py)
    @posx = px
    @posy = py
  end

  def posx
    @posx
  end
  def posy
    @posy
  end

  def to_s
    "<#{@posx};#{@posy}>"
  end
end

class Antenna
  @posx = 0
  @posy = 0
  @id = ""
  def posx
    @posx
  end
  def posy
    @posy
  end
  def id
    @id
  end
  def initialize(px, py, ide) 
    @posx = px
    @posy = py
    @id = ide
  end
  def to_s
    "<Antenna : [#{@posx}, #{@posy}] : #{@id}>"
  end
end

def get_anodes (a1, a2)
  if a1.id != a2.id then
    return []
  else
    v = [ a1.posx  - a2.posx, a1.posy - a2.posy]
    return [
      Antinode.new(a2.posx + v[0]*2, a2.posy + v[1]*2),
      Antinode.new(a1.posx - v[0]*2, a1.posy - v[1]*2)
    ]
  end
end

file_name = "sample.txt"
terrain = File.read(file_name)
lines = terrain.split(/\n/)

$width = lines[0].length()
$height = lines.length()

antennas = []

for y in 0..lines.length()-1 do
  for x in 0..lines[0].length()-1 do
    if lines[y][x] != '.' then
      antennas.push(
        Antenna.new(
          x, y,
          lines[y][x]
        )
      )
    end
  end
end

done = []
anodes = []

for i in 0..antennas.length()-1 do
  for j in 0..antennas.length()-1 do
    if i != j then
      puts "#{i}, #{j}"
      anodes += get_anodes(antennas[i], antennas[j])
    end
  end
end

#puts antennas
puts anodes.length()

finals = []
for i in 0..anodes.length()-1 do
  if anodes[i].posx >= 0 && anodes[i].posx < $width then
    if anodes[i].posy >= 0 && anodes[i].posy < $height then
      if !finals.include?([anodes[i].posx, anodes[i].posy]) then
        finals += [ [anodes[i].posx, anodes[i].posy] ]
      end
    end
  end
end

puts "final : #{finals.length()}"
