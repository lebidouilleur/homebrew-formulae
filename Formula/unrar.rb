# coding: utf-8
class Unrar < Formula
  desc     "Extract, view, and test RAR archives"
  homepage "https://www.rarlab.com/"
  license  :cannot_represent



  stable do
    url    "https://www.rarlab.com/rar/unrarsrc-6.0.7.tar.gz"
    sha256 "a7029942006cbcced3f3b7322ec197683f8e7be408972ca08099b196c038f518"
  end


  livecheck do
    url "https://www.rarlab.com/rar_add.htm"
    regex(/href=.*?unrarsrc[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  def install
    # upstream doesn't particularly care about their unix targets,
    # so we do the dirty work of renaming their shared objects to
    # dylibs for them.
    if OS.mac?
      inreplace "makefile", "libunrar.so", "libunrar.dylib"
    end


    system "make"
    bin.install "unrar"


    # Explicitly clean up for the library build to avoid an issue with an
    # apparent implicit clean which confuses the dependencies.
    system "make", "clean"
    system "make", "lib"
    lib.install shared_library("libunrar")


    prefix.install "license.txt"
  end



  def caveats
    <<~EOS
      We agreed to the UnRAR license for you:
        #{opt_prefix}/license.txt
      If this is unacceptable you should uninstall the formula.
    EOS
  end


  test do
    contentpath = "directory/file.txt"
    rarpath = testpath/"archive.rar"
    data =  "UmFyIRoHAM+QcwAADQAAAAAAAACaCHQggDIACQAAAAkAAAADtPej1LZwZE" \
            "QUMBIApIEAAGRpcmVjdG9yeVxmaWxlLnR4dEhvbWVicmV3CsQ9ewBABwA="

    rarpath.write data.unpack1("m")
    assert_equal contentpath, `#{bin}/unrar lb #{rarpath}`.strip
    assert_equal 0, $CHILD_STATUS.exitstatus

    system "#{bin}/unrar", "x", rarpath, testpath
    assert_equal "Homebrew\n", (testpath/contentpath).read
  end
end
