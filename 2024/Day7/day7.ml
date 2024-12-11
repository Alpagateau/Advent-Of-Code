open Stdlib
open List
(*
open Core.Std
*)
type equation =
    {result:int; values:int list};;

type op = 
  | Plus 
  | Mul
;;

let file = "sample.txt";;

let explode s = List.init (String.length s) (String.get s);;
let cl2s cl = String.concat "" (List.map (String.make 1) cl);;

let rec tilllast msg = 
  match msg with
  | [] -> []
  | [x] -> []
  | x::xs -> x::(tilllast xs);;

let read_file filename = 
  let lines = ref [] in 
  let chan = open_in filename in
  try
    while true; do
      lines := input_line chan :: !lines;
    done; !lines
  with End_of_file ->
    close_in chan;
    List.rev !lines;;

let parseEq msg =
  let lex = String.split_on_char ' ' msg in
  let elems = List.filter (fun s -> s <> "") lex in
  match elems with 
  |[] -> {result = 0; values = []};
  |x::xs -> {
    result= int_of_string @@ cl2s @@ tilllast @@ explode x;
    values = List.map (fun y -> int_of_string y) xs
  };;

let print_equa e = 
  let rec ltos l = 
  match l with
  | [] -> "";
  | [x] -> string_of_int x;
  | x::xs -> (string_of_int x)^" "^(ltos xs);
  in 
  Printf.printf "{res = %d; val = %s}\n" e.result (ltos e.values);;

let rec eval vars opts =
  let shorteval x y a =
  match a with 
  | Plus -> x+y;
  | Mul -> x*y;
  in
  match (vars, opts) with
  | ([x; y], [a]) -> shorteval x y a;
  | ((x::y::xs), (a::ys)) -> eval ((eval [x;y] [a])::xs) ys;;

let rec pow a b = 
  match b with
  | 0 -> 1;
  | x -> a * (pow a (b-1));;


let rec generate_combinations n =
  if n = 0 then
    [[]]  (* Base case: return a list containing an empty list *)
  else
    let smaller_combinations = generate_combinations (n - 1) in
    let add_plus = List.map (fun lst -> Plus :: lst) smaller_combinations in
    let add_mul = List.map (fun lst -> Mul :: lst) smaller_combinations in
    add_plus @ add_mul;;  (* Concatenate the lists for `0` and `1` *)
 
let isValid eq =
  let res = eq.result in
  let var = eq.values in
  let opts = (length var)-1 in 
  let oper = List.init opts (fun x->Plus) in
  let sum = eval var oper in
  let possibilities = generate_combinations opts in
  let vals = List.map (fun cmb -> ((eval var cmb)=res) ) possibilities in
  let valid = List.fold_right (fun a b -> a || b) vals in
  (valid false);;

let () =
  (*print_endline "Hello, World!";*)
  let lines = read_file file in 
  let eqs = List.map ( parseEq ) lines in
  let valids = List.filter (fun x -> isValid x) eqs in
  let ress = List.map (fun x -> x.result) valids in
  let fsum = (List.fold_right (+) ress) 0 in
  List.iter (fun x -> print_equa x) valids;
  print_endline @@ string_of_int fsum;;
  (*List.iter (fun x -> isValid x) eqs;;*)
