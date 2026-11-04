class Mcatzp < Formula
  # MCatzP is not released yet: this formula waits for its first release (MCatzP TODO #19, #21). A command-line MCP
  # server, so a formula, not a cask: the signed, notarized binary for this Mac, no Node needed. It downloads through
  # catzoid.com's counted redirect like the casks (Catzoid #86, #87); scripts/bump.sh fills in the version and sums.
  desc "MCP server that lets AI assistants use the Catzoid apps"
  homepage "https://catzoid.com/mcatzp"
  version "0.1.0"
  license "Apache-2.0"

  on_arm do
    url "https://catzoid.com/download/mcatzp/mac-arm64?v=#{version}"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end
  on_intel do
    url "https://catzoid.com/download/mcatzp/mac-x64?v=#{version}"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
