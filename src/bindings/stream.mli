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

val pipe : readable -> writable -> unit
val on : ([< events] as 'a) t -> 'a -> unit
