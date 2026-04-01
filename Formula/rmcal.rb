class Rmcal < Formula
  include Language::Python::Virtualenv

  desc "Sync macOS Calendar to reMarkable tablets as interactive PDF planners"
  homepage "https://github.com/thomasqbrady/rmCalendarMacOS"
  url "https://github.com/thomasqbrady/rmCalendarMacOS/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "6be1d72fb15c749e19768e28707f1745324180ac612600dc47634c73d80f8cef"
  license "MIT"
  head "https://github.com/thomasqbrady/rmCalendarMacOS.git", branch: "main"

  depends_on :macos
  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install "hatchling"
    venv.pip_install_and_link buildpath
  end

  def caveats
    <<~EOS
      To get started:
        1. Register your reMarkable: rmcal register
        2. Launch the TUI:           rmcal

      macOS will prompt for calendar access on first run.

      To enable auto-sync (every 15 min):
        rmcal daemon install
    EOS
  end

  test do
    assert_match "rmCalendarMacOS", shell_output("#{bin}/rmcal --help")
  end
end
