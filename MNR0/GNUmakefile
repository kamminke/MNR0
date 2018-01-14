#   ****************************************************************
#
#       File:       $(PROJECT)/GNUmakefile
# 
#       Purpose:    Root Makefile
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   Copyright (c) 2017 by kamminke <kamminke@posteo.ee>
#   All rights reserved.
#
#   Redistribution and use in souce and binary form, with or without
#   modification, are permitted provided that the following conditions are met:
#
#   * Redistributions of souce code must retain the above copyright notice, this
#     list of conditions and the following disclaimer.
#
#   * Redistributions of binary form must reproduce the above copyright notice,
#     this list of conditions and the following disclaimer in the documentation
#     and/or other materials provided with the distribution.
#
#   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PRUPOSE ARE
#   DISCLAINED. IN  NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SBSTITUTE GOODS OR
#   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#   ----------------------------------------------------------------
#                           DEFINITIONS
#   ----------------------------------------------------------------

#   Main project depending definitions, see file $(PROJECT).configuration
#   for project name, Source configuration switches and testcases.
#   Please change this file $(PROJECT).configuration for configuration 
#   purposes only!

include *.configuration

#   make build system defines

HDL ?=                  verilog
STEP ?=                 rtl
MODE ?=                 batch

#   directory pathes

BACKENDDIR =            Backend
LIBRARYDIR =            Library
SIMULATIONDIR =         Simulation
SOURCESDIR =            Sources
TBENCHDIR =             TBench
TEMPLATESDIR =          Templates

#   tool variables

ECHO ?=                 @echo # -e
TAR ?=                  tar -zh
DATE :=                 $(shell date +%Y%m%d)

#   default

DISTRIBUTION =          ./GNUMakefile ./LICENSE $(PROJECT).* \
                        $(BACKENDDIR) $(LIBRARYDIR) $(SOURCESDIR) \
                        $(TBENCHDIR) $(TEMPLATESDIR) 

#   ----------------------------------------------------------------
#                       DEFAULT TARGETS
#   ----------------------------------------------------------------

#   display help screen if no target is specified

.PHONY: help
help:
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) "    available targets:"
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) ""
	$(ECHO) "    help       - print this help screen"
	$(ECHO) "    dist       - build a tarball with all important files"
	$(ECHO) "    clean-all  - clean up all intermediate files"
	$(ECHO) ""
	$(ECHO) "    <testcase> - run this specified test case (see list below)"
	$(ECHO) "    [MODE=batch|report|gui] <testcase>"
	$(ECHO) "               - run test in batch | report | gui mode (default: $(MODE))"
	$(ECHO) "    [STEP=rtl|pre|post] <testcase>"
	$(ECHO) "               - run test on rtl | pre-routed | post-routed (default: $(STEP))"
	$(ECHO) "    tests      - run all test cases (see list below)"
	$(ECHO) ""
	$(ECHO) "    netlist    - generate netlist"
	$(ECHO) "    par        - place and route"
	$(ECHO) "    build      - build delivery format"
	$(ECHO) "    all        - run all backend steps"
	$(ECHO) ""
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) "    available testcases:"
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) ""
	$(ECHO) "    $(TESTS)"
	$(ECHO) ""

#       make archiv by building a tarball with all important files

.PHONY: dist
dist: clean-all
	$(ECHO) "----    build a tarball with all important files    ----"
	$(TAR) -cvf $(PROJECT)_$(DATE).tgz $(DISTRIBUTION)

.PHONY: clean-all
clean-all:
	$(ECHO) "----    clean up all intermediate files    ----"
	$(MAKE) -C $(SIMULATIONDIR) -f simulation.mk clean
	$(MAKE) -C $(BACKENDDIR) -f backend.mk clean

#   ----------------------------------------------------------------
#                       BUILD MAIN TARGETS 
#   ----------------------------------------------------------------

.PHONY: tests
tests: $(TESTS) 

.PHONY: netlist
netlist:
	$(MAKE) -C $(BACKENDDIR) -f backend.mk $@

.PHONY: par
par: netlist
	$(MAKE) -C $(BACKENDDIR) -f backend.mk $@

.PHONY: export
export: par
	$(MAKE) -C $(BACKENDDIR) -f backend.mk $@

.PHONY: all
all: export

%:
	$(MAKE) -C $(SIMULATIONDIR) -f simulation.mk STEP=$(STEP) MODE=$(MODE) $@
