import os
import time

while True:
    with open("/home/levi/Pi_Controlcmd/picmd.txt", "r") as file1:
        picmd = file1.read().strip() 

    if picmd:
        print(f"read command: {picmd}")  
        with open("/home/levi/Pi_Controlcmd/picmd.txt", "w") as file:
            file.write("") 
        print(f"operate command: {picmd}") 
        os.system(picmd + ' &') 

    time.sleep(1)  
