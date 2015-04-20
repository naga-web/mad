-module(mad_lfe).
-copyright('chan Sisowath').
-compile(export_all).
-define(COMPILE_OPTS(Inc, Ebin, Opts), [verbose, report, {i, Inc}, {outdir, Ebin}] ++ Opts).

lfe_to_beam(Bin, F) -> filename:join(Bin, filename:basename(F, ".lfe") ++ ".beam").

compile(File,Inc,Bin,Opt) ->
    BeamFile = lfe_to_beam(Bin, File),
    Compiled = mad_compile:is_compiled(BeamFile, File),
    if  Compiled =:= false ->
        Opts1 = ?COMPILE_OPTS(Inc, Bin, Opt),
            %%io:format("Compiling ~s Opts ~p~n\r", [File,Opts1]),
            io:format("Compiling ~s~n\r", [File]),
             lfe_comp:file(File, Opts1),
                ok;
        true -> ok end.

