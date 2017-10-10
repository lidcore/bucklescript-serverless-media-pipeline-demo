type params = <
  body : string
> Js.t

val handler : params -> unit -> Api_handler.response Callback.callback -> unit
