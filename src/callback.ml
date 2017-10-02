type error  = exn Js.nullable
type 'a callback = error -> 'a -> unit [@bs]
(* A computation takes a callback and executes it
   either with an error or with a result of type 'a. *)
type 'a t = 'a callback -> unit [@bs]

(* Computation that returns x as a value. *)
let return x = fun [@bs] cb ->
  cb Js.Nullable.null x [@bs]

(* Computation that returns an error. *)
let fail exn = fun [@bs] cb ->
  cb (Js.Nullable.return exn) (Obj.magic Js.Nullable.null) [@bs]

(* Pipe current's result into next. *)
let (>>) current next = fun [@bs] cb ->
  let fn = fun [@bs] err ret ->
    match Js.toOption err with
      | Some exn -> (fail exn) cb [@bs]
      | None     ->
         let next =
           try
             next ret [@bs]
           with exn -> fail exn
         in
         next cb [@bs]
  in
  current fn [@bs]
