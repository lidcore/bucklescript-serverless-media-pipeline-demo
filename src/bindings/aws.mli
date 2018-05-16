open LidcoreBsNode

val region : string

module Lambda : sig
  val invoke : ?invocation_type:string -> function_name:string -> 'a Js.t -> unit BsCallback.t
end

module S3 : sig
  val upload : bucket:string -> key:string -> Stream.readable -> unit BsCallback.t
  val get    : bucket:string -> key:string -> Stream.readable BsCallback.t
end
