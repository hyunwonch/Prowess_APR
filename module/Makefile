

FILE_NAME       = template_example1
TEMPLATE_NAME	= template_module

.PHONY: build

build:
	cp -r template ./$(FILE_NAME)
	cd $(FILE_NAME); \
						grep -lr "$(TEMPLATE_NAME)" | xargs sed -i 's/$(TEMPLATE_NAME)/$(FILE_NAME)/g';	\
						find verilog -iname '$(TEMPLATE_NAME).sv' -exec rename '$(TEMPLATE_NAME)' '$(FILE_NAME)' {} +;	\
						find verilog -iname '$(TEMPLATE_NAME).svh' -exec rename '$(TEMPLATE_NAME)' '$(FILE_NAME)' {} +