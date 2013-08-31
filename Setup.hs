import Data.Maybe(fromJust)
import Distribution.PackageDescription
import Distribution.Simple
import System.IO.Unsafe (unsafePerformIO)
import System.Directory(getCurrentDirectory)

main = defaultMainWithHooks simpleUserHooks {buildHook = myBuildHook}
clib = "A_C"       
clibdir = unsafePerformIO getCurrentDirectory ++ "/c-src"
cppincludes = unsafePerformIO getCurrentDirectory ++ "/cpp-includes"
cpplib = unsafePerformIO getCurrentDirectory ++ "/cpp-src"

addIncludeDirs pd =
  let lib = (fromJust . library) $ pd
      bi = libBuildInfo lib
      ids = includeDirs bi
      bi' = bi {includeDirs = ids ++ [clibdir, cppincludes]}
      lib' = lib {libBuildInfo = bi'}
  in
  pd {library = Just lib'}

addLibDirs pd =
  let lib = (fromJust . library) $ pd
      bi = libBuildInfo lib
      dirs = extraLibDirs bi
      bi' = bi {extraLibDirs = dirs ++ [clibdir, cpplib]}
      lib' = lib {libBuildInfo = bi'}
  in
  pd {library = Just lib'}


addLib pd =
  let lib = (fromJust . library) $ pd
      bi = libBuildInfo lib
      elibs = extraLibs bi
      bi' = bi {extraLibs = elibs ++ [clib]}
      lib' = lib {libBuildInfo = bi'}
  in
  pd {library = Just lib'}

myBuildHook pkg_descr local_bld_info user_hooks bld_flags =
    do
      let new_pkg_descr = (addLib . addLibDirs . addIncludeDirs $ pkg_descr)
      buildHook simpleUserHooks new_pkg_descr local_bld_info user_hooks bld_flags
