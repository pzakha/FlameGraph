#!/bin/bash

CPUS=$(mdb -ke "max_ncpus::print -d int")

if (( CPUS == 0 || CPUS > 16)); then
	echo "Invalid number of CPUS detected"
	exit 1
fi

OUT=$$

for (( i=0; i<$CPUS; i++ )); do
	dtrace \
		-xstackframes=100 \
		-n "profile-997/cpu==$i/{@[stack()]=count()}" \
		-c 'sleep 30' | \
		./stackcollapse.pl | \
		./flamegraph.pl \
		>$OUT.$i.svg &
done

wait

echo created $OUT.0.svg .. $OUT.$((CPUS-1)).svg

