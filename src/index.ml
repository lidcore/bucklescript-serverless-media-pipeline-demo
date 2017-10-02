type ('a, 'b) handler = 'a -> unit -> 'b Callback.callback -> unit

let encode_file    = Encode_file.handler
let queue_encoding = Queue_encoding.handler
