#!/bin/bash
BASE_PATH=$(dirname "${BASH_SOURCE}")
BASE_PATH=$(cd "${BASE_PATH}"; pwd)


# mozart image
SIF_DIR=${BASE_PATH}/sif_images
MOZART_SIF=${SIF_DIR}/hysds-mozart.sif
if [ ! -e "$MOZART_SIF" ]; then
  echo "Converting hysds/mozart:latest docker image to singularity sif file..."
  mkdir -p ${SIF_DIR}
  singularity build $MOZART_SIF docker://hysds/mozart
  echo "done."
fi

# start up mozart
echo "Starting up mozart."
singularity exec --add-caps CAP_NET_RAW,CAP_NET_BIND_SERVICE,CAP_NET_BROADCAST \
  --no-home --bind /data:/data \
  --bind ${BASE_PATH}/mozart/log:/home/ops/mozart/log \
  --bind ${BASE_PATH}/mozart/run:/home/ops/mozart/run \
  --bind ${BASE_PATH}/mozart/etc:/home/ops/mozart/etc \
  -H /home/ops --pwd /data/work ${MOZART_SIF} bash
