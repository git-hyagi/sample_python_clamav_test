from setuptools import setup, find_packages

setup(
    name='sample_python_clamav_test',
    version='0.1.0',
    packages=find_packages(),
    package_data={
        'sample_python_clamav_test': ['test_eicar.txt', 'large_dummy_file.bin'],
    },
    include_package_data=True,
    description='A sample Python package with EICAR signature for AV testing',
)