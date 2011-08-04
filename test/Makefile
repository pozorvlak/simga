distclean-eembc2:
	find -iname sim.out -exec rm {} \;

run-eembc2:
	for i in EEMBC/eembc-2.0/* ; \
	do  \
		if [ -d $$i ]; then \
			echo -e "Total energy 5\nCycle count 7" > $$i/sim.out; \
		fi \
	done
