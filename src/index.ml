type ('a, 'b) lambda_function = 'a -> unit -> 'b BsCallback.callback -> unit

let encode_file    = Encode_file.handler
let queue_encoding = Queue_encoding.handler
