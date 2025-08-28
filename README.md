# ABOUT
Sample large package to check the time to scan it through clamav.


# BUILDING
To build this package:
```
pip install wheel setuptools
python setup.py bdist_wheel
```

The sample file was created using the command:
```
dd if=/dev/random of=large_dummy_file.bin bs=1M count=1950
```


# Testing

* create clamd config file
```
clamd_addr="172.17.0.3"
cat<<EOF>/tmp/clamd.conf
LogFile /var/log/clamav/clamd.log
LogTime yes
TCPSocket 3310
TCPAddr $clamd_addr
User clamav
EOF
```

* run the scan
```
$ podman run -it --rm \
  --volume ./dist/sample_python_clamav_test-0.1.0-py3-none-any.whl:/tmp/test.whl:ro \
  --volume /tmp/clamd.conf:/tmp/clamd.conf:ro \
  --name clamav \
  clamav/clamav:1.4.3_base clamdscan --config-file=/tmp/clamd.conf /tmp/test.whl

/tmp/test.whl: OK

----------- SCAN SUMMARY -----------
Infected files: 0
Time: 77.479 sec (1 m 17 s)
Start Date: 2025:08:28 17:23:02
End Date:   2025:08:28 17:24:20
```


* trying to run again with the same file
```
$ podman run -it --rm \
  --volume ./dist/sample_python_clamav_test-0.1.0-py3-none-any.whl:/tmp/test.whl:ro \
  --volume /tmp/clamd.conf:/tmp/clamd.conf:ro \
  --name clamav \
  clamav/clamav:1.4.3_base clamdscan --config-file=/tmp/clamd.conf /tmp/test.whl

/tmp/test.whl: OK

----------- SCAN SUMMARY -----------
Infected files: 0
Time: 5.538 sec (0 m 5 s)
Start Date: 2025:08:28 17:25:51
End Date:   2025:08:28 17:25:56
```

* checking only the "infected" file (which is part of this package)
```
$ podman run -it --rm \
  --volume ./sample_python_clamav_test/test_eicar.txt:/tmp/test_eicar.txt:ro \
  --volume /tmp/clamd.conf:/tmp/clamd.conf:ro \
  --name clamav \
  clamav/clamav:1.4.3_base clamdscan --config-file=/tmp/clamd.conf /tmp/test_eicar.txt

/tmp/test_eicar.txt: Win.Test.EICAR_HDB-1 FOUND

----------- SCAN SUMMARY -----------
Infected files: 1
Time: 0.004 sec (0 m 0 s)
Start Date: 2025:08:28 17:27:41
End Date:   2025:08:28 17:27:41
```