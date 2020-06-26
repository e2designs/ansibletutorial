Dockerized ansible playground. 

docker-compose will set up 3 containers.
A controller (controller) and two ubuntu hosts (ansible1, ansible2).
ssh keys are set up between controller and the two hosts.


To run:

    # Build and run container
    make run
    # Connect to the ansible controller as ansible user
    make connect 
    
    

