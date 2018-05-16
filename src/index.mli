type ('a, 'b) lambda_function = 'a -> unit -> 'b BsCallback.callback -> unit

val encode_file    : (Encode_file.params,unit) lambda_function
val queue_encoding : (Queue_encoding.params, Api_handler.response) lambda_function
