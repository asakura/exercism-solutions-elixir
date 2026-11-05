{
  description = "exercism-solutions-elixir: development shell with Livebook";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/0bb2eedc20e4739f29e8045034f2828ad7054f8f";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            elixir
            erlang
            livebook
            gitleaks
            trufflehog
          ];
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-tree);
    };
}
