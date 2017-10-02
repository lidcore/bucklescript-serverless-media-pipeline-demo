type t = <
  stdin  : Stream.writable;
  stdout : Stream.readable
> Js.t

val exec : string -> t
