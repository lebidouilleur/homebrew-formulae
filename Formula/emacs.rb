# coding: utf-8
class Emacs < Formula
  desc     "Official GNU/Emacs Text Editor ready out-of-the-box."
  homepage "https://www.gnu.org/software/emacs/"



  stable do
    url    "https://ftp.gnu.org/gnu/emacs/emacs-28.1.tar.xz"
    mirror "https://ftpmirror.gnu.org/emacs/emacs-28.1.tar.xz"
    sha256 "28b1b3d099037a088f0a4ca251d7e7262eab5ea1677aabffa6c4426961ad75e1"

    depends_on "autoconf"    => :build
    depends_on "automake"    => :build
    depends_on "gnu-sed"     => :build
    depends_on "pkg-config"  => :build
    depends_on "texinfo"     => :build

    depends_on "dbus"        => :recommended
    depends_on "gnutls"      => :recommended
    depends_on "harfbuzz"    => :recommended
    depends_on "jansson"     => :recommended
    depends_on "imagemagick" => :recommended
    depends_on "librsvg"     => :recommended
    depends_on "little-cms2" => :recommended
    depends_on "mailutils"   => :recommended
  end

  head do
    url "https://github.com/emacs-mirror/emacs.git"

    depends_on "autoconf"    => :build
    depends_on "automake"    => :build
    depends_on "gnu-sed"     => :build
    depends_on "pkg-config"  => :build
    depends_on "texinfo"     => :build

    depends_on "dbus"        => :recommended
    depends_on "gnutls"      => :recommended
    depends_on "harfbuzz"    => :recommended
    depends_on "jansson"     => :recommended
    depends_on "imagemagick" => :recommended
    depends_on "librsvg"     => :recommended
    depends_on "little-cms2" => :recommended
    depends_on "mailutils"   => :recommended
  end



  # Options:
  option "with-xwidgets",    "⚠ Experimental: build GNU/Emacs with xwigdet support"
  option "with-debug",       "⚠ build GNU/Emacs with debug features"
  option "with-native-comp", "Build with native compilation"



  # Optional dependencies
  if build.with? "native-comp"
    depends_on "gcc"       => :build
    depends_on "gmp"       => :build
    depends_on "libgccjit" => :recommended
    depends_on "libjpeg"   => :build
    depends_on "zlib"      => :build
  end


  # Better icon for macOS >= Big Sur
  if MacOS.version >= :big_sur
    resource "bigsur-icon" do
      url    "https://github.com/d12frosted/homebrew-emacs-plus/blob/master/icons/elrumo2.icns?raw=true"
      sha256 "5eaa76a52b86d5cedb0d43afa7682ad553712e71eed03fe97ea4461f660627db"
    end
  end



  def install
    args = %W[
      --prefix=#{prefix}
      --disable-silent-rules
      --infodir=#{info}/emacs
      --disable-dependency-tracking
      --enable-locallisppath=#{HOMEBREW_PREFIX}/share/emacs/site-lisp

      --without-x
      --without-pop
      --disable-ns-self-contained

      --with-ns
      --with-dbus
      --with-json
      --with-rsvg
      --with-xml2
      --with-gnutls
      --with-modules
      --with-harfbuzz
    ]


    # NOTE: if ./configure is passed --with-imagemagick but can't find the
    # library it does not fail but imagemagick support will not be available.
    # See: https://debbugs.gnu.org/cgi/bugreport.cgi?bug=24455
    args << "--with-imagemagick"

    imagemagick_lib_path = Formula["imagemagick"].opt_lib/"pkgconfig"
    ohai "ImageMagick PKG_CONFIG_PATH: ", imagemagick_lib_path
    ENV.prepend_path "PKG_CONFIG_PATH", imagemagick_lib_path


    if build.with? "debug"
      ohai "Enabling GNU/Emacs debug features..."
      args << "--disable-silent-rules"
      ENV.append_to_cflags "-g3"
    end


    if build.with? "xwidgets"
      args << "--with-xwidgets"
    end


    if build.with? "native-comp"
      args << "--with-native-compilation"

      gcc     = Formula["gcc"].any_installed_version.major
      gcc_lib = "#{HOMEBREW_PREFIX}/lib/gcc/#{gcc}"

      ENV.append "CFLAGS", "-I#{Formula["gcc"].include}"
      ENV.append "CFLAGS", "-I#{Formula["libgccjit"].include}"
      ENV.append "CFLAGS", "-I#{Formula["gmp"].include}"
      ENV.append "CFLAGS", "-I#{Formula["libjpeg"].include}"

      ENV.append "LDFLAGS", "-L#{gcc_lib}"
      ENV.append "LDFLAGS", "-I#{Formula["gcc"].include}"
      ENV.append "LDFLAGS", "-I#{Formula["libgccjit"].include}"
      ENV.append "LDFLAGS", "-I#{Formula["gmp"].include}"
      ENV.append "LDFLAGS", "-I#{Formula["libjpeg"].include}"
    end


    # Start the installation
    ENV.prepend_path "PATH", Formula["gnu-sed"].opt_libexec/"gnubin"
    system "./autogen.sh"
    system "./configure", *args


    system "make"
    system "make", "install"


    # Change the icon for a better look&feel on macOS Big Sur
    if MacOS.version >= :big_sur
      icons_dir = buildpath/"nextstep/Emacs.app/Contents/Resources"

      rm "#{icons_dir}/Emacs.icns"
      resource("bigsur-icon").stage do
          icons_dir.install Dir["*.icns*"].first => "Emacs.icns"
        end
    end


    # We always build GNU/Emacs with cocoa
    prefix.install "nextstep/Emacs.app"


    # Replace the symlink with one that avoids starting Cocoa.
    (bin/"emacs").unlink # Kill the existing symlink
    (bin/"emacs").write <<-EOS
      #!/bin/bash
      exec #{prefix}/Emacs.app/Contents/MacOS/Emacs "$@"
    EOS

    # Follow MacPorts and don't install ctags from Emacs. This allows Vim
    # and Emacs and ctags to play together without violence.
    (bin/"ctags").unlink
    (man1/"ctags.1.gz").unlink
  end



  def caveats
    <<-EOS
      GNU/Emacs was installed to:
          #{prefix}

      To link GNU/Emacs to default Homebrew applications location:
          ln -s #{prefix}/Emacs.app/ /Applications/Emacs

      Please try the Cask for a better-supported Cocoa version:
          brew cask install emacs
    EOS
  end


  # https://github.com/d12frosted/homebrew-emacs-plus/blob/master/Formula/emacs-plus%4027.rb#L251
  plist_options :manual => "emacs"


  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/emacs</string>
          <string>--fg-daemon</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>StandardOutPath</key>
        <string>/tmp/homebrew.mxcl.emacs-plus.stdout.log</string>
        <key>StandardErrorPath</key>
        <string>/tmp/homebrew.mxcl.emacs-plus.stderr.log</string>
      </dict>
      </plist>
    EOS
  end


  test do
    assert_equal "4", shell_output("#{bin}/emacs --batch --eval=\"(print (+ 2 2))\"").strip
  end
end
