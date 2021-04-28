with import <nixpkgs> { };

let
  inherit (lib) optional optionals;

  elixir = beam.packages.erlangR22.elixir_1_11;
in mkShell {
  buildInputs = [ asciidoctor elixir git ]
    ++ optional stdenv.isLinux inotify-tools ++ optionals stdenv.isDarwin
    (with darwin.apple_sdk.frameworks; [ CoreFoundation CoreServices ]);

  shellHook = ''
    # "nix-shell --pure" resets LANG to POSIX which breaks some tools
    export LANG="en_US.UTF-8"
  '';
}
