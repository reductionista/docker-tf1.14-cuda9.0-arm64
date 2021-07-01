#!/usr/bin/env bash

set -e

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TEST_MOUNT="$ROOT/../test:/test"
TESTS=${1:-"all"}
DOCKER_IMAGE="dvaldano/ubuntu18-tf1.14-arm64"

# cuda tests
test_cuda()
{
	echo "testing container $1 => PyCUDA"
	sh ./scripts/docker_run.sh -c $1 -v $TEST_MOUNT -r python3 test/test_cuda.py
	echo -e "done testing container $1 => PyCUDA\n"
}

# cupy tests
test_cupy()
{
	echo "testing container $1 => CuPy"
	sh ./scripts/docker_run.sh -c $1 -v $TEST_MOUNT -r python3 test/test_cupy.py
	echo -e "done testing container $1 => CuPy\n"
}

# numpy tests
test_numpy()
{
	echo "testing container $1 => numpy"
	sh ./scripts/docker_run.sh -c $1 -v $TEST_MOUNT -r python3 test/test_numpy.py
	echo -e "done testing container $1 => numpy\n"
}

# numpa tests
test_numba()
{
	echo "testing container $1 => numba"
	sh ./scripts/docker_run.sh -c $1 -v $TEST_MOUNT -r python3 test/test_numba.py
	echo -e "done testing container $1 => numba\n"
}

# pandas tests
test_pandas()
{
	echo "testing container $1 => pandas"
	sh ./scripts/docker_run.sh -c $1 -v $TEST_MOUNT -r python3 test/test_pandas.py
	echo -e "done testing container $1 => pandas\n"
}

# TensorFlow tests
test_tensorflow()
{
	echo "testing container $1 => TensorFlow"
	sh ./scripts/docker_run.sh -c $1 -v $TEST_MOUNT -r python3 test/test_tensorflow.py
	echo -e "done testing container $1 => TensorFlow\n"
}

# TensorRT tests
test_tensorrt()
{
	echo "testing container $1 => TensorRT"
	sh ./scripts/docker_run.sh -c $1 -v $TEST_MOUNT -r python3 test/test_tensorrt.py
	echo -e "done testing container $1 => TensorRT\n"
}

# scipy tests
test_scipy()
{
	echo "testing container $1 => scipy"
	sh ./scripts/docker_run.sh -c $1 -v $TEST_MOUNT -r python3 test/test_scipy.py
	echo -e "done testing container $1 => scipy\n"
}

# sklearn tests
test_sklearn()
{
	echo "testing container $1 => sklearn"
	sh ./scripts/docker_run.sh -c $1 -v $TEST_MOUNT -r python3 test/test_sklearn.py
	echo -e "done testing container $1 => sklearn\n"
}

# TensorFlow tests (all)
test_tensorflow_all()
{
	test_tensorflow $1
	test_tensorrt $1
	test_cuda $1
	test_numpy $1
}

test_all()
{
	test_tensorflow $1
	test_tensorrt $1
	test_cuda $1
	test_numpy $1
	test_cupy $1
	test_numba $1
	test_pandas $1
	test_scipy $1
	test_sklearn $1
}

if [ "$TESTS" = "tensorflow" ]
then
    test_tensorflow_all "$DOCKER_IMAGE"
elif [ "CONTAINERS" = "all" ]
    test_all "$DOCKER_IMAGE"
fi
