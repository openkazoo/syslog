-module(syslog_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    SupFlags = #{strategy => one_for_all,
                 intensity => 5,
                 period => 10},
    ChildSpecs = [#{id => syslog,
                    start => {syslog, start_link, []},
                    restart => permanent,
                    shutdown => 5000,
                    type => worker,
                    modules => [syslog]}],
    {ok, {SupFlags, ChildSpecs}}.
