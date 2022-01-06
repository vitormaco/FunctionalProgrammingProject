GRAPH=graph1
COMPANY=company1

run: build
	./ftest test_cases/$(GRAPH).txt 0 5 test_cases/$(GRAPH).viz
	@echo ""
	@echo ""
	@cat test_cases/$(GRAPH).viz
	@dot -Tsvg test_cases/$(GRAPH).viz > test_cases/$(GRAPH).svg;
	@xdg-open test_cases/$(GRAPH).svg

build:
	@ocamlc -c graph.mli graph.ml gfile.mli gfile.ml tools.mli tools.ml company.mli company.ml cfile.mli cfile.ml 
	@ocamlc -o ctest company.cmo cfile.cmo ctest.ml
	@ocamlc -o ftest graph.cmo gfile.cmo tools.cmo ftest.ml

clean:
	@rm *.cmo *.cmi ftest test_cases/*.svg test_cases/*.viz -f
	@echo "cleaned"

gen_svgs:
	@echo "generating"
	@for viz_file in $(shell ls test_cases/*.viz); do dot -Tsvg $${viz_file} > $${viz_file::-4}.svg; done
	@echo "generated"

medium: build
	./ctest test_cases/$(COMPANY).txt