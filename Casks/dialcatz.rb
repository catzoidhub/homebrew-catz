cask "dialcatz" do
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "1.2.1"
  sha256 arm:   "6710e5da30184eb91cb9b467946642356fbca42f4e93e6ec90b78d7553dd0d30",
         intel: "86cbc06ca1efbf1c03768fdebb477678d127ab4c9e1aab52c9f14e34a5b1cc2d"

  # through catzoid.com's counted redirect (Catzoid admin → Downloads → Homebrew): it answers with a 302 to this
  # version's DMG on the GitHub release, and Homebrew checks the sha256 above on what it gets
  url "https://catzoid.com/download/dialcatz/mac-#{arch}?v=#{version}"
  name "DialCatz"
  desc "API client for REST, GraphQL and WebSocket requests"
  homepage "https://catzoid.com/dialcatz"

  livecheck do
    url "https://github.com/catzoidhub/DialCatz"
    strategy :github_latest
  end

  # the app updates itself (Check for Updates under Settings → About)
  auto_updates true
  depends_on macos: :ventura

  app "DialCatz.app"

  uninstall quit: "com.mrcatz.dialcatz"

  # exactly what DialCatz → Settings → Uninstall DialCatz removes from ~/Library (Catzoid TODO #55)
  zap trash: [
    "~/Library/Application Support/DialCatz",
    "~/Library/Caches/com.mrcatz.dialcatz",
    "~/Library/Caches/com.mrcatz.dialcatz.ShipIt",
    "~/Library/Caches/DialCatz-updater",
    "~/Library/Caches/dialcatz-updater",
    "~/Library/Logs/DialCatz",
    "~/Library/Preferences/com.mrcatz.dialcatz.plist",
    "~/Library/Saved Application State/com.mrcatz.dialcatz.savedState",
  ]
end
