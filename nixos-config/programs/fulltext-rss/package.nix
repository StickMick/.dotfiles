{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "fulltext-rss";
  version = "master";

  src = fetchFromGitHub {
    owner = "Dither";
    repo = "full-text-rss";
    rev = "master";
    sha256 = "rscGIlIciePpJA9WDhQhmIr9P4fUpo15O1gdPKUSSe0=";
  };

  phases = [ "unpackPhase" "installPhase" ];

  unpackPhase = ''
    mkdir -p $out
    cp -r $src/* $out/
  '';

  installPhase = ''
    # Ensure required directories exist with writable permissions for PHP-FPM
    mkdir -p $out/cache
    mkdir -p $out/site_config/custom
    chmod 750 $out/cache
    chmod 750 $out/site_config/custom
  '';

  meta = with lib; {
    description = "Full Text RSS - Extract article content from RSS feeds";
    homepage = "https://www.fivefilters.org/full-text-rss/";
    license = licenses.agpl3Plus;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
