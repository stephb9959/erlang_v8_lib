-module(erlang_v8_lib_sup).

-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

pool_spec() ->
    {ok, Core} = application:get_env(erlang_v8_lib, core),
    {ok, Modules} = application:get_env(erlang_v8_lib, modules),
    Files = [begin
                 Path = code:priv_dir(Appname),
                 filename:join(Path, Filename)
             end || {Appname, Filename} <- Core ++ Modules],
    PoolArgs = [{size, 10}, {max_overflow, 20},
                {name, {local, v8_worker_pool}},
                {worker_module, erlang_v8_lib_worker}],
    WorkerArgs = [Files],
    poolboy:child_spec(v8_worker_pool, PoolArgs, WorkerArgs).

init([]) ->
    PoolSpec = pool_spec(),
	{ok, {{one_for_one, 10, 10}, [PoolSpec]}}.
