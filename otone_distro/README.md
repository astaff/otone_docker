# Overview
Create a single sh file for redistribution. Running ```build.sh``` will collect all docker images from S3 and create a single shell file ```otone-install.sh``` required to install and run OT.one. This shell is all you need to redistribute OT.one software. The script will remove old docker images, unpack and install new ones. 

# To do:
- A/B installation
- Add running bootstrap container to upstart
- Cleanup
- Check integrity before running