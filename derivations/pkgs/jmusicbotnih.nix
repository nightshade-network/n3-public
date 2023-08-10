{ 
    lib,
    fetchurl,
    jre_headless,
    stdenv,
    makeWrapper,
    ...
}:
stdenv.mkDerivation rec {
    name = "jmusicbot";
    version = "0.3.9";

    src = fetchurl {
        url = "https://github.com/jagrosh/MusicBot/releases/download/0.3.9/JMusicBot-0.3.9.jar";
        sha256 = "d80d72a367b531ac062cc4ccea35b0a50249b8a3a6963c45ae2391bfdd09aa0f";
    };

    dontUnpack = true;

    nativeBuildInputs = [ makeWrapper ];

    installPhase = ''

        mkdir -pv $out/share/java $out/bin
        cp ${src} $out/share/java/${name}-${version}.jar

        makeWrapper ${jre_headless}/bin/java $out/bin/jmusicbot \
            --add-flags "-Xmx1G -Dnogui=true -Dconfig.file=/var/lib/jmusicbot/config -jar $out/share/java/${name}-${version}.jar"

    '';

    meta = {
        description = "It's JMusicBot.";
        license = lib.licenses.asl20;
        platforms = lib.platforms.unix;
        homepage = "https://github.com/jagrosh/MusicBot";
    };
}