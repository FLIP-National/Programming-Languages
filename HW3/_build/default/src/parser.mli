
(* The type of tokens. *)

type token = 
  | UNPAIR
  | TL
  | TIMES
  | THEN
  | SND
  | SETREF
  | SET
  | SEMICOLON
  | RPAREN
  | RBRACE
  | PROC
  | PLUS
  | PAIR
  | NOT
  | NODE
  | NEWREF
  | MINUS
  | MAX
  | LPAREN
  | LETREC
  | LET
  | LBRACE
  | ISZERO
  | INT of (int)
  | IN
  | IF
  | ID of (string)
  | HD
  | FST
  | EQUALS
  | EOF
  | END
  | EMPTYTREE
  | EMPTYLIST
  | EMPTY
  | ELSE
  | DIVIDED
  | DEREF
  | DEBUG
  | CONS
  | COMMA
  | CASET
  | BEGIN
  | ABS

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expr)
