type params = <
  source:      string;
  destination: string
> Js.t

val ffmpeg : string
val handler : params -> unit -> unit Callback.callback -> unit
