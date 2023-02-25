{
  description = "Quantum Espresso workspace";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/5f4e07deb7c44f27d498f8df9c5f34750acf52d2";
    flake-utils.url = "github:numtide/flake-utils";
    xcrysden.url = "github:kayhide/xcrysden-nix";
  };

  outputs = inputs:
    let
      overlay = final: prev: {
        xcrysden = final.callPackage "${inputs.xcrysden}/nix/xcrysden" { };
      };

      perSystem = system:
        let
          pkgs = import inputs.nixpkgs { inherit system; overlays = [ overlay ]; };

          dev-env = pkgs.buildEnv {
            name = "dev-env";
            paths = with pkgs; [
              gnumake
              gfortran
              quantum-espresso
              xcrysden
            ];
          };
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              dev-env
            ];
          };
        };
    in

    {
      inherit overlay;
    } // inputs.flake-utils.lib.eachDefaultSystem perSystem;
}
