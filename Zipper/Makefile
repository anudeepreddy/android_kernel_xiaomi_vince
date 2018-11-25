NAME ?= Genom-EAS


DATE := $(shell date "+%Y%m%d-%I%M")

CODE := MIUI-CAF

ZIP := $(NAME)-$(CODE)-$(DATE).zip
CZIP := $(NAME)-$(CODE)-Clang-$(DATE).zip

EXCLUDE := Makefile *.git* *.jar* Dark-Ages* *placeholder*

normal: $(ZIP)
nclang: $(CZIP)

$(ZIP):
	@echo "Creating ZIP: $(ZIP)"
	@zip -r9 "$@" . -x $(EXCLUDE)
	@echo "Generating SHA1..."
	@sha1sum "$@" > "$@.sha1"
	@cat "$@.sha1"
	@echo "Done."

$(CZIP):
	@echo "Creating ZIP: $(CZIP)"
	@zip -r9 "$@" . -x $(EXCLUDE)
	@echo "Generating SHA1..."
	@sha1sum "$@" > "$@.sha1"
	@cat "$@.sha1"
	@echo "Done."


clean:
	@rm -vf "$(NAME)-"*.zip*
	@rm -vf kernel/Image.gz
	@rm -vf modules/system/lib/modules/*.ko*
	@rm -vf modules/system/lib/modules/pronto/*.ko*
	@rm -vf kernel/normal/*.dtb*
	@echo "Done."


