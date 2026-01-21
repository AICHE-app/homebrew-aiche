cask "aiche-desktop" do
  version "1.0.21"

  # Architecture-specific downloads
  on_arm do
    sha256 "70d226d84395d765827d00faf84883a207c13a64f475bf3dd921b6f4e67c7b0f"
    url "https://github.com/AICHE-app/mac-releases/releases/download/v#{version}/AICHE-Installer-#{version}-ARM64.dmg",
        verified: "github.com/AICHE-app/mac-releases/"
  end

  on_intel do
    sha256 "84f82c1826350622574991025e94fa9bd68afbc107d47954fa068530e2acd381"
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

  # Uninstall handler - removes app on upgrade/reinstall
  uninstall delete: "/Applications/AICHE Desktop.app"

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
