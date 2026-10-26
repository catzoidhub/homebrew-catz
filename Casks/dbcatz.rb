cask "dbcatz" do
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "1.0.0"
  sha256 arm:   "e821e4827e67909e164eae3aa1db69bfadaf4039e2b27327054a7c202990528d",
         intel: "e576dec9262d6c74e0288b7098711d266cbcef9ebdca791bf05afec8d1f6ca4a"

  url "https://github.com/catzoidhub/DBCatz/releases/download/v#{version}/DBCatz-#{version}-#{arch}.dmg",
      verified: "github.com/catzoidhub/DBCatz/"
  name "DBCatz"
  desc "Database client for MySQL, PostgreSQL, Redis, MongoDB and more"
  homepage "https://catzoid.com/dbcatz"

  livecheck do
    url :url
    strategy :github_latest
  end

  # the app updates itself (Check for Updates under Settings → About)
  auto_updates true
  depends_on macos: ">= :ventura"

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
