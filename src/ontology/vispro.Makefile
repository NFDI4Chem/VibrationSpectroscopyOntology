## Customize Makefile settings for vispro
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile


## Module for ontology: txpo

$(IMPORTDIR)/txpo_import.owl: $(MIRRORDIR)/txpo.owl $(IMPORTDIR)/txpo_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query  -i $< --update ../sparql/preprocess-module_provo_op.ru \
		extract -T $(IMPORTDIR)/txpo_terms_combined.txt --copy-ontology-annotations true --force true --individuals include --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/inject-synonymtype-declaration.ru --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Module for ontology: iao

$(IMPORTDIR)/iao_import.owl: $(MIRRORDIR)/iao.owl $(IMPORTDIR)/iao_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query  -i $< --update ../sparql/preprocess-module_provo.ru \
		extract -T $(IMPORTDIR)/iao_terms_combined.txt --copy-ontology-annotations true --force true --individuals include --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/inject-synonymtype-declaration.ru --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Module for ontology: obi

$(IMPORTDIR)/obi_import.owl: $(MIRRORDIR)/obi.owl $(IMPORTDIR)/obi_terms.txt
	if [ $(IMP) = true ]; then $(ROBOT) filter -i $< -T $(IMPORTDIR)/obi_terms.txt --select "self ancestors equivalents" --axioms "disjoint tbox rbox" --signature false --trim true \
		--output $@.tmp.owl; fi
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module_provo.ru \
		filter -T $(IMPORTDIR)/obi_terms.txt --select "self annotations domains ranges equivalents instances ontology" --axioms "disjoint tbox rbox" --signature false --trim true \
		query --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
		merge -i $@.tmp.owl \
		--output $@.tmp.owl && mv $@.tmp.owl $@; fi


## Module for ontology: pato

$(IMPORTDIR)/pato_import.owl: $(MIRRORDIR)/pato.owl $(IMPORTDIR)/pato_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query  -i $< --update ../sparql/preprocess-module_provo.ru \
		extract -T $(IMPORTDIR)/pato_terms_combined.txt --copy-ontology-annotations true --force true --individuals include --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/inject-synonymtype-declaration.ru --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Module for ontology: ro

$(IMPORTDIR)/ro_import.owl: $(MIRRORDIR)/ro.owl $(IMPORTDIR)/ro_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query  -i $< --update ../sparql/preprocess-module_provo_op.ru \
		extract -T $(IMPORTDIR)/ro_terms_combined.txt --copy-ontology-annotations true --force true --individuals exclude --method BOT \
		query --update ../sparql/preprocess-module_provo_op.ru --update ../sparql/inject-subset-declaration.ru --update ../sparql/inject-synonymtype-declaration.ru --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## ONTOLOGY: efo
# customize the make base mirror recipe by providing the propper base-iri
#.PHONY: mirror-efo
#.PRECIOUS: $(MIRRORDIR)/efo.owl
#mirror-efo: | $(TMPDIR)
#	if [ $(MIR) = true ] && [ $(IMP) = true ]; then $(ROBOT) convert -I http://www.ebi.ac.uk/efo/efo.owl -o $@.tmp.owl && \
		$(ROBOT) remove -i $@.tmp.owl --base-iri http://www.ebi.ac.uk/efo/ --axioms external --preserve-structure false --trim false -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi

## Module for ontology: efo

#$(IMPORTDIR)/efo_import.owl: $(MIRRORDIR)/efo.owl $(IMPORTDIR)/efo_terms_combined.txt
#	if [ $(IMP) = true ]; then $(ROBOT) query  -i $< --update ../sparql/preprocess-module_provo.ru \
		extract -T $(IMPORTDIR)/efo_terms_combined.txt --copy-ontology-annotations true --force true --individuals include --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/inject-synonymtype-declaration.ru --update ../sparql/postprocess-module_2.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi