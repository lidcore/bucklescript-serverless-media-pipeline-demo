open Jest
open Expect

type fs = <
  existsSync: string -> Js.boolean [@bs.meth]
> Js.t
external fs : fs = "" [@@bs.module]

let _ =
  describe "Encode_file" (fun () ->
    test "ffmpeg path" (fun () ->
      expect (fs##existsSync Encode_file.ffmpeg) |> toBe Js.true_
    )
  )
