(* 
   Mutable state in OCaml
   An extended example: Linked lists 
   21 June 2021
*)


type 'a node = { mutable data: 'a;
                 mutable next: ('a node) option }

type 'a ll = { mutable head: ('a node) option;
               mutable size: int}


let l1 : 'a ll =
  {head = None;
   size = 0}


let l2 : int ll =
  {head = Some ({ data=1;
                  next = Some ({ data=2;
                                 next = Some ({ data=3;
                                                next=None})})});
   size = 0}

let string_of_ll : ('a -> string) -> 'a ll -> string =
  fun f l ->
  let rec helper no =
    match no with
    | None -> ""
    | Some n ->
      f n.data ^ "," ^ helper n.next
in "["^helper l.head ^"]"


 
(* 

 class LL<A> {
  
     static class Node<B> {
        B data;
        Node<B> next;
     ...
     }
  Node<A> head;
  int size;

  LL() {
    this.head = null;
    this.size = 0;
  }

  private static int sum(Node<Integer> n) {
       if (n==null) {
         return 0;
       }
       return n.data + sum(n.next);
  }

  public static int sum(LL<Integer> l ) {
     return sum(l.head);
  }  


  private static void bump(Node<Integer> n) {
       if (n==null) {
         return;
       }
       n.data++
  }

  public static void bump(LL<Integer> l ) {
     bump(l.head);
  }  
}
*)

let sum : int ll -> int =
  fun l ->
  let rec helper no =
    match no with
    | None -> 0
    | Some n -> n.data + helper n.next
  in
  helper l.head

let bump : int ll -> unit =
  fun l ->
  let rec helper no =
    match no with
    | None -> ()
    | Some n ->
      n.data <- n.data+1;
      helper n.next
  in
  helper l.head

(* Exercises *)

let ll_to_list : 'a ll -> 'a list =
  fun l ->
  let rec helper no =
    match no with
    | None -> []
    | Some n ->
        n.data :: helper n.next
  in helper l.head

let map : ('a -> 'b) -> 'a ll -> unit =
  fun f l ->
  let rec helper no =
    match no with
    | None -> ()
    | Some n -> 
        n.data <- f n.data;
        helper n.next
  in
  helper l.head

let get : int -> 'a ll -> 'a option =
  fun i l ->
  failwith "implement"

let add : 'a -> 'a ll -> unit = (* add first *)
  fun e l ->
  i.head <- Some ({ data=l; next=i.head});
  i.size <- i.size+1;

let add_at : int -> 'a -> 'a ll -> unit =
  fun i e l ->
  failwith "implement"

let remove : 'a ll -> unit = (* removes first *)
  fun l ->
  failwith "implement"
    
let remove_at : int -> 'a ll -> unit =
  fun i l->
  failwith "implement"

  let rev :: 'a ll -> unit =
    fun l ->
    failwith "implement"




