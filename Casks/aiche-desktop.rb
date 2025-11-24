cask "aiche-desktop" do
  version "1.0.5"

  # Architecture-specific downloads
  on_arm do
    sha256 "396974356b3d87f9a9d061fee4a4fa067a9ac983a4264943da451f7b23bc1132"
    url "https://github.com/AICHE-app/mac-releases/releases/download/v#{version}/AICHE-Installer-#{version}-ARM64.dmg",
        verified: "github.com/AICHE-app/mac-releases/"
  end

  on_intel do
    sha256 "7baa3d71c0bfeb5cde81c48fca936ed9c47808d2f5e3d1c6c9fcbc363513e16b"
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
