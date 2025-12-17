cask "aiche-desktop" do
  version "1.0.15"

  # Architecture-specific downloads
  on_arm do
    sha256 "045b6c679240d7f7c667f3295f38ae0db95e0c576e7f31e4ea0e93b75c326df1"
    url "https://github.com/AICHE-app/mac-releases/releases/download/v#{version}/AICHE-Installer-#{version}-ARM64.dmg",
        verified: "github.com/AICHE-app/mac-releases/"
  end

  on_intel do
    sha256 "f03ab6f6e182f5cbfe971dced3dde245196bb7a22465f1f9bb61b99f880af203"
    url "https://github.com/AICHE-app/mac-releases/releases/download/v#{version}/AICHE-Installer-#{version}-Intel.dmg",
        verified: "github.com/AICHE-app/mac-releases/"
  end

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

  # Post-install: Remove quarantine to avoid Gatekeeper (not needed - already notarized)
  # Keeping this commented out as the DMG is properly signed and notarized
  # postflight do
  #   system_command "/usr/bin/xattr",
  #                  args: ["-rd", "com.apple.quarantine", "#{appdir}/AICHE Desktop.app"],
  #                  sudo: false
  # end

  # Cleanup on uninstall
  zap trash: [
    "~/Library/Application Support/AICHE",
    "~/Library/Preferences/app.aiche.desktop.plist",
    "~/Library/Logs/AICHE Desktop",
  ]

  caveats <<~EOS
    AICHE Desktop requires the following permissions:

    1. Microphone access - for audio recording
    2. Accessibility permissions - for global hotkeys

    On first launch, grant these permissions when prompted.
    You can configure hotkeys in the app settings.
  EOS
end
