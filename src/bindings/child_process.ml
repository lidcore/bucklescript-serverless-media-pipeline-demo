type t = <
  stdin  : Stream.writable;
  stdout : Stream.readable
> Js.t

type params = <
  stdio: string array
> Js.t

external spawn : string -> string array -> params -> t = "" [@@bs.module "child_process"]

let spawn cmd args =
  let stdio =
    [|"pipe";"pipe";"inherit"|]
  in
  let params = [%bs.obj{
    stdio = stdio
  }] in
  spawn cmd args params
