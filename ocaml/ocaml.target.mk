### ocaml.target.mk -- Target variable

# Author: Michael Grünewald
# Date: Mar  5 avr 2005 10:31:04 GMT

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2006-2009, 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# This module reads the TARGET variable describing the kind of code
# that shall be produced and defines several variables that can be
# used as predicates in the sequel.
#
# A predicate is true if, and only if, the corresponding variable is
# defined.

#  TARGET = byte_code|native_code|both|bc|nc|byte|native
# .include "ocaml.target.mk"


### DESCRIPTION

# Variables:
#
# TARGET
#   List of targeted code generators
#
#   If this variable contains one of the words byte_code, byte,
#   or both, then the production of byte objects is required.
#
#   If this variable contains one of the words native_code, native
#   or both, then the production of native objects is required.


# Exports:
#
# _OCAML_COMPILE_BYTE
#   Predicate telling if the production of byte objects is required
#
#
# _OCAML_COMPILE_NATIVE
#   Predicate telling if the production of native objects is required
#
#
# _OCAML_COMPILE_NATIVE_ONLY
#   Predicate telling if the production requirement narrows to native objects
#
#
# _OCAML_COMPILE_BOTH
#   Predicate telling if the production requirement includes both types

.if !target(__<ocaml.target.mk>__)
__<ocaml.target.mk>__:

.SUFFIXES: .ml .mli .mll .mly .cmi .cmo .cma .cmx .cmxa .cb .cn
# .cb CAML bytecode
# .cn CAML native object

.if !defined(TARGET) || empty(TARGET)
TARGET = byte_code
.endif

.if !empty(TARGET:Mbyte_code)||!empty(TARGET:Mbyte) || !empty(TARGET:Mboth)
_OCAML_COMPILE_BYTE= yes
.else
.undef _OCAML_COMPILE_BYTE
.endif

.if !empty(TARGET:Mnative_code)||!empty(TARGET:Mnative) || !empty(TARGET:Mboth)
_OCAML_COMPILE_NATIVE= yes
.else
.undef _OCAML_COMPILE_NATIVE
.endif

.if defined(_OCAML_COMPILE_NATIVE)&&defined(_OCAML_COMPILE_BYTE)
_OCAML_COMPILE_BOTH=yes
.else
.undef _OCAML_COMPILE_BOTH
.endif

.if defined(_OCAML_COMPILE_NATIVE)&&!defined(_OCAML_COMPILE_BYTE)
_OCAML_COMPILE_NATIVE_ONLY=yes
.else
.undef _OCAML_COMPILE_NATIVE_ONLY
.endif

.endif #!target(__<ocaml.target.mk>__)

### End of file `ocaml.target.mk'
