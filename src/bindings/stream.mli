type r
type w
type 'a t
type readable = r t
type writable = w t
val pipe : readable -> writable -> unit
val on : 'a t -> string -> ('b -> unit) -> unit
