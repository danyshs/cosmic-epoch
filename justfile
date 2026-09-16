set dotenv-load
just := just_executable()
make := `which make`

build:
    mkdir -p build
    cd cosmic-applets && {{ just }} build-release
    cd cosmic-applibrary && {{ just }} build-release
    cd cosmic-bg && {{ just }} build-release
    {{ make }} -C cosmic-comp all
    cd cosmic-edit && {{ just }} build-release
    cd cosmic-files && {{ just }} build-release
    cd cosmic-greeter && {{ just }} build-release
    cd cosmic-idle && {{ just }} build-release
    cd cosmic-initial-setup && {{ just }} build-release
    cd cosmic-launcher && {{ just }} build-release
    cd cosmic-monitor && {{ just }} build-release
    cd cosmic-notifications && {{ just }} build-release
    cd cosmic-osd && {{ just }} build-release
    cd cosmic-panel && {{ just }} build-release
    cd cosmic-player && {{ just }} build-release
    cd cosmic-randr && {{ just }} build-release
    cd cosmic-screenshot && {{ just }} build-release
    cd cosmic-settings && {{ just }} build-release
    {{ make }} -C cosmic-settings-daemon all
    cd cosmic-session && {{ just }} build-release
    cd cosmic-store && {{ just }} build-release
    cd cosmic-term && {{ just }} build-release
    {{ make }} -C cosmic-wallpapers all
    {{ make }} -C cosmic-workspaces-epoch all
    cd pop-launcher && {{ just }} build-release
    cd xdg-desktop-portal-cosmic && {{ just }} build

install rootdir="" prefix="/usr/local": build
    cd cosmic-applets && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-applibrary && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-bg && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    {{ make }} -C cosmic-comp install DESTDIR={{rootdir}} prefix={{prefix}}
    cd cosmic-edit && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-files && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-greeter && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-icons && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-idle && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-initial-setup && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-launcher && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-monitor && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-notifications && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-osd && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-panel && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-player && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-randr && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-screenshot && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-settings && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    {{ make }} -C cosmic-settings-daemon install DESTDIR={{rootdir}} prefix={{prefix}}
    cd cosmic-session && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-store && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    cd cosmic-term && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install
    {{ make }} -C cosmic-wallpapers install DESTDIR={{rootdir}} prefix={{prefix}}
    {{ make }} -C cosmic-workspaces-epoch install DESTDIR={{rootdir}} prefix={{prefix}}
    cd pop-launcher && {{ just }} rootdir={{rootdir}} install
    cd xdg-desktop-portal-cosmic && {{ just }} rootdir={{rootdir}} prefix={{prefix}} install

_mkdir dir:
   mkdir -p dir

sysext dir=(invocation_directory() / "cosmic-sysext") version=("nightly-" + `git rev-parse --short HEAD`): (_mkdir dir) (install dir "/usr")
    #!/usr/bin/env sh
    mkdir -p {{dir}}/usr/lib/extension-release.d/
    cat >{{dir}}/usr/lib/extension-release.d/extension-release.cosmic-sysext <<EOF
    NAME="Cosmic DE"
    VERSION={{version}}
    $(cat /etc/os-release | grep '^ID=')
    $(cat /etc/os-release | grep '^VERSION_ID=')
    EOF
    echo "Done"

clean:
    rm -rf cosmic-sysext
    rm -rf cosmic-applets/target
    rm -rf cosmic-applibrary/target
    rm -rf cosmic-bg/target
    rm -rf cosmic-comp/target
    rm -rf cosmic-edit/target
    {{ just }} cosmic-files/clean
    rm -rf cosmic-greeter/target
    {{ just }} cosmic-idle/clean
    {{ just }} cosmic-initial-setup/clean
    rm -rf cosmic-launcher/target
    {{ just }} cosmic-monitor/clean
    rm -rf cosmic-panel/target
    rm -rf cosmic-player/target
    rm -rf cosmic-notifications/target
    rm -rf cosmic-osd/target
    rm -rf cosmic-randr/target
    rm -rf cosmic-screenshot/target
    rm -rf cosmic-settings/target
    rm -rf cosmic-settings-daemon/target
    rm -rf cosmic-session/target
    {{ just }} cosmic-store/clean
    {{ just }} cosmic-term/clean
    {{ make }} -C cosmic-wallpapers clean
    rm -rf cosmic-workspaces-epoch/target
    {{ just }} pop-launcher/clean
    rm -rf xdg-desktop-portal-cosmic/target
