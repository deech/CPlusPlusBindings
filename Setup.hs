{-# LANGUAGE CPP #-}
import Distribution.Simple
import Distribution.Simple.Utils
import Distribution.Verbosity
import Control.Monad
import Distribution.Simple.Program
import System.IO.Unsafe (unsafePerformIO)
import System.IO.Error
import Distribution.Simple.BuildPaths
import System.Directory(getCurrentDirectory, getDirectoryContents)
import System.Environment (getEnv, setEnv)

main :: IO ()
main = defaultMainWithHooks simpleUserHooks {
  buildHook = myBuildHook,
  cleanHook = myCleanHook
  }

clibdir = unsafePerformIO getCurrentDirectory ++ "/c-src"
cpplibdir = unsafePerformIO getCurrentDirectory ++ "/cpp-src"

addToEnvironmentVariable :: String -> String -> IO ()
addToEnvironmentVariable env value = do
  envValue <- tryIOError (getEnv env)
  setEnv env ((either (const "") (\curr -> curr ++ ":") envValue) ++ value)


myBuildHook pkg_descr local_bld_info user_hooks bld_flags =
  do clibs <- getDirectoryContents clibdir
     when (null $ filter ((==) "libA_C.a") clibs) $ do
             putStrLn "==Compiling C bindings=="
             rawSystemExit normal "make" []
     addToEnvironmentVariable "C_INCLUDE_PATH" clibdir
     addToEnvironmentVariable "LIBRARY_PATH" clibdir
     addToEnvironmentVariable "LIBRARY_PATH" cpplibdir
     buildHook simpleUserHooks pkg_descr local_bld_info user_hooks bld_flags

myCleanHook pd x uh cf = do
  rawSystemExit normal "make" ["clean"]
  cleanHook simpleUserHooks pd x uh cf
