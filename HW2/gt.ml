(* 

   Jessica Noel
   Pledge: I pledge my honor that I have abided by the Stevens Honor S

*)

type 'a gt = Node of 'a*('a gt) list
                       
let t : int gt =
  Node (33,
        [Node (12,[]);
         Node (77, 
               [Node (37, 
                      [Node (14, [])]); 
                Node (48, []); 
                Node (103, [])])
        ])
    
let mk_leaf (n : 'a) : 'a gt =
  Node(n,[])
 
let rec map f l = 
  match l with 
  | [] -> []
  | h::t -> f h :: map f t
              
let rec map2 f l =
  match l with
  | [] -> []
  | h::t -> f h @ map2 f t
              
let rec max l n = 
  match l with
  | [] -> n
  | h::t -> if h > n then max t h
      else max t n
  
(* Given a general tree resturns its height *)     
let rec height t =
  match t with 
  | Node(d, []) -> 1
  | Node(d, treeleaf) -> max(List.map height treeleaf) 0 + 1
  
(* Returns a list with all paths from the root to the leaves of a gt *)
let rec paths_to_leaves t = 
  match t with 
  | Node(d, []) -> [[]]
  | Node(d, treeleaf) -> List.flatten (List.mapi (fun i n -> (List.map (fun x -> i :: x) n)) 
                                         (List.map paths_to_leaves treeleaf))
  
(* Perfect Leaf Helper *)
let rec isleafp_helper l n =
  match l with
  | [] -> true
  | h::t -> ((List.length h) = n) && isleafp_helper t n
  
(* Determines whether a general tree is leaf perfect *) 
let rec is_leaf_perfect t =
  isleafp_helper(paths_to_leaves t) ((height t) - 1)
  
(* Preorder *)
let rec preorder t =
  match t with
  | Node(d, []) -> [d]
  | Node(d, treeleaf) -> d :: List.concat(List.map preorder treeleaf)
  
(* Size *)                    
let size t =
  List.length(preorder t)
  
(* Mirror *)
let rec mirror t =
  match t with
  | Node(d, []) -> Node(d, [])
  | Node(d, treeleaf) -> Node(d, List.map mirror (List.rev treeleaf))
  
(* Mapt*)
let rec mapt f (Node(d,ch)) =
  Node(f d, List.map (mapt f) ch)

(* Foldt *)
let rec foldt : ('a -> 'b list -> 'b) -> 'a gt -> 'b = 
  fun f t ->
    match t with
    |Node (d, []) -> f d []
    |Node (d, l) -> f d (List.map (foldt f) l)

(* sumt *)
let sumt t =
  foldt (fun i rs -> i + List.fold_left (fun i j -> i+j) 0 rs) t
  
(* memt *)
let memt t e=
  foldt (fun i rs -> i=e || List.exists (fun i -> i) rs) t 
  
(* Mirror using foldt *)
let mirror' t =
  foldt (fun i rs -> Node(i, List.rev rs)) t 