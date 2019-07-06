module Paths_hw4_nano (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/shawnchumbar/Desktop/CMPS112/schumbar/hw4-schumbar/.stack-work/install/x86_64-osx/lts-5.9/7.10.3/bin"
libdir     = "/Users/shawnchumbar/Desktop/CMPS112/schumbar/hw4-schumbar/.stack-work/install/x86_64-osx/lts-5.9/7.10.3/lib/x86_64-osx-ghc-7.10.3/hw4-nano-0.1.0.0-1MRODJ7cnXX04Ba45VKUdD"
datadir    = "/Users/shawnchumbar/Desktop/CMPS112/schumbar/hw4-schumbar/.stack-work/install/x86_64-osx/lts-5.9/7.10.3/share/x86_64-osx-ghc-7.10.3/hw4-nano-0.1.0.0"
libexecdir = "/Users/shawnchumbar/Desktop/CMPS112/schumbar/hw4-schumbar/.stack-work/install/x86_64-osx/lts-5.9/7.10.3/libexec"
sysconfdir = "/Users/shawnchumbar/Desktop/CMPS112/schumbar/hw4-schumbar/.stack-work/install/x86_64-osx/lts-5.9/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hw4_nano_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hw4_nano_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "hw4_nano_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hw4_nano_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hw4_nano_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
