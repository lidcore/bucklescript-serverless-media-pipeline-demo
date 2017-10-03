type t = <
  stdin  : Stream.writable;
  stdout : Stream.readable
> Js.t

val spawn : string -> string array -> t
