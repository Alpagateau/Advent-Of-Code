
function Split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function In(tbl, elem)
  for _,v in pairs(tbl) do
    if v == elem then return true end
  end
  return false
end

local file = io.open("sample.txt", "r")

io.input(file)

local data = io.read("*all")

local lines = Split(data, "\n")

local graph = {}
--Dependency Graph
local process = {} --List of actions to be done

for _, v in pairs(lines) do
  if string.find(v, "|") then
    local temp = Split(v, "|")
    if graph[temp[2]] == nil then
      graph[temp[2]] = {temp[1]}
    else
      graph[temp[2]][#graph[temp[2]]+1] = temp[1] -- Ugly as f*ck
    end
  else
    process[#process+1] = Split(v, ",")
  end
end

local isValid = {}

for i, p in pairs(process) do
  local done = {}
  for idx = 1, (#p), 1 do
    if isValid[i] == nil then
      if graph[p[idx]] == nil then done[#done+1] = p[idx]
      else
        for _, d in pairs(graph[p[idx]]) do
          if In(p, d) then
            if In(done, d) then
              done[#done+1] = p[idx]
             else
              isValid[i] = false
              break
            end
          else
            done[#done+1] = p[idx]
          end
        end
      end
    end
  end
  if isValid[i] == nil then isValid[i]=true end
end

local sum = 0
for i, v in pairs(isValid) do
  if v then
    local idx = (#process[i]//2)+1
    sum = sum + process[i][idx]
  end
end

--DEBUG
for k, v in pairs(graph) do
  local msg = "Key : "..k.." Values : "
  for key, value in pairs(v) do
    msg = msg..value.." "
  end
  print(msg)
end
print("======== Separator ==========")
for k, v in pairs(process) do
  local msg = "Key : "..k.." Values : "
  for key, value in pairs(v) do
    msg = msg..value.." "
  end
  print(msg)
end

print("======== Separator ==========")
for k, v in pairs(isValid) do
  local msg = "Key : "..k.." Values : "..tostring(v)
  print(msg)
end

print("Total Sum : "..sum)

io.close(file)
