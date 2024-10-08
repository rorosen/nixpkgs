{ stdenv
, lib
, fetchFromGitHub
, pkg-config
, cmake
, libvorbis
, libeb
, hunspell
, opencc
, xapian
, libzim
, lzo
, xz
, tomlplusplus
, fmt
, bzip2
, libiconv
, libXtst
, qtbase
, qtsvg
, qtwebengine
, qttools
, qtwayland
, qt5compat
, qtmultimedia
, qtspeech
, wrapQtAppsHook
, wrapGAppsHook3
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "goldendict-ng";
  version = "24.09.0";

  src = fetchFromGitHub {
    owner = "xiaoyifang";
    repo = "goldendict-ng";
    rev = "v${finalAttrs.version}-Release.316ec900";
    hash = "sha256-LriKJLjqEuD0v8yjoE35O+V6oUX2jhWGFguqlXaDlQA=";
  };

  nativeBuildInputs = [ pkg-config cmake wrapQtAppsHook wrapGAppsHook3 ];
  buildInputs = [
    qtbase
    qtsvg
    qttools
    qtwebengine
    qt5compat
    qtmultimedia
    qtwayland
    libvorbis
    tomlplusplus
    fmt
    hunspell
    xz
    lzo
    libXtst
    bzip2
    libiconv
    opencc
    libeb
    xapian
    libzim
  ];

  # to prevent double wrapping of wrapQtApps and wrapGApps
  dontWrapGApps = true;

  preFixup = ''
    qtWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  cmakeFlags = [
    "-DWITH_XAPIAN=ON"
    "-DWITH_ZIM=ON"
    "-DWITH_FFMPEG_PLAYER=OFF"
    "-DWITH_EPWING_SUPPORT=ON"
    "-DUSE_SYSTEM_FMT=ON"
    "-DUSE_SYSTEM_TOML=ON"
  ];

  meta = with lib; {
    homepage = "https://xiaoyifang.github.io/goldendict-ng/";
    description = "Advanced multi-dictionary lookup program";
    platforms = platforms.linux;
    mainProgram = "goldendict";
    maintainers = with maintainers; [ slbtty michojel ];
    license = licenses.gpl3Plus;
  };
})
