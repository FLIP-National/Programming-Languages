(*Jessica Noel *)
(* I pledge my honor that I have abided by the Stevens Honor System. *)

type program = int list

let square : program = [0; 2; 2; 3; 3; 4; 4; 5; 5; 1]
let letter_e : program = [0;2;2;3;3;5;5;4;3;5;4;3;3;5;5;1]

(*Map*)
let rec map list f =
  match list with
  | [] -> []
  | h::t -> f h :: (map t f)
                   
(*Fold*)
let rec fold f b l =
  match l with
  | [] -> b
  | h::t -> fold f h (f b t)
  
(*Mirror/Opposite direction*)
let rec mirror_image (a:program) =
  match a with
  | [] -> []
  | h::t -> (match h with
      | 2 -> 4
      | 3 -> 5
      | 4 -> 2
      | 5 -> 3
      | _ -> h)
            :: mirror_image t
                
(* Rotate 90 Letter*)
let rec rotate_90_letter (a:program) =
  match a with
  | [] -> []
  | h::t -> (match h with
      | 2 -> 3
      | 3 -> 4
      | 4 -> 5
      | 5 -> 2
      | _ -> h)
            :: rotate_90_letter t 
  
(*Rotate 90 Word*)
let rotate_90_word a = 
  (map a rotate_90_letter) 
  
(*Repeat*)
let rec repeat n x =
  match n with
  | 0 -> []
  | n -> x :: repeat (n-1) x 
  
(*Pantograph no map*)
let rec pantograph_nm (n:int) (a:program) = 
  match n with 
  | 0 -> []
  | _ -> 
      (match a with
       | [] -> []
       | h::t -> 
           (match h with
            | 0 | 1 -> h :: (pantograph_nm n t)
            | _ -> (repeat n h) @ (pantograph_nm n t))) 

(* Appends all lists inside list *)                                                        
let rec appendl (l:'a list) = 
  match l with 
  | [] -> []
  | h::t -> h @ appendl t

(* Pantograph Helper *)
let rec panto_helper (n:int) (x:int) = 
  if n = 0
  then []
  else match x with
    | 0 | 1 -> [x]
    | _ -> (repeat n x)

(* Pantograph with map *)
let rec pantograph (n:int) (p:program) = 
  appendl @@ map p (panto_helper n) 
       
(* Pantograph with fold *)
let rec pantograph_f (n:int) (p:program) =
  List.rev (List.fold_left 
              (fun r h -> 
                 (match h with
                  | 0 | 1 -> h :: r
                  | _ -> (repeat n h) @ r)) [] p )
  
(* Coverage Helper *)
let rec coverage_help c a =
  match a with
  | [] -> []
  | h::t -> (match h with 
      | 2 -> (fst c, (snd c) + 1) :: coverage_help (fst c, (snd c) + 1) t 
      | 3 -> ((fst c) + 1, snd c) :: coverage_help ((fst c) + 1, snd c)  t
      | 4 -> (fst c, (snd c) - 1) :: coverage_help (fst c, (snd c) - 1) t
      | 5 -> ((fst c) - 1, snd c) :: coverage_help ((fst c) - 1, snd c) t
      | _ -> c :: coverage_help c t)
    
(* Coverage *) 
let rec coverage c a = 
  c :: coverage_help c a

(* Compress Helper*)
let rec compress_help (a:program) (n:int) =
  match a with
  | [] -> []
  | h1::[] -> (h1, n) :: []
  | h1:: h2 :: t ->
      if h1 != h2
      then (h1, n) :: (compress_help (h2 :: t) 1)
      else compress_help (h2 ::t) (n + 1) 
  
(* Compress *)
let compress a =
  compress_help a 1
  
(* Uncompress *)
let rec uncompress n = 
  match n with 
  | [] -> []
  | (src, tgt)::t -> (repeat tgt src) @ (uncompress t)
  
(* Uncompress Fold *) 
let rec uncompress_f a = 
  List.rev (List.fold_left ((fun r h -> (repeat (snd h)(fst h)) @ r)) [] a)
    
(* Uncompress Map *)
let rec uncompress_m a = 
  List.flatten (List.map (fun (src, tgt) -> repeat tgt src) a)
  
(* Optimize Helper *)
let rec optimize_help a penstat = 
  match a with 
  | [] -> []
  | h::t ->
      (match penstat, h with 
       | true, 1 -> optimize_help t true
       | true, 0 -> h :: optimize_help t false
       | false, 1 -> h :: optimize_help t true
       | false, 0 -> optimize_help t false
       | _,_ -> h :: (optimize_help t penstat)) 
                                          
(* Optimize *)
let optimize a =
  optimize_help a true 