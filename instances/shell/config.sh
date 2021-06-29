#!/bin/bash
set -x

NEW_VALUE=$(date +%s)

cat << EOF > /etc/jitsi/videobridge/sip-communicator.properties
org.ice4j.ice.harvest.DISABLE_AWS_HARVESTER=true
org.ice4j.ice.harvest.STUN_MAPPING_HARVESTER_ADDRESSES=meet-jit-si-turnrelay.jitsi.net:443
org.jitsi.videobridge.ENABLE_STATISTICS=true
org.jitsi.videobridge.STATISTICS_TRANSPORT=muc
org.jitsi.videobridge.xmpp.user.shard.HOSTNAME=IP-Address
org.jitsi.videobridge.xmpp.user.shard.DOMAIN=auth.example.com
org.jitsi.videobridge.xmpp.user.shard.USERNAME=jvb
org.jitsi.videobridge.xmpp.user.shard.PASSWORD=jvb-password
org.jitsi.videobridge.xmpp.user.shard.MUC_JIDS=JvbBrewery@internal.auth.example.com
org.jitsi.videobridge.xmpp.user.shard.MUC_NICKNAME=jvb-$NEW_VALUE
org.jitsi.videobridge.DISABLE_TCP_HARVESTER=true
org.jitsi.videobridge.xmpp.user.shard.DISABLE_CERTIFICATE_VERIFICATION=true
EOF