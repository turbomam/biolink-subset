RUN=poetry run

biolink_subset_all: biolink_subset_cleanup src/biolink_subset/schema/biolink_subset.yaml

biolink_subset_cleanup:
	rm -rf src/biolink_subset/schema/biolink_subset.yaml
	mkdir -p src/biolink_subset/schema
	touch src/biolink_subset/schema/.gitkeep

src/biolink_subset/schema/biolink_subset.yaml: biolink_shuttle_template.yaml \
biolink_shuttle.tsv
		$(RUN) do_shuttle \
			--config_tsv  $(word 2,$^) \
			--recipient_model $(word 1,$^) \
			--yaml_output $@