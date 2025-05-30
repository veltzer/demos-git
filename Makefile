##############
# parameters #
##############
# do you want to see the commands executed ?
DO_MKDBG:=0
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1
# do you want to check bash syntax?
DO_CHECK_SYNTAX:=1
# do you want to run mdl on md files?
DO_MD_MDL:=1
# do spell check on all?
DO_MD_ASPELL:=1

########
# code #
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

ALL_SH_SRC:=$(shell find . -type f -name "*.sh" -and -not -path "./.venv/*" -printf "%P\n")
ALL_SH_CHECK:=$(addprefix out/, $(addsuffix .check, $(ALL_SH_SRC)))

MD_SRC:=$(shell find exercises -type f -and -name "*.md")
MD_BAS:=$(basename $(MD_SRC))
MD_MDL:=$(addprefix out/,$(addsuffix .mdl,$(MD_BAS)))
MD_ASPELL:=$(addprefix out/,$(addsuffix .aspell,$(MD_BAS)))

ifeq ($(DO_CHECK_SYNTAX),1)
ALL+=$(ALL_SH_CHECK)
endif # DO_CHECK_SYNTAX

ifeq ($(DO_MD_MDL),1)
ALL+=$(MD_MDL)
endif # DO_MD_MDL

ifeq ($(DO_MD_ASPELL),1)
ALL+=$(MD_ASPELL)
endif # DO_MD_ASPELL

#########
# rules #
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
	$(info MD_SRC is $(MD_SRC))
	$(info MD_BAS is $(MD_BAS))
	$(info MD_ASPELL is $(MD_ASPELL))
	$(info MD_MDL is $(MD_MDL))
	$(info ALL_SH_SRC is $(ALL_SH_SRC))
	$(info ALL_SH_CHECK is $(ALL_SH_CHECK))

.PHONY: first_line_stats
first_line_stats:
	$(Q)head -1 -q $(ALL_SH) | sort | uniq -c

.PHONY: clean
clean:
	$(Q)rm -f $(ALL)

.PHONY: clean_hard
clean_hard:
	$(Q)git clean -qffxd

.PHONY: spell_many
spell_many:
	$(info doing [$@])
	$(Q)aspell_many.sh $(MD_SRC)

############
# patterns #
############
$(ALL_SH_CHECK): out/%.check: % .shellcheckrc
	$(info doing [$@])
	$(Q)shellcheck --shell=bash --external-sources --source-path="$${HOME}" $<
	$(Q)pymakehelper touch_mkdir $@
$(MD_MDL): out/%.mdl: %.md .mdlrc .mdl.style.rb
	$(info doing [$@])
	$(Q)GEM_HOME=gems gems/bin/mdl $<
	$(Q)mkdir -p $(dir $@)
	$(Q)touch $@
$(MD_ASPELL): out/%.aspell: %.md .aspell.conf .aspell.en.prepl .aspell.en.pws
	$(info doing [$@])
	$(Q)aspell --conf-dir=. --conf=.aspell.conf list < $< | pymakehelper error_on_print sort -u
	$(Q)pymakehelper touch_mkdir $@

##########
# alldep #
##########
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP
