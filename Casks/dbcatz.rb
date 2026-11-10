cask "dbcatz" do
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "1.2.1"
  sha256 arm:   "28a71b71915a12645dcf74498d2a5d96e2b12c16bcd65cdd02c31c48c540353f",
         intel: "bed48295659cb113471d4ed8953ac05c7f6727db7280e04129d8cc6d26635447"

  # through catzoid.com's counted redirect (Catzoid admin → Downloads → Homebrew): it answers with a 302 to this
  # version's DMG on the GitHub release, and Homebrew checks the sha256 above on what it gets
  url "https://catzoid.com/download/dbcatz/mac-#{arch}?v=#{version}"
  name "DBCatz"
  desc "Database client for MySQL, PostgreSQL, Redis, MongoDB and more"
  homepage "https://catzoid.com/dbcatz"

  livecheck do
    url "https://github.com/catzoidhub/DBCatz"
    strategy :github_latest
  end

  # the app updates itself (Check for Updates under Settings → About)
  auto_updates true
  depends_on macos: :ventura

  app "DBCatz.app"

  uninstall quit: "com.mrcatz.dbcatz"

  # exactly what DBCatz → Settings → Uninstall DBCatz removes from ~/Library (Catzoid TODO #55)
  zap trash: [
    "~/Library/Application Support/DBCatz",
    "~/Library/Caches/DBCatz",
    "~/Library/Caches/com.mrcatz.dbcatz",
    "~/Library/Caches/com.mrcatz.dbcatz.ShipIt",
    "~/Library/Caches/dbcatz-updater",
    "~/Library/Logs/DBCatz",
    "~/Library/Preferences/com.mrcatz.dbcatz.plist",
    "~/Library/Saved Application State/com.mrcatz.dbcatz.savedState",
  ]
end
