TrueIndent
==========

VIM plugin for make true indents

Problem
-------

My settings in .vimrc:

    set ts=4
    set sw=4
    set noet
    set lcs=tab:>-,trail:⇒

Example source on JavaScript:

    var debugmode = true;
    var f = function(arg) {
    >---console.debug( window,
    >---               this,
    >---               arg );
    >---if ( debugmode === true ) {
    >--->---debugger;
    >---}
    };
    f( { a: 'aaa', b: 'bbb' } );

">---" - tab symbols.

After increment indent of body "f" with standart vim functions (3gg6>>):

    var debugmode = true;
    var f = function(arg) {
    >--->---console.debug( window,
    >--->--->--->--->---   this,
    >--->--->--->--->---   arg );
    >--->---if ( debugmode === true ) {
    >--->--->---debugger;
    >--->---}
    };
    f( { a: 'aaa', b: 'bbb' } );

After increment indent with new functions:

    var debugmode = true;
    var f = function(arg) {
    >--->---console.debug( window,
    >--->---               this,
    >--->---               arg );
    >--->---if ( debugmode === true ) {
    >--->--->---debugger;
    >--->---}
    };
    f( { a: 'aaa', b: 'bbb' } );

Installation
------------

For pathogen:

    cd ~/.vim/bundle
    git clone https://github.com/tpope/vim-repeat.git
    git clone https://github.com/pavel-g/TrueIndent.git

License
=======

GPLv3
