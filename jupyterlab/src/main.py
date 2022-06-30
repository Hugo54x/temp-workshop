import platform
import unittest
import numpy
import numba

class TestMicromambaEnvironmentLock(unittest.TestCase):
    def test_python_version(self):
        self.assertEqual(platform.python_version(), '3.10.5')

    def test_numpy_version(self):
        self.assertEqual(numpy.__version__, '1.22.4')

    def test_numba_version(self):
        self.assertEqual(numba.__version__, '0.55.2')

if __name__ == "__main__":
    print("[HELLO WORLD] running testfile")
    print(f'python version: {platform.python_version()}')
    print(f'numpy  version: {numpy.__version__}')
    print(f'numba  version: {numba.__version__}')
