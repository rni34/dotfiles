#!/bin/bash

swipl \
	-g "use_module(library(lsp_server))." \
	-g "lsp_server:main" \
	-t "halt" \
	-- stdio
