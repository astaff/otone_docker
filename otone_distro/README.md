# Overview
Create a single sh file for redistribution. Running ```build.sh``` will collect all docker images required to run OT.one from S3, and put them into a single shell file ```otone-install.sh```. This shell is all you need to redistribute OT.one software. The file will remove old docker images, unpack and install new ones. 

# To do:
- A/B installation
- Add running bootstrap container to upstart
- Cleanup
- Check integrity before running