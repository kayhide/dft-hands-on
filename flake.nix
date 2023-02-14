{
  description = "Quantum Espresso workspace";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    xcrysden.url = "github:kayhide/xcrysden-nix";
  };

  outputs = inputs:
    let
      overlay = final: prev: {
        xcrysden = inputs.xcrysden.outputs.packages.${prev.system}.default;
      };
      perSystem = system:
        let
          pkgs = import inputs.nixpkgs { inherit system; overlays = [ overlay ]; };

          dev-env = pkgs.buildEnv {
            name = "dev-env";
            paths = with pkgs; [
              gnumake
            ];
          };
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              quantum-espresso
              xcrysden
              gfortran
            ];
          };
        };
    in

    {
      inherit overlay;
    } // inputs.flake-utils.lib.eachDefaultSystem perSystem;
}
