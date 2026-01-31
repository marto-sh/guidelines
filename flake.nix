{
  description = "Guidelines development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Rust toolchain
            rustc
            cargo
            rust-analyzer

            # Conventional commits
            cocogitto

            # Git
            git
            gh
          ];

          shellHook = ''
            # Install commit-msg hook if not already installed
            if [ ! -f .git/hooks/commit-msg ]; then
              cog install-hook commit-msg 2>/dev/null || true
            fi
          '';
        };
      }
    );
}
