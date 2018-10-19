#!/bin/bash

MNI_TEMPLATE="https://files.osf.io/v1/resources/fvuh8/providers/osfstorage/5bc984f8ccdb6b0018abb993"
MNI_SHA256="9bb06ab27d45d21e7f8b2bc2ca27227f081ecb051bbd438a0bfbc56ddc089cac"
ASYM_09C_TEMPLATE="https://files.osf.io/v1/resources/fvuh8/providers/osfstorage/5b0dbce20f461a000db8fa3d"
ASYM_09C_SHA256="2851302474359c2c48995155aadb48b861e5dcf87aefda71af8010f671e8ed66"
OASIS_TEMPLATE="https://files.osf.io/v1/resources/fvuh8/providers/osfstorage/584123a29ad5a1020913609d"
OASIS_SHA256="d87300e91346c16f55baf6f54f5f990bc020b61e8d5df9bcc3abb0cc4b943113"
NKI_TEMPLATE="https://files.osf.io/v1/resources/fvuh8/providers/osfstorage/5bc3fad82aa873001bc5a553"
NKI_SHA256="9c08713d067bcf13baa61b01a9495e526b55d1f148d951da01e082679f076fa9"
OASIS_DKT31_TEMPLATE="https://files.osf.io/v1/resources/fvuh8/providers/osfstorage/5b16f17aeca4a80012bd7542"
OASIS_DKT31_SHA256="623fa7141712b1a7263331dba16eb069a4443e9640f52556c89d461611478145"


GET(){
    URL=$1; SHA256=$2;
    mkfifo pipe.tar.gz
    cat pipe.tar.gz | tar zxv -C $CRN_SHARED_DATA &
    SHASUM=$(curl -sSL $URL | tee pipe.tar.gz | sha256sum | cut -d\  -f 1)
    rm pipe.tar.gz

    if [[ "$SHASUM" != "$SHA256" ]]; then
        echo "Failed checksum!"
        return 1
    fi
    return 0
}

set -e
echo "Getting MNI152Lin template"
GET "$MNI_TEMPLATE" "$MNI_SHA256"
echo "Getting MNI152NLin2009cAsym template"
GET "$ASYM_09C_TEMPLATE" "$ASYM_09C_SHA256"
echo "Getting OASIS template"
GET "$OASIS_TEMPLATE" "$OASIS_SHA256"
echo "Getting NKI template"
GET "$NKI_TEMPLATE" "$NKI_SHA256"
echo "Getting OASIS DKT31 template"
GET "$OASIS_DKT31_TEMPLATE" "$OASIS_DKT31_SHA256"
echo "Done!"
