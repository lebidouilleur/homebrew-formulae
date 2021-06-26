# coding: utf-8
class Gitea < Formula
  desc     "Gitea - Git with a cup of tea."
  homepage "https://gitea.io/"
  version  "1.14.3"



  stable do
    url     "https://dl.gitea.io/gitea/#{version}/gitea-#{version}-darwin-10.12-amd64"
    sha256  `curl -s https://dl.gitea.io/gitea/#{version}/gitea-#{version}-darwin-10.12-amd64.sha256`.split(" ").first
  end

  head do
    url "https://github.com/go-gitea/gitea.git"

    depends_on "go" => :build
  end



  # Gitea >=1.14 requires macOS Sierra or higher
  if MacOS.version < :sierra
    odie "This version of Gitea requires macOS Sierra (10.12) or higher."
  end



  def install
    if build.stable?
      bin.install "#{buildpath}/gitea-#{version}-darwin-10.12-amd64" => "gitea"
    else
      mkdir_p buildpath/File.join("src", "code.gitea.io")
      ln_s buildpath, buildpath/File.join("src", "code.gitea.io", "gitea")

      ENV.append_path "PATH", File.join(buildpath, "bin")

      ENV["GOPATH"] = buildpath
      ENV["GOHOME"] = buildpath
      ENV["TAGS"] = "bindata sqlite tidb"

      system "cd src/code.gitea.io/gitea && make generate build"

      bin.install "#{buildpath}/gitea" => "gitea"
    end
  end



  test do
    system "#{bin}/gitea", "--version"
  end
end
