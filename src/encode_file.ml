open Callback

type params = <
  source:      string;
  destination: string
> Js.t

external dirname : string = "__dirname" [@@bs.val]

let ffmpeg =
  (* lib/js/src/../../../vendor/ffmpeg *)
  {j|$(dirname)/../../../vendor/ffmpeg|j}

let process data =
  let process =
    Child_process.spawn ffmpeg [|
      "-y";"-f";"flac";"-i";"-";
      "-f";"mp3";"-b:a";"128k";"-"
    |]
  in
  Stream.pipe data process##stdin;
  process##stdout

let handler payload _ cb =
  (* This is set in serverless config. *)
  let bucket =
    Sys.getenv "MEDIA_BUCKET"
  in
  let process =
    Aws.S3.get ~bucket ~key:payload##source >> fun [@bs] readable ->
      let encoded = process readable in
      Aws.S3.upload ~bucket ~key:payload##destination encoded >> fun [@bs] _ ->
        Callback.return ()  
  in
  process cb [@bs]
