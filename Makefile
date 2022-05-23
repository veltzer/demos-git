##############
# PARAMETERS #
##############
# do you want to see the commands executed ?
DO_MKDBG:=0
# do you want to check bash syntax?
DO_CHECK_SYNTAX:=1
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1

########
# CODE #
########
ALL:=

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

# dependency on the makefile itself
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP

ALL_SH:=$(shell find examples solutions -name "*.sh")
ALL_STAMP:=$(addprefix out/, $(addsuffix .stamp, $(ALL_SH)))

ifeq ($(DO_CHECK_SYNTAX),1)
ALL+=$(ALL_STAMP)
endif # DO_CHECK_SYNTAX

#########
# RULES #
#########
.PHONY: all
all: $(ALL)
	@true

.PHONY: check
check:
	$(info doing [$@])
	$(Q)git grep "<<" examples | grep -v "'COMMENT'" | grep -v "<<<" | grep -v multi_line_comment.bash || exit 0

.PHONY: debug
debug:
	$(info ALL is $(ALL))
	$(info ALL_SH is $(ALL_SH))
	$(info ALL_STAMP is $(ALL_STAMP))

.PHONY: first_line_stats
first_line_stats:
	$(Q)head -1 -q $(ALL_SH) | sort | uniq -c

.PHONY: clean
clean:
	$(Q)rm -f $(ALL)

.PHONY: clean_hard
clean_hard:
	$(Q)git clean -qffxd

############
# patterns #
############
$(ALL_STAMP): out/%.stamp: % .shellcheckrc
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)shellcheck --severity=error --shell=bash --external-sources --source-path="$$HOME" $<
	$(Q)touch $@
