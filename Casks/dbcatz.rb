cask "dbcatz" do
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "1.0.3"
  sha256 arm:   "577efd4c1f8d76a3a6f65ab27f1a7630536047ce8f216fc2059d2bffc3929e5d",
         intel: "3106ebfd0ce9da50c6e8aec51d4cf4a02662b4436479b680948c2985257ab014"

  url "https://github.com/catzoidhub/DBCatz/releases/download/v#{version}/DBCatz-#{version}-#{arch}.dmg"
  name "DBCatz"
  desc "Database client for MySQL, PostgreSQL, Redis, MongoDB and more"
  homepage "https://catzoid.com/dbcatz"

  livecheck do
    url :url
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
