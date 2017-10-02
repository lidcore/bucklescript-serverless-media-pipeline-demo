type ('a, 'b) handler = 'a -> unit -> 'b Callback.callback -> unit

val encode_file    : (Encode_file.params,unit) handler
val queue_encoding : (Queue_encoding.params, Http_handler.response) handler
