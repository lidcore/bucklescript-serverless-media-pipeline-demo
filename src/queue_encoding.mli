type params = <
  body : string
> Js.t

val handler : params -> unit -> Http_handler.response Callback.callback -> unit
