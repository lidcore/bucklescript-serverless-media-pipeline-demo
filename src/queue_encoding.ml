open Callback
open Http_handler

type params = <
  body: string
> Js.t

let handler payload _ cb =
  let parse : string -> Encode_file.params = [%bs.raw{|function (x) {
    return JSON.parse(x);
  }|}] in
  let process =
    let params = parse payload##body in
    Aws.Lambda.invoke ~function_name:"media-pipeline-encode-file" params >> fun [@bs] _ ->
      Callback.return [%bs.obj { status = "ok" }]
  in
  let cb =
    Http_handler.wrap cb
  in
  process cb [@bs]
