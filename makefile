run: build
	@echo "Starting execution"
	./ftest test_cases/graph1.txt 0 5 out
	@echo "Finished execution"
	@echo ""
	@echo "***** Output *****"
	@cat out

build:
	@echo "building"
	@ocamlc -c graph.mli graph.ml gfile.mli gfile.ml
	@ocamlc -o ftest graph.cmo gfile.cmo ftest.ml

	@echo "finished build"
	@echo "**********"
	@echo ""

clean:
	@rm *.cmo *.cmi ftest
