PROJECT = erlang_v8_lib

DEPS = erlang_v8 hackney lager oath gun taser

dep_gun = git https://github.com/ninenines/gun master
dep_hackney = git http://github.com/strange/hackney.git
dep_erlang_v8 = git https://github.com/strange/erlang_v8 master
dep_oath = git https://github.com/strange/oath.git
dep_taser = git http://github.com/trelltech/taser.git

include erlang.mk

ERLC_COMPILE_OPTS = +'{parse_transform, lager_transform}' +debug_info
ERLC_OPTS += $(ERLC_COMPILE_OPTS)
TEST_ERLC_OPTS += $(ERLC_COMPILE_OPTS)
