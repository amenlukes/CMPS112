{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_hw2_random_art (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/shawnchumbar/Library/Haskell/bin"
libdir     = "/Users/shawnchumbar/Library/Haskell/ghc-8.6.3-x86_64/lib/hw2-random-art-0.1.0.0"
dynlibdir  = "/Users/shawnchumbar/Library/Haskell/ghc-8.6.3-x86_64/lib/x86_64-osx-ghc-8.6.3"
datadir    = "/Users/shawnchumbar/Library/Haskell/share/ghc-8.6.3-x86_64/hw2-random-art-0.1.0.0"
libexecdir = "/Users/shawnchumbar/Library/Haskell/libexec/x86_64-osx-ghc-8.6.3/hw2-random-art-0.1.0.0"
sysconfdir = "/Users/shawnchumbar/Library/Haskell/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hw2_random_art_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hw2_random_art_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "hw2_random_art_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "hw2_random_art_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hw2_random_art_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hw2_random_art_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
