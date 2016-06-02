{-# LANGUAGE CPP #-}
module Binding where
import Foreign.Ptr
#include "A_C.h"
{#enum hello_world as HelloWorld {}#}

{#fun A_static_function as static_function {}          -> `()'    #}
{#fun A_member_function as member_function {`Ptr ()' } -> `()'    #}
{#fun A_new             as a_new           {}          -> `Ptr ()'#}
