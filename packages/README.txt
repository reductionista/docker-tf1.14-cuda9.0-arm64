The JetPack-L4T-3.3-linux-x64_b39.run can be downloaded from
this location, NVIDIA requires you to create a free account in
order to download it:

https://developer.nvidia.com/embedded/dlc/jetpack-l4t-3_3

For more instructions, see:
https://www.programmersought.com/article/13234379649/

./JetPack-L4T-3.3-linux-x64_b39.run --list
Target directory: _installer
drwx------  0 buildmeister dip         0 Jul 23  2018 ./
-r--------  0 buildmeister dip     38312 Jul 23  2018 ./Third_Party_Licenses.txt
-rwx------  0 buildmeister dip       440 Jul 23  2018 ./remove_unsupported_cuda_samples.sh
-rwx------  0 buildmeister dip   2593681 Jul 23  2018 ./run_command
-rwx------  0 buildmeister dip   8390546 Jul 23  2018 ./PageAction
-rwx------  0 buildmeister dip   8648832 Jul 23  2018 ./InstallUtil
-rwx------  0 buildmeister dip   7829898 Jul 23  2018 ./flash_os
-rwx------  0 buildmeister dip       358 Jul 23  2018 ./ocv.sh
-r-x------  0 buildmeister dip       491 Jul 23  2018 ./rc.local
-rwx------  0 buildmeister dip   2879707 Jul 23  2018 ./sudo_daemon
-rwx------  0 buildmeister dip  25656456 Jul 23  2018 ./Chooser
-r-x------  0 buildmeister dip       549 Jul 23  2018 ./report_ip_to_host.sh
-rwx------  0 buildmeister dip   7868090 Jul 23  2018 ./configure_host
-rwx------  0 buildmeister dip   7847269 Jul 23  2018 ./JetPack_Uninstaller
-rwx------  0 buildmeister dip  21732680 Jul 23  2018 ./Poller
-rwx------  0 buildmeister dip      1269 Jul 23  2018 ./cuda-l4t.sh
-rwx------  0 buildmeister dip   8254020 Jul 23  2018 ./nv_info_broker
-rwx------  0 buildmeister dip  13883016 Jul 23  2018 ./Launcher
-rw-------  0 buildmeister dip        50 Jul 23  2018 ./local.cfg.tmp
-r-x------  0 buildmeister dip      2242 Jul 23  2018 ./start_up.sh

Using the graphical interface that comes up when ./start_up.sh is runm, you can download the
arm64 cuda-9.0 repo debian package, the cuDNN 7.1.15 arm64 debian packages, and optionally
tensorrt for arm64 (not required for tensorflow):

604852294 Jun 30 22:00 cuda-repo-l4t-9-0-local_9.0.252-1_arm64.deb
  1508560 Jun 30 22:00 tensorrt_4.0.2.0-1+cuda9.0_arm64.deb
 84211230 Jun 30 22:00 libcudnn7-dev_7.1.5.14-1+cuda9.0_arm64.deb
  5859366 Jun 30 22:00 libcudnn7-doc_7.1.5.14-1+cuda9.0_arm64.deb
 89552864 Jun 30 22:00 libcudnn7_7.1.5.14-1+cuda9.0_arm64.deb
  1508560 Jun 30 22:00 tensorrt_4.0.2.0-1+cuda9.0_arm64.deb
