type response = <
  statusCode: int;
  body: string
> Js.t

exception Error of response

external make_error : string -> Js.Exn.t = "Error" [@@bs.new]

external make_response : statusCode:int -> body:string -> unit -> response = "" [@@bs.obj]

let error_500 =
  make_response ~statusCode:500 ~body:"Internal error!" ()

let response msg =
  match Js.Json.stringifyAny msg with
    | Some body -> 
        make_response ~statusCode:200 ~body ()
    | None ->
        Report.send (make_error "Invalid response"); 
        error_500

let wrap cb = fun [@bs] err ret ->
  match Js.toOption err with
    | Some Error e ->
        cb Js.Nullable.null e [@bs]
    | Some (Js.Exn.Error e) ->
        Report.send e;
        cb Js.Nullable.null error_500 [@bs]
    | Some exn ->
        let exn =
          try
            make_error (Printexc.to_string exn)
          with _ -> Obj.magic exn
        in
        Report.send exn;
        cb Js.Nullable.null error_500 [@bs]
    | None ->
        cb Js.Nullable.null (response ret) [@bs]
