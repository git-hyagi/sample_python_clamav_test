clean:
	rm -rf build/ dist/ sample_python_clamav_test.egg-info/

create-large-file:
	dd if=/dev/random of=./sample_python_clamav_test/large_dummy_file.bin bs=1M count=1950

remove-large-file:
	rm ./sample_python_clamav_test/large_dummy_file.bin

build:
	python setup.py bdist_wheel
