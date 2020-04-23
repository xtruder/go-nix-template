let
  # Look here for information about how to generate `nixpkgs-version.json`.
  #  → https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs
  pinnedVersion = builtins.fromJSON (builtins.readFile ./.nixpkgs-version.json);
  pinnedPkgs = import (builtins.fetchGit {
    inherit (pinnedVersion) url rev;

    ref = "nixos-unstable";
  }) {};
in

# This allows overriding pkgs by passing `--arg pkgs ...`
{ pkgs ? pinnedPkgs }:

with pkgs;

mkShell {
  buildInputs = with pkgs; [
    go_1_14
    delve
  ];

  shellHook = ''
    export GO111MODULE=on
    export GOPRIVATE=github.com/xtruder/\*
    export GOPATH=$PWD/.go
    export PATH=$GOPATH/bin:$PATH
    
    cat tools.go | grep _ | awk -F'"' '{print $2}' | xargs -tI % go install %
  '';
}
