#!/usr/bin/python
# first of all import the socket library
import random
import socket
import subprocess
import time
import datetime

curLatitude=35.7783757
curLongitude=-78.6795330047607
goalSet=1
IsDataValid=1
def initialize_Socket():
    # next create a socket object
    global s;
    s = socket.socket()
    print "Socket successfully created"

    # reserve a port on your computer in our
    # case it is 12345 but it can be anything
    port = 12345

    # Next bind to the port
    # we have not typed any ip in the ip field
    # instead we have inputted an empty string
    # this makes the server listen to requests
    # coming from other computers on the network
    s.bind(('', port))
    print "socket binded to %s" %(port)

    # put the socket into listening mode
    s.listen(5)
    print "socket is listening"

if __name__ == "__main__":

    # Setup ADC and measure first few values to set threshold
    initialize_Socket();

    c, addr = s.accept()
    print 'Got connection from', addr
    reply="OK"

    pulse_totalTime =0;
    # a forever loop until we interrupt it or
    # an error occurs
    while True:
        start = time.time()
        # Establish connection with client.
        # send a thank you message to the client.

        ######################
        #### RANDOM DATA #####
        ######################
        output="#"
        output+=str(time.time())+",";
        output+=str(IsDataValid)+",";
        output+=str(curLatitude)+",";
        output+=str(curLongitude)+",";
        output+=str(goalSet)
        #print(output+"$\n");
        end = time.time()
        if reply == "OK":
            c.send(output+"$");
        if not reply: break
        reply = c.recv(4096)
        print(output+"\t :"+reply+"\n")
        #print(end - start)
        time.sleep(1);
        curLatitude=1.001*curLatitude
        curLongitude=1.001*curLongitude
# Close the connection with the client
    c.close()

