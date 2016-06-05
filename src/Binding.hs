{-# LANGUAGE ForeignFunctionInterface #-}

module Binding where
import Foreign.Ptr

foreign import ccall unsafe "A_new" a_new :: IO (Ptr ())
foreign import ccall unsafe "A_member_function" member_function :: Ptr () -> IO ()
foreign import ccall unsafe "A_static_function" static_function :: IO ()