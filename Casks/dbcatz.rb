cask "dbcatz" do
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "1.0.1"
  sha256 arm:   "175d219c8b15ad044b314acfdd1a5a0f65a0eea62d0a501cfa6864b27ff6d807",
         intel: "127c74b20a9477a5ec49af00e77fae1dc3d23d8a446a66a171a599a42c2228d1"

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
