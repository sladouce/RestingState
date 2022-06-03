import socket
import os
import sys

def LabRecorderPath(apppath,path,participantID):
    os.startfile(apppath+"\\LabRecorder.exe")
    s = socket.create_connection(("localhost",22345))
    filename = bytes("filename {root:"+path+"} {task:RS} {session:1} {participant:"+participantID+"}\n",encoding='utf8')
    s.sendall(filename)
    #s.sendall('select all')
    
if __name__ == '__main__':
    globals()[sys.argv[1]](sys.argv[2],sys.argv[3],sys.argv[4])