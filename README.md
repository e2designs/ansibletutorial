Dockerized ansible playground. 

docker-compose will set up 3 containers.
A controller (controller) and two ubuntu hosts (ansible1, ansible2).
ssh keys are set up between controller and the two hosts.


Requirements:

    - Docker-Engine (Tested on Docker version 19.03.8, build afacb8b)
    - Python3 (Tested on python3.8)
    - Docker-compose (Tested on docker-compose version 1.25.5, build 8a1c60f6)

To run:

    # Build and run container
    make run
    # Connect to the ansible controller as ansible user
    make connect 
