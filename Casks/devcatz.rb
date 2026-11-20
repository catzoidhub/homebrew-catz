cask "devcatz" do
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "1.2.34"
  sha256 arm:   "ddd9df230704c09a1c79fa049f065589239191055eac76d0e60b522aec5e290b",
         intel: "73942acf1c6aa436a4589f79bbffa231f2491440d32b3830b9809a1dac8cc9b5"

  # through catzoid.com's counted redirect (Catzoid admin → Downloads → Homebrew): it answers with a 302 to this
  # version's DMG on the GitHub release, and Homebrew checks the sha256 above on what it gets
  url "https://catzoid.com/download/devcatz/mac-#{arch}?v=#{version}"
  name "DevCatz"
  desc "Local development environment for sites, runtimes and databases"
  homepage "https://catzoid.com/devcatz"

  livecheck do
    url "https://github.com/catzoidhub/DevCatz"
    strategy :github_latest
  end

  # the app updates itself (Check for Updates under Settings → About)
  auto_updates true
  depends_on macos: :ventura

  app "DevCatz.app"

  uninstall quit: "com.mrcatz.devcatz"

  # exactly what DevCatz → Settings → Uninstall DevCatz removes from ~/Library (Catzoid TODO #55)
  zap trash: [
    "~/Library/Application Support/DevCatz",
    "~/Library/Caches/DevCatz",
    "~/Library/Caches/com.mrcatz.devcatz",
    "~/Library/Caches/com.mrcatz.devcatz.ShipIt",
    "~/Library/Logs/DevCatz",
    "~/Library/Preferences/com.mrcatz.devcatz.plist",
    "~/Library/Saved Application State/com.mrcatz.devcatz.savedState",
  ]
  caveats <<~EOS
    DevCatz also changes things outside your home folder: the clean-URL services,
    its /etc/resolver entries and a local certificate authority in your keychain.
    Before `brew uninstall`, remove them with DevCatz → Settings → Uninstall DevCatz.
  EOS
end
