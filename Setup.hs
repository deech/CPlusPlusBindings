{-# LANGUAGE CPP #-}
import Data.Maybe(fromJust, isJust, fromMaybe, maybeToList)
import Distribution.Simple.Compiler
import Distribution.Simple.LocalBuildInfo
import Distribution.PackageDescription
import Distribution.Simple
import Distribution.System
import Distribution.Simple.Setup
import Distribution.Simple.Utils
import Distribution.Verbosity
import Distribution.Text ( display )
import Control.Monad
import Data.List
import Distribution.Simple.Program
import Distribution.Simple.Program.Db
import Distribution.Simple.PreProcess
import Distribution.Simple.Register ( generateRegistrationInfo, registerPackage )
import System.IO.Unsafe (unsafePerformIO)
import System.IO.Error
import qualified Distribution.Simple.Program.Ar    as Ar
import qualified Distribution.ModuleName as ModuleName
import Distribution.Simple.BuildPaths
import System.Directory(getCurrentDirectory, getDirectoryContents, doesDirectoryExist)
import System.FilePath ( (</>), (<.>), takeExtension, combine, takeBaseName)
import qualified Distribution.Simple.GHC  as GHC
import qualified Distribution.Simple.JHC  as JHC
import qualified Distribution.Simple.LHC  as LHC
import qualified Distribution.Simple.UHC  as UHC
import qualified Distribution.Simple.PackageIndex as PackageIndex
import Distribution.PackageDescription as PD
import Distribution.InstalledPackageInfo (extraGHCiLibraries, showInstalledPackageInfo)
import System.Environment (getEnv, setEnv)

main :: IO ()
main = defaultMainWithHooks simpleUserHooks {
  buildHook = myBuildHook,
  cleanHook = myCleanHook
  }

clibdir = unsafePerformIO getCurrentDirectory ++ "/c-src"

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
     buildHook simpleUserHooks pkg_descr local_bld_info user_hooks bld_flags

myCleanHook pd x uh cf = do
  rawSystemExit normal "make" ["clean"]
  cleanHook defaultUserHooks pd x uh cf
