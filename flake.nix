{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
      packages.${system}.default = with pkgs; stdenv.mkDerivation {
        name = "papa_stories";
        src = ./src;
        buildInputs = with pkgs; [
          gnumake pandoc http-server
        ];

        buildPhase = ''
          make BUILD_DIR=$out/build all
        '';

        installPhase = ''
          mkdir -p $out/bin
          cat <<EOF > $out/bin/start-server
          #!/usr/bin/env bash
          ${http-server}/bin/http-server $out/build -p 8001 -d false
          EOF
          chmod +x $out/bin/start-server
        '';
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          pandoc
          ripgrep
          http-server
          shellcheck
          gnumake
        ];
      };
    };
}

