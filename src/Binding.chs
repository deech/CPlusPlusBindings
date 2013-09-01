{-# LANGUAGE CPP #-}
module Binding where
#include "A_C.h"
{#enum hello_world as HelloWorld {}#}
{#fun unsafe A_static_function as static_function {} -> `()'#}
