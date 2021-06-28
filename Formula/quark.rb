# coding: utf-8
class Quark < Formula
  desc     "Simple template formula for meson project installation"
  homepage "https://github.com/lebidouilleur/quark"



  head do
    url "https://github.com/lebidouilleur/quark.git"

    depends_on "meson" => :build
    depends_on "ninja" => :build
  end



  def install
    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "meson", "compile"
      system "meson", "install"
    end
  end



  test do
    assert_equal "Hello, world!", pipe_output("#{bin}/quark").chomp
  end
end
