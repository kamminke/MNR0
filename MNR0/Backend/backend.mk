#   ****************************************************************
#
#       File:       $(PROJECT)/$(BACKENDDIR)/backend.mk
#
#       Purpose:    sub makefile for backend
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
#                       DEFINITIONS
#   ----------------------------------------------------------------

#   Main project depending definitions, see file $(PROJECT).configuration
#   for project name, Source configuration switches and testcases.
#   Please change this file $(PROJECT).configuration for configuration 
#   purposes only!

include ../*.configuration

#   make build system defines

HDL ?=                  verilog
STEP ?=                 rtl
MODE ?=                 batch
TOP ?=                  $(TARGET)$(SIZE)_$(PACKAGE)

#   directory pathes

BACKENDDIR =            ../Backend
LIBRARYDIR =            ../Library
SOURCESDIR =            ../Sources

#   backend directory names

NETLISTDIR =            netlist
PARDIR =                par
EXPORTDIR =             export

#   tool variables

ECHO ?=                 @echo # -e
RM ?=                   /bin/rm -f

#   ----------------------------------------------------------------
#                       DEFAULT TARGETS
#   ----------------------------------------------------------------

.PHONY: clean
clean:
	$(MAKE) -C $(NETLISTDIR) -f netlist.mk $@
	$(MAKE) -C $(PARDIR) -f par.mk $@
	$(MAKE) -C $(EXPORTDIR) -f export.mk $@

#   ----------------------------------------------------------------
#                       RUN BACKEND
#   ----------------------------------------------------------------

.PHONY: netlist
netlist:
	$(MAKE) -C $(NETLISTDIR) -f netlist.mk TOP=$(TOP) $@

.PHONY: par
par:
	$(MAKE) -C $(PARDIR) -f par.mk TOP=$(TOP) $@

.PHONY: export
export:
	$(MAKE) -C $(EXPORTDIR) -f export.mk TOP=$(TOP) $@
