{
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs
          {
            inherit system;
          };
        puppetEnv = pkgs.bundlerEnv {
          name = "puppet-workstation-env";
          ruby = pkgs.ruby_3_3;
          gemdir = ./nix/puppet;
          gemConfig = pkgs.defaultGemConfig // {
            ruby-augeas = attrs: {
              nativeBuildInputs = [ pkgs.pkg-config ];
              buildInputs = [ pkgs.augeas pkgs.libxml2 ];
            };
          };
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "puppet-workstation";
          buildInputs = [
            (pkgs.lib.lowPrio puppetEnv.wrappedRuby)
            puppetEnv
          ];
        };
      });
}
