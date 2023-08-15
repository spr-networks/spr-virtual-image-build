cat > /etc/rc.local <<_EOF
#!/bin/bash

cd /home/spr/super && docker-compose up -d
_EOF
chmod +x /etc/rc.local
