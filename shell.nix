with import <nixpkgs> { };

let
  inherit (lib) optional optionals;

  elixir = beam.packages.erlangR23.elixir_1_11;
in mkShell {
  buildInputs = [ elixir git ]
    ++ optional stdenv.isLinux inotify-tools ++ optionals stdenv.isDarwin
    (with darwin.apple_sdk.frameworks; [ CoreFoundation CoreServices ]);

  shellHook = ''
    export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive # Fixes NixOS/nix#599
  '';

  ERL_INCLUDE_PATH = "${erlang}/lib/erlang/usr/include";
}
