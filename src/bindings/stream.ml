type r
type w
type 'a t
type readable = r t
type writable = w t

external pipe : readable -> writable -> unit = "pipe" [@@bs.send]
external on : 'a t -> string -> ('b -> unit) -> unit = "on" [@@bs.send]
