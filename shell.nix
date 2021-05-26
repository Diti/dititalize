with import <nixpkgs> { };

let
  inherit (lib) optional optionals;

  elixir = beam.packages.erlangR23.elixir_1_11;
in mkShell {
  buildInputs = [ asciidoctor elixir git ]
    ++ optional stdenv.isLinux inotify-tools ++ optionals stdenv.isDarwin
    (with darwin.apple_sdk.frameworks; [ CoreFoundation CoreServices ]);

  shellHook = ''
    export SOURCE_DATE_EPOCH="${git} log -1 --pretty=%ct";
  '';

  ERL_INCLUDE_PATH = "${erlang}/lib/erlang/usr/include";
  LOCALE_ARCHIVE = "/usr/lib/locale/locale-archive"; # Fixes NixOS/nix#599
}
