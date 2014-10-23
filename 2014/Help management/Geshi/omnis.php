<?php
/*************************************************************************************
 * omnis.php
 * ---------------------------------
 * Author: Bastiaan Olij (bastiaan@basenlily.me)
 * Copyright: (c) 2014 Bastiaan Olij (http://bastiaanolij.blogspot.com/)
 * Release Version: 1.0.8.11
 * Date Started: 2014/10/21
 *
 * Omnis language file for GeSHi.
 *
 * CHANGES
 * -------
 * 2014/10/22 (1.0.0)
 *  -  First Release
 *
 * TODO (updated 2014/10/22)
 * -------------------------
 *  -  Complete keywords
 *
 *************************************************************************************
 *
 *     This file is part of GeSHi.
 *
 *   GeSHi is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   GeSHi is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with GeSHi; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 ************************************************************************************/
 
$language_data = array (
    'LANG_NAME' => 'OMNIS',
    'COMMENT_SINGLE' => array(1 => '; ', 2 => ';; '),
    'COMMENT_MULTI' => '',
    'CASE_KEYWORDS' => GESHI_CAPS_NO_CHANGE,
    'QUOTEMARKS' => array("'", '"'),
    'ESCAPE_CHAR' => '',
    'KEYWORDS' => array(
        1 => array( // control structures
            'If', 'If flag true', 'If flag false', 'If canceled', 'Else', 'End if',
            'While', 'While flag true', 'While flag false', 'End while',
            'For', 'For each line in list', 'End for',
            'Switch', 'Case', 'Default', 'Break to end of switch', 'End switch',
            'Repeat', 'Until flag true', 'Until flag false', 'Until', 'Until break',
            'Break to end of loop', 'Jump to start of loop',
			'Begin reversible block', 'End reversible block',
			'On'
            ),
        2 => array( // calculations
			'Calculate', 'Test for valid calculation'
            ),
        3 => array( // do commands
			'Do inherited', 'Do default', 'Do redirect', 'Do method', 'Do code method', 'Set reference','Do'
            ),
        4 => array( // list commands
			'Set current list', 'Define list', 'Define list from SQL class', 'Redefine list', 'Copy list definition',
			'Build list from file', 'Build list columns list', 'Clear list', 'Search list', 'Sort list', 'Merge list',
			'Swap lists', 'Load from list', 'Replace line in list', 'Add line to list', 'Insert line in list',
			'Delete line in list', 'Clear line in list', 'Select list line(s)', 'Deselect list line(s)',
			'Invert selection for line(s)'
            ),
		5 => array ( // quit and events
		    'Quit event handler', '(Pass to next handler)', 'Discard event',
			'Quit method', 'Quit all methods', 'Quit all if canceled', 'Quit Omnis'
            ),
        6 => array ( // output
		    'OK message', 'Yes/No message'
            ),
        97 => array ( // loose words
		    'to', 'as'
		    ),
		98 => array('kTrue'),
		99 => array('kFalse'),
        ),
    'SYMBOLS' => array(
        0 => array(
            '<'.'%', '<'.'%=', '%'.'>', '<'.'?', '<'.'?=', '?'.'>'
            ),
        1 => array(
            '(', ')', '[', ']', '{', '}',
            '!', '@', '%', '&', '|', '/',
            '<', '>',
            '=', '-', '+', '*',
            '.', ':', ',', ';'
            )
        ),
    'CASE_SENSITIVE' => array(
        GESHI_COMMENTS => false,
        1 => false,
        2 => false,
        3 => false,
        4 => false,
        5 => false,
        9 => false
	    ),
    'STYLES' => array(
		// note, dokuwiki ignores this part of the definition, see <dokuwiki>/conf/userstyle.css ...
        'KEYWORDS' => array(
             1 => 'color: #996600; font-weight: bold;',
             2 => 'color: #000000; font-weight: bold;',
             3 => 'color: #000000; font-weight: bold;',
             4 => 'color: #000000; font-weight: bold;',
             5 => 'color: #000000; font-weight: bold;',
             6 => 'color: #000000; font-weight: bold;',
            97 => 'color: #000000; font-weight: bold;',
            98 => 'color: #00EE00; font-weight: bold;',
            99 => 'color: #EE0000; font-weight: bold;'
		    ),
        'COMMENTS' => array(
            1 => 'color: #FF0000; font-style: italic;'
//            2 => 'color: #FF0000; font-style: italic;'
//            'MULTI' => 'color: #FF0000; font-style: italic;'
            ),
        'ESCAPE_CHAR' => array(
//            0 => 'color: #000099; font-weight: bold;',
//            'HARD' => 'color: #000099; font-weight: bold;'
            ),
        'BRACKETS' => array(
            0 => 'color: #009900;'
            ),
        'STRINGS' => array(
            0 => 'color: #800000;',
            'HARD' => 'color: #800000;'
            ),
        'NUMBERS' => array(
            0 => 'color: #000000;'
            ),
        'METHODS' => array(
            1 => 'color: #000000;'
            ),
        'SYMBOLS' => array(
            0 => 'color: #66cc66;',
            1 => 'color: #66cc66;'
            ),
        'REGEXPS' => array(
            1 => 'color: #996600;', 
            2 => 'color: #996600;'
            ),
        'SCRIPT' => array(
            ),
        ),
	'URLS' => array(
	    1 => '',
	    2 => ''
        ),
    'NUMBERS' =>
        GESHI_NUMBER_INT_BASIC | GESHI_NUMBER_INT_CSTYLE | GESHI_NUMBER_BIN_PREFIX_0B |
        GESHI_NUMBER_OCT_PREFIX | GESHI_NUMBER_HEX_PREFIX | GESHI_NUMBER_FLT_NONSCI |
        GESHI_NUMBER_FLT_NONSCI_F | GESHI_NUMBER_FLT_SCI_SHORT | GESHI_NUMBER_FLT_SCI_ZERO,
    'OOLANG' => false,
	'OBJECT_SPLITTERS' => array(
        ),
	'REGEXPS' => array(
	    1 => "[\\$]+[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*", 
        2 => "ev[A-Z][a-zA-Z0-9]*"
        ),
	'STRICT_MODE_APPLIES' => GESHI_NEVER,
	'SCRIPT_DELIMITERS' => array(
        ),
	'HIGHLIGHT_STRICT_BLOCK' => array(
        ),
	'TAB_WIDTH' => 2
);

?>