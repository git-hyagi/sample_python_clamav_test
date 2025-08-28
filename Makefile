clean:
	rm -rf build/ dist/ sample_python_clamav_test.egg-info/

create-large-file:
	dd if=/dev/random of=./sample_python_clamav_test/large_dummy_file.bin bs=1M count=1750

remove-large-file:
	rm ./sample_python_clamav_test/large_dummy_file.bin

build: clean
	python setup.py bdist_wheel

rebuild: clean remove-large-file create-large-file build

clean-cache:
	podman run -it --rm --volume /tmp/clamd.conf:/tmp/clamd.conf:ro clamav/clamav:1.4.3_base clamdscan --config-file=/tmp/clamd.conf --reload
