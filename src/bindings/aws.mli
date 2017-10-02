val region : string

module Lambda : sig
  val invoke : ?invocation_type:string -> function_name:string -> 'a Js.t -> unit Callback.t
end

module S3 : sig
  val upload : bucket:string -> key:string -> Stream.readable -> unit Callback.t
  val get    : bucket:string -> key:string -> Stream.readable Callback.t
end
