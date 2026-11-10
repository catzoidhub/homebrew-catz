class Mcatzp < Formula
  # A command-line MCP server, so a formula, not a cask: the signed, notarized binary for this Mac, no Node needed. It
  # downloads through catzoid.com's counted redirect like the casks (Catzoid #86, #87); scripts/bump.sh fills in the
  # version and sums.
  desc "MCP server that lets AI assistants use the Catzoid apps"
  homepage "https://catzoid.com/mcatzp"
  version "1.0.5"
  license "Apache-2.0"

  on_arm do
    url "https://catzoid.com/download/mcatzp/mac-arm64?v=#{version}"
    sha256 "625ebd2361f270ab537bba72c678be6427552109ab6e81ab16551aebcf8d8879"
  end
  on_intel do
    url "https://catzoid.com/download/mcatzp/mac-x64?v=#{version}"
    sha256 "5a94ab8584d3ef2ff585eb27b519aeb8ac6b7420f25b7878e448a56cfad34317"
  end

  livecheck do
    url "https://github.com/catzoidhub/MCatzP"
    strategy :github_latest
  end

  depends_on :macos

  def install
    bin.install "mcatzp"
  end

  def caveats
    <<~EOS
      Add MCatzP to your AI assistant, e.g. Claude Code:
        claude mcp add mcatzp -- #{opt_bin}/mcatzp
      Then switch it on per app: Settings → MCatzP in DevCatz, DBCatz, DialCatz or DoCatz.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mcatzp --version").strip
  end
end
