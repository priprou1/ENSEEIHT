
module GreenThreads =
  struct
    (* à compléter/modifier *)
    type res = (* ici les paramètres sont égaux à unit car pas d'entrée ni de retour aux processus sinon ('shift, 'reset) *)
    | Done
    | Yield of (unit -> res)
    | Fork of (unit -> res) * (unit -> unit)
    (*      ta continuation * nouveau processus *)

    let prompt = Delimcc.new_prompt();;

    let run proc () = Delimcc.push_prompt prompt (fun () -> proc (); Done)

    let scheduler proc_init = 
      let rec loop queue =
        match queue with
        | [] -> ()
        | t::q -> match t () with
                  | Yield k -> loop (q@[k])
                  | Fork (k, proc) -> loop (run proc::(q@[k]))
                  | Done -> loop q
      in loop [run proc_init]

    let yield () = Delimcc.shift prompt (fun k -> Yield k);;
    let fork proc = Delimcc.shift prompt (fun k -> Fork (k, proc));;
    let exit () = Delimcc.shift prompt (fun _ -> Done);;
  end

let ping () =
  begin
    for i=1 to 10
    do
      Format.printf "ping!";
      GreenThreads.yield ()
    done
  end

  let pong () =
    begin
      for i=1 to 10
      do
        Format.printf "pong!";
        GreenThreads.yield ()
      done
    end

    let ping_pong () =
      GreenThreads.(fork ping;
      fork pong;
      exit())

    let _ = GreenThreads.(scheduler ping_pong)

(*
module type Channel =
  sig
    val create : unit -> ('a -> unit) * (unit -> 'a)
  end

module GTChannel : Channel =
  struct
    (* à compléter/modifier *)
    let create () = assert false;;
  end
    
let sieve () =
  let rec filter reader =
    GreenThreads.(
      let v0 = reader () in
      if v0 = -1 then exit () else
      Format.printf "%d@." v0;
      yield ();
      let (writer', reader') = GTChannel.create () in
      fork (fun () -> filter reader');
      while true
      do
        let v = reader () in
        yield ();
        if v mod v0 <> 0 then writer' v;
        if v = -1 then exit ()
      done
    ) in
  let main () =
    GreenThreads.(
      let (writer, reader) = GTChannel.create () in
      fork (fun () -> filter reader);
      for i = 2 to 1000
      do
        writer i;
        yield ()
      done;
      writer (-1);
      exit ()
    ) in
  GreenThreads.scheduler main;;
*)