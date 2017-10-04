type 'a t

type write_events = [
  | `Close  of unit     -> unit
  | `Drain  of unit     -> unit
  | `Finish of unit     -> unit
  | `Error  of exn      -> unit
  | `Pipe   of readable -> unit
  | `Unpipe of readable -> unit
] and read_events = [
  | `Close    of unit   -> unit
  | `End      of unit   -> unit
  | `Readable of unit   -> unit
  | `Data     of string -> unit
  | `Error    of exn    -> unit
] and writable = write_events t
  and readable = read_events t

type events = [write_events | read_events]

external pipe : readable -> writable -> unit = "" [@@bs.send]
external on : 'a t -> string -> ('b -> unit) -> unit = "" [@@bs.send]

let on str = function
  | `Close    fn -> on str "close"    fn
  | `Drain    fn -> on str "drain"    fn
  | `Finish   fn -> on str "finish"   fn
  | `Error    fn -> on str "error"    fn
  | `Pipe     fn -> on str "pipe"     fn
  | `Unpipe   fn -> on str "unpipe"   fn
  | `End      fn -> on str "end"      fn
  | `Readable fn -> on str "readable" fn
  | `Data     fn -> on str "data"     fn
