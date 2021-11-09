run: build
	./ftest

build:
	@echo "building"
	@ocamlc -c graph.mli graph.ml gfile.mli gfile.ml
	@ocamlc -o ftest graph.cmo gfile.cmo ftest.ml

	@echo "finished build"
	@echo "**********"
	@echo ""

clean:
	@rm *.cmo *.cmi ftest
