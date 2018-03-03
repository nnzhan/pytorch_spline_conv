#!/bin/sh

echo "Compiling kernel..."

PYTHON=${1:-python}
TORCH=$($PYTHON -c "import os; import torch; print(os.path.dirname(torch.__file__))")
SRC_DIR=torch_spline_conv/kernel
BUILD_DIR=torch_spline_conv/build

mkdir -p $BUILD_DIR
$(which nvcc) -c -o $BUILD_DIR/kernel.so $SRC_DIR/kernel.cu -arch=sm_35 -Xcompiler -fPIC -shared -I$TORCH/lib/include/TH -I$TORCH/lib/include/THC -I$SRC_DIR
