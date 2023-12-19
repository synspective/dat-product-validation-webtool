SHELL=/bin/bash

GCS_BACKET := syns-sol-grdsys-external-prod_product-datasets
#DATASETS := 202312-00011 202312-00006
DATASETS := aaa bbb


download:
	mkdir -p datasets
	gsutil -m rsync -r -x '^(?!202312-.*\.tif$$)' gs://$(GCS_BACKET)/datasets datasets

