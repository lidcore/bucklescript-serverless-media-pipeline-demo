type t = <
  stdin  : Stream.writable;
  stdout : Stream.readable
> Js.t

external exec : string -> t = "" [@@bs.module "child_process"]
