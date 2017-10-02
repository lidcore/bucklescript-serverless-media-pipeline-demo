open Callback

[%%bs.raw{|var AWS = require("aws-sdk")|}]

let region =
  try
    Sys.getenv "AWS_REGION"
  with Not_found -> ""

type create_params = <region:string> Js.t
let create_params = [%bs.obj{region=region}]

external make_error : string -> exn = "Error" [@@bs.new]

module Lambda = struct
  type t
  external create : create_params -> t = "AWS.Lambda" [@@bs.new]
  let lambda = create create_params

  type params
  external make_params : unit -> params = "" [@@bs.obj]
  external set_function_name : params -> string -> unit = "FunctionName" [@@bs.set]
  external set_invocation_type : params -> string -> unit = "InvocationType" [@@bs.set]
  external set_payload : params -> string -> unit = "Payload" [@@bs.set]

  external invoke : t -> params -> unit Callback.callback -> unit = "" [@@bs.send]
  let invoke ?(invocation_type="Event") ~function_name payload = fun [@bs] cb ->
    match Js.Json.stringifyAny payload with
      | None ->
         (Callback.fail (make_error "Invalid payload")) cb [@bs]
      | Some payload ->
         let params = make_params () in
         set_function_name params function_name;
         set_invocation_type params invocation_type;
         set_payload params payload;
         invoke lambda params cb
end

module S3 = struct
  type t
  external create : create_params -> t = "AWS.S3" [@@bs.new]
  let s3 = create create_params

  (* Aws capitalized params labels are annoying.. *)
  type params
  external make_params : unit -> params = "" [@@bs.obj]
  external set_bucket  : params -> string -> unit = "Bucket" [@@bs.set]
  external set_key     : params -> string -> unit = "Key" [@@bs.set]
  external set_body    : params -> Stream.readable -> unit = "Body" [@@bs.set]

  external upload : t -> params -> unit callback -> unit = "" [@@bs.send]
  let upload ~bucket ~key stream =
    fun [@bs] cb ->
      let params = make_params () in
      set_bucket params bucket;
      set_key params key;
      set_body params stream;
      upload s3 params cb

  type obj
  external get_object : t -> params -> obj = "getObject" [@@bs.send]
  external create_read_stream : obj -> Stream.readable = "createReadStream" [@@bs.send]
  let get ~bucket ~key =
    let params = make_params () in
    set_bucket params bucket;
    set_key params key;
    let obj = get_object s3 params in
    Callback.return (create_read_stream obj)
end
