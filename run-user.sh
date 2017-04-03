#!/bin/bash

dtrace \
	-xstackframes=100 \
	-xustackframes=100 \
	-n 'profile-997/pid==$target/{@[stack()]=count()}' \
	-c 'zfs list -Ho name,name,dc:ips,dc:user -r dcenter' | \
	./stackcollapse.pl | \
	./flamegraph.pl \
	>$$.svg
echo created $$.svg
