#!/bin/bash

set -eu

# Set default values to appease set -u
: ${SSMTP_MAILHUB:=}
: ${SSMTP_REWRITE_DOMAIN:=}
: ${SSMTP_USE_START_TLS:=}
: ${SSMTP_USE_TLS:=}
: ${SSMTP_USER:=}
: ${SSMTP_PASSWORD:=}

# Check for required variables
if [ -z "$SSMTP_MAILHUB" -o -z "$SSMTP_USER" -o -z "$SSMTP_PASSWORD" ]; then
  echo >&2 "Unable to configure ssmtp. Please set the following environment variables:"
  [ -z "$SSMTP_MAILHUB" ] \
    && echo >&2 "    SSMTP_MAILHUB"
  [ -z "$SSMTP_USER" ] \
    && echo >&2 "    SSMTP_USER"
  [ -z "$SSMTP_PASSWORD" ] \
    && echo >&2 "    SSMTP_PASSWORD"
  exit 1
fi

# Create ssmtp.conf
{
  [ -n "$SSMTP_MAILHUB" ] \
    && echo "mailhub=$SSMTP_MAILHUB"
  [ -n "$SSMTP_REWRITE_DOMAIN" ] \
    && echo "rewriteDomain=$SSMTP_REWRITE_DOMAIN"
  [ -n "$SSMTP_USE_START_TLS" ] \
    && echo "UseStartTLS=$SSMTP_USE_START_TLS"
  [ -n "$SSMTP_USE_TLS" ] \
    && echo "UseTLS=$SSMTP_USE_TLS"
  [ -n "$SSMTP_USER" ] \
    && echo "AuthUser=$SSMTP_USER"
  [ -n "$SSMTP_PASSWORD" ] \
    && echo "AuthPass=$SSMTP_PASSWORD"
} > /etc/ssmtp/ssmtp.conf

exec /entrypoint.sh "$@"
