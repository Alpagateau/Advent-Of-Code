function max_in_str(s)
  max_int = -100
  max_int_idx = -100
  for i in 1:length(s)
    x = parse(Int, s[i])
    if x > max_int
      max_int = x
      max_int_idx = i
    end
  end
  return (max_int, max_int_idx)
end

open("key.txt") do f

  # line_number
  line = 0
  acc = 0
  # read till end of file
  while ! eof(f)
    # read a new / next line for every iteration           
    s = readline(f)          
    line += 1
    (M, I) = max_in_str(s)
    sl = s[1:I-1]
    sr = s[I+1:end]
    (ml, _) = max_in_str(sl)
    (mr, _) = max_in_str(sr)
    v1 = M * 10 + mr
    v2 = ml * 10 + M
    V = max(v1, v2)
    println("$line . $s : ($M, $I) : $V")
    acc = acc + V
  end
  println("Password is : $acc")
end
