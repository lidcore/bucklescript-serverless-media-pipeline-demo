type r
type w
type 'a t
type readable = r t
type writable = w t

external pipe : readable -> writable -> unit = "pipe" [@@bs.send]
external on : 'a t -> string -> ('b -> unit) -> unit = "on" [@@bs.send]

let pipe src dst = pipe src dst
let on str = on str

type array
external array : unit -> array = "Array" [@@bs.new] 
external push : array -> 'a Js.t -> unit = "" [@@bs.send]

type buffer
external toString : buffer -> unit -> string = "" [@@bs.send]

type buffer_class
external buffer_class : buffer_class = "Buffer" [@@bs.val] 
external concat : buffer_class -> array -> buffer = "" [@@bs.send]

let toString array =
  toString (concat buffer_class array) ()

let read str = fun [@bs] cb ->
  let chunks = array () in
  let errored = ref false in
  on str "error" (fun exn ->
    errored := true;
    (Callback.fail exn) cb [@bs]
  );
  on str "data" (fun data ->
    if not !errored then
      push chunks data);
  on str "end" (fun () ->
    if not !errored then
      (Callback.return (toString chunks)) cb [@bs]) 
