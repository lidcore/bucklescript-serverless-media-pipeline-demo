type error  = exn Js.Nullable.t
type 'a callback = error -> 'a -> unit [@bs]
(* A computation takes a callback and executes it
   either with an error or with a result of type 'a. *)
type 'a t = 'a callback -> unit [@bs]

val return : 'a -> 'a t
val fail   : exn -> 'a t
val (>>)   : 'a t -> ('a -> 'b t [@bs]) -> 'b t
