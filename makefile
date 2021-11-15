GRAPH=graph1

run: build
	@echo "Starting execution"

	./ftest test_cases/$(GRAPH).txt 0 5 $(GRAPH).out
	@echo "Finished execution"
	@echo ""
	@echo "***** Output *****"
	@cat $(GRAPH).out

build:
	@echo "building"
	@ocamlc -c graph.mli graph.ml gfile.mli gfile.ml tools.mli tools.ml
	@ocamlc -o ftest graph.cmo gfile.cmo tools.cmo ftest.ml

	@echo "finished build"
	@echo "**********"
	@echo ""

clean:
	@rm *.cmo *.cmi ftest
	@echo "cleaned"

gen_svgs:
	@echo "generating"
	@for viz_file in $(shell ls test_cases/*.viz); do dot -Tsvg $${viz_file} > $${viz_file::-4}.svg; done
	@echo "generated"

clean_svgs:
	@rm test_cases/*.svg
	@echo "cleaned"
