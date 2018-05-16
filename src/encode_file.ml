open BsCallback
open LidcoreBsNode

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

let handler payload _ =
  (* This is set in serverless config. *)
  let bucket =
    Sys.getenv "MEDIA_BUCKET"
  in
  Aws.S3.get ~bucket ~key:payload##source >> fun readable ->
    let encoded = process readable in
    Aws.S3.upload ~bucket ~key:payload##destination encoded >| fun _ ->
      ()
