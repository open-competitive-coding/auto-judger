submit:
	bash scripts/submit-solution.sh $(solution-file)
accept:
	bash scripts/accept-solution.sh
compile:
	bash scripts/compile-solution.sh
clean:
	rm scripts/user-key.txt || true
	rm scripts/user-key-enc.txt || true
	rm scripts/user-key-dec.txt || true

	mv solution/README.md ../ || true
	mv solution/example-A.c ../ || true
	rm -rf solution/
	mkdir solution
	mv ../README.md solution/ || true
	mv ../example-A.c solution/ || true
install:
	sudo apt-get install pwgen
