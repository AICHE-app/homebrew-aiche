cask "aiche-desktop" do
  version "1.0.0"
  sha256 "c7be74428a8d27f725f10514dccfcd3b6268e44caa95f069c9c89325d32f1e88"

  url "https://github.com/AICHE-app/mac-releases/releases/download/v#{version}/AICHE-Desktop.dmg",
      verified: "github.com/AICHE-app/mac-releases/"
  name "AICHE Desktop"
  desc "AI-powered audio transcription and enhancement desktop app"
  homepage "https://aiche.app"

  # Auto-update support
  livecheck do
    url :url
    strategy :github_latest
  end

  # Main app
  app "AICHE Desktop.app"

  # Post-install: Remove quarantine to avoid Gatekeeper
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/AICHE Desktop.app"],
                   sudo: false
  end

  # Cleanup on uninstall
  zap trash: [
    "~/Library/Application Support/AICHE Desktop",
    "~/Library/Preferences/com.aiche.desktop.plist",
    "~/Library/Logs/AICHE Desktop",
    "~/.aiche",
  ]

  caveats <<~EOS
    AICHE Desktop requires accessibility permissions for global hotkeys.
    
    On first launch, grant accessibility permissions when prompted.
    Check the app for current hotkey bindings.
  EOS
end