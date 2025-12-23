#!/usr/bin/env bash
set -euo pipefail

echo "::group:: Finalizing Image"

if [ -d /usr/etc ]; then
    cp -rv /usr/etc/* /etc/ || true
    rm -rf /usr/etc
fi

if ! grep -q "^greeter:" /usr/lib/sysusers.d/*.conf 2>/dev/null; then
    cat > /usr/lib/sysusers.d/greeter.conf <<EOF
g greeter -
u greeter - "greetd greeter user" /var/lib/greetd
EOF
fi

cat > /usr/lib/tmpfiles.d/stamos-var-cleanup.conf <<EOF
d /var/lib/AccountsService 0775 root root - -
d /var/lib/AccountsService/icons 0775 root root - -
d /var/lib/AccountsService/users 0700 root root - -
d /var/lib/geoclue 0755 geoclue geoclue - -
d /var/lib/greetd 0755 greeter greeter - -
d /var/lib/greetd/.config 0755 greeter greeter - -
d /var/lib/greetd/.config/systemd 0755 greeter greeter - -
d /var/lib/greetd/.config/systemd/user 0755 greeter greeter - -
L /var/lib/greetd/.config/systemd/user/xdg-desktop-portal.service - - - - /dev/null
EOF

rm -rf /var/lib/AccountsService /var/lib/geoclue /var/lib/greetd /var/tmp/*

echo "Finalization complete!"
echo "::endgroup::"
