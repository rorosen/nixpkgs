{ callPackage, ... }@args:
callPackage ../generic.nix ({
  version = "11.3.27";
  hash = "sha256-A3EeFQsDOaggfb5S+eyRCe/vm054MabfRrcHPxhO0So=";
  vendorHash = "sha256-hjMv/H4dlinlv3ku7i1km2/b+6uCdbznHtVOMIjDlUc=";
  yarnHash = "sha256-hip0WQVZpx2qfVDmEy4nk4UFYEjX1Xhj8HsIIQ8PF1Y=";
  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "rdp-rs-0.1.0" = "sha256-GJfUyiYQwcDTMqt+iik3mFI0f6mu13RJ2XuoDzlg9sU=";
    };
  };
  extPatches = [
    # https://github.com/NixOS/nixpkgs/issues/120738
    ../tsh.patch
  ];
  knownVulnerabilities = [
    "GHSA-hw4x-mcx5-9q36"
    "GHSA-c9v7-wmwj-vf6x"
    "GHSA-vfxf-76hv-v4w4"
  ];
} // builtins.removeAttrs args [ "callPackage" ])
