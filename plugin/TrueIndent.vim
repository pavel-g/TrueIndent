" Author:  Gnedov Pavel
" License: GPLv3

" ===============================

nmap >> :call SetTrueIndent(1)<CR>
nmap << :call SetTrueIndent(-1)<CR>
vmap > :call SetTrueIndent(1)<CR>
vmap < :call SetTrueIndent(-1)<CR>
imap <C-t> <ESC>:call SetTrueIndent(1)<CR><Right>a
imap <C-d> <ESC>:call SetTrueIndent(-1)<CR>i

" ===============================

python3 << endpython

import vim
import re

def DeleteIndents( firstLine, lastLine, count, etMode, tabSize ):
	indentRe = re.compile( "^(\\t| {1," + tabSize + "})" );
	line = ""
	for lineNumber in range( int(firstLine) - 1, int(lastLine) ):
		line = vim.current.buffer[lineNumber]
		for i in range( 0, count ):
			line = indentRe.sub( "", line )
		vim.current.buffer[lineNumber] = line


def InsertIndents( firstLine, lastLine, count, etMode, tabSize ):
	tab = ""
	if etMode == "0":
		tab = "\t"
	else:
		tab = " " * int(tabSize)
	indent = tab * int(count)

	regexp = re.compile("^(\\s+|)$")
	line = ""
	for lineNumber in range( int(firstLine) - 1, int(lastLine) ):
		line = vim.current.buffer[lineNumber]
		if not( regexp.match(line) ):
			line = indent + line
			vim.current.buffer[lineNumber] = line

endpython

" ===============================

function! SetTrueIndent(count) range
silent! call SetTrueIndentInit()
python3 << EOF
vim.command("silent! call SetTrueIndentInit()")
try:

	firstLine  = vim.eval("a:firstline")
	lastLine   = vim.eval("a:lastline")
	count      = int( vim.eval("a:count") )
	etMode     = vim.eval("&expandtab")
	shiftWidth = vim.eval("&shiftwidth")
	tabSize    = vim.eval("&ts")

	if count > 0:
		InsertIndents( firstLine, lastLine, count, etMode, tabSize )
	elif count < 0:
		DeleteIndents( firstLine, lastLine, abs(count), etMode, tabSize )


except Exception as e:
	print e

EOF

let l:firstLine = a:firstline
let l:lastLine = a:lastline
if a:count > 0
	silent! call repeat#set( "\:\<C-u>silent! call SetPlusIndent( ".l:firstLine.", ".l:lastLine." )\<CR>" )
elseif a:count < 0
	silent! call repeat#set( "\:\<C-u>silent! call SetMinusIndent( ".l:firstLine.", ".l:lastLine." )\<CR>" )
endif

endfunction

" ===============================

function! SetPlusIndent( firstLine, lastLine ) range
silent! call SetTrueIndentInit()
python3 << EOF
try:

	firstLine  = vim.eval("a:firstLine")
	lastLine   = vim.eval("a:lastLine")
	count      = 1
	etMode     = vim.eval("&expandtab")
	shiftWidth = vim.eval("&shiftwidth")
	tabSize    = vim.eval("&ts")

	InsertIndents( firstLine, lastLine, count, etMode, tabSize )
	

except Exception as e:
	print e

EOF
let l:firstLine = a:firstLine
let l:lastLine = a:lastLine
silent! call repeat#set( "\:\<C-u>silent! call SetPlusIndent( ".l:firstLine.", ".l:lastLine." )\<CR>" )

endfunction

" ===============================

function! SetMinusIndent( firstLine, lastLine ) range
silent! call SetTrueIndentInit()
python3 << EOF
try:

	firstLine  = vim.eval("a:firstLine")
	lastLine   = vim.eval("a:lastLine")
	count      = 1
	etMode     = vim.eval("&expandtab")
	shiftWidth = vim.eval("&shiftwidth")
	tabSize    = vim.eval("&ts")

	DeleteIndents( firstLine, lastLine, abs(count), etMode, tabSize )

except Exception as e:
	print e

EOF
let l:firstLine = a:firstLine
let l:lastLine = a:lastLine
silent! call repeat#set( "\:\<C-u>silent! call SetMinusIndent( ".l:firstLine.", ".l:lastLine." )\<CR>" )

endfunction
