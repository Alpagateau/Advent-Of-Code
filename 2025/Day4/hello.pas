program Hello;
type md_array = array of array of integer;

var fh : textfile;
    s : string;

var w,h : integer;
var matrice : md_array;

var i, j: integer;
var acc : integer;
var local_acc : integer;

var off_x, off_y : integer;

begin
  w := 0; 
  h := 0;
  acc := 0;
  local_acc := 0;
  writeln('Hello from Pascal');
  Assign(fh, './key.txt');
  Reset(fh);
  
  // First pass: determine dimensions
  While not Eof(fh) Do Begin
    Readln(fh, s); 
    writeln(s);
    h := h + 1;
    if Length(s) > w then
      w := Length(s);
  end; 
  
  // Set array dimensions (0-based)
  setLength(matrice, w, h);

  // Second pass: fill the matrix
  Reset(fh); 
  j := 0;
  While not Eof(fh) Do Begin
    i := 0;
    Readln(fh, s);
    While (i < w) Do Begin 
      if (i < Length(s)) and (s[i+1] = '@') then  // +1 because strings are 1-based
      begin
        matrice[i][j] := 1;
      end
      else
        matrice[i][j] := 0; 
      i := i + 1;
    End;
    j := j + 1;
  end;

  // Count @ symbols with less than 4 @ neighbors
  for j := 0 to h-1 do
    for i := 0 to w-1 do
      if (matrice[i][j] = 1) then
      begin
        local_acc := 0;
        for off_x := -1 to 1 do
          for off_y := -1 to 1 do
            // Skip the cell itself
            if not ((off_x = 0) and (off_y = 0)) then
              if ((i + off_x >= 0) and (i + off_x < w) and 
                  (j + off_y >= 0) and (j + off_y < h)) then 
                if matrice[i+off_x][j+off_y] = 1 then
                  local_acc := local_acc + 1;
        if (local_acc < 4) then
          acc := acc + 1;
      end;
    
  Close(fh);
  writeln('Result: ', acc); 
end.
