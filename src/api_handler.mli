type response = <
  statusCode: int;
  body: string
> Js.t

exception Error of response

val wrap : response BsCallback.callback -> 'a BsCallback.callback
