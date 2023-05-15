# dataloggerPythonCameraMatch
# needs to read serial data and save as a csv
# needs to trigger a video capture event and save the file separately
# needs to send inputs back to the arduino to stop the file -> ser.write(b'\n')
# saves everything in the same folder with the new title

#order of operations: create a new folder, read serial data and save to variable, save as csv

import pathlib
import numpy as np
from numpy import random
import os
import serial
import csv
import time
import pandas as pd
import keyboard
import cv2
from win_record import *
from multiprocessing import Process
from dataloggerPythonCameraMatch import *
from win_record import *
import time

# is your camera aligned?
# q spot:

drive = 160
fluctuation = 61

#toggle for no coordination studies
# folder = 'GroupNoCoordinationDrive' + str(drive) + 'Fluct' + str(fluctuation)
# csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'groupnoCoordpowerData.csv'
# video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'groupnoCoordvideo.avi'

# folder = 'NoCoordinationDrive' + str(drive) + 'Fluct' + str(fluctuation)
# csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'noCoordpowerData.csv'
# video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'noCoordvideo.avi'

# folder = 'NoCoordinationDrive' + str(drive) + 'Fluct' + str(fluctuation) + 'Otger'
# csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'noCoordpowerDataOtger.csv'
# video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'noCoordvideoOtger.avi'

# folder = 'NoCoordinationDrive' + str(drive) + 'Fluct' + str(fluctuation) + 'GroupOtger'
# csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'noCoordpowerDataGroupOtger.csv'
# video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'noCoordvideoGroupOtger.avi'

# folder = 'NoCoordinationDrive' + str(drive) + 'Fluct' + str(fluctuation) + 'GroupGaussian'
# csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'noCoordpowerDataGroupGaussian.csv'
# video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'noCoordvideoGroupGaussian.avi'

# folder = 'NoCoordinationDrive' + str(drive) + 'Fluct' + str(fluctuation) + 'GroupGaussianFluctOrientation'
# csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'noCoordpowerDataGroupGaussianFluctOrientation.csv'
# video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'noCoordvideoGroupGaussianFluctOrientation.avi'


# folder = 'Drive' + str(drive) + 'Fluct' + str(fluctuation)
# csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'powerData.csv'
# video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'video.avi'

# folder = 'Drive' + str(drive) + 'Fluct' + str(fluctuation) + 'Square'
# csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'powerDataSquare.csv'
# video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'videoSquare.avi'

# folder = 'Group' + str(drive) + 'Fluct' + str(fluctuation)
# csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'groupCoordData.csv'
# video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'groupCoordvideo.avi'

folder = 'Group' + str(drive) + 'Fluct' + str(fluctuation) + 'CoordGaussian'
csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'groupCoordDataCoordGaussian.csv'
video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'groupCoordvideoCoordGaussian.avi'

def camLog():
    # drive = 179
    # fluctuation = 0

    released = False

    # # new_dir_name = input('New folder name: ')
    new_dir_name = folder
    # # new_dir_name = "test"
    new_dir = pathlib.Path('C:/Users/mrdev/Documents/EmbryoJournal', new_dir_name)
    # new_dir.mkdir(parents=True, exist_ok=True) #False to not overwrite
    # You have to make a file inside the new directory
    # csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'powerData.csv'
    # video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'video.avi'
    # new_file = str(new_dir) + csv_label
    video_name = str(new_dir) + video_label
    # new_file.write_text('Hello file')
    cap = cv2.VideoCapture(1, cv2.CAP_DSHOW)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)
    frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH)) #3
    frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT)) #4
    frame_size = (frame_width,frame_height)
    fps = 30
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1920)
    output = cv2.VideoWriter(str(video_name), cv2.VideoWriter_fourcc('M','J','P','G'), fps, frame_size)



    samples = 110
    line = 0
   
    read = True
    time.sleep(5)
    # trial = 0
    while True:
        try:
            # if keyboard.is_pressed("q"):
            #     # ser.write(b'5\n')
            #     read = not read
            #     # if (read):
            #     #     trial += 1
            #     time.sleep(0.2)
                
            if (read):
                ret, frame = cap.read() 
                output.write(frame) 
            
        except KeyboardInterrupt:
            # cv2.imshow('name',frame)
            # print(frame.size)
            # cv2.waitKey(0)
            break
        #     
    cap.release()
    
    # After we release our webcam, we also release the output
    while cap.isOpened():
        cap.release()


        
    
    # De-allocate any associated memory usage 
    cv2.destroyAllWindows()
    print("cam done")
    

def powerLog():
    # drive = 179
    # fluctuation = 0

    # folder = 'NoCoordinationDrive' + str(drive) + 'Fluct' + str(fluctuation)

    # new_dir_name = input('New folder name: ')
    new_dir_name = folder
    # new_dir_name = "test"
    new_dir = pathlib.Path('C:/Users/mrdev/Documents/EmbryoJournal', new_dir_name)
    new_dir.mkdir(parents=True, exist_ok=True) #False to not overwrite
    # You have to make a file inside the new directory
    # csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'powerData.csv'
    # video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'video.avi'
    new_file = str(new_dir) + csv_label
    video_name = str(new_dir) + video_label
    # new_file.write_text('Hello file')
    # cap = cv2.VideoCapture(1, cv2.CAP_DSHOW)
    # cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
    # cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)
    # frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH)) #3
    # frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT)) #4
    # frame_size = (frame_width,frame_height)
    # fps = 30
    # cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1920)
    # output = cv2.VideoWriter(str(video_name), cv2.VideoWriter_fourcc('M','J','P','G'), fps, frame_size)



    # win_record(60, video_name)
    # time.sleep(5)

    # ret, frame = cap.read() 

    # cv2.putText(frame, str(cX),(cX,cY), cv2.FONT_HERSHEY_SIMPLEX, 1,(0,255,255),2)
    # cv2.imshow('name',frame)
    # print(frame.size)
    # cv2.waitKey(0)


    ser = serial.Serial('COM4',9600)
    ser.flushInput()
    # input('Ready...?')
    samples = 100
    line = 0
    # x = np.empty((1,8))
    # while line <= samples:
    #     getData=ser.readline().decode('utf-8')
    #     # dataString = getData.decode('utf-8')
    #     # data=dataString[0:][:-2]
    #     # dataString = getData.decode('utf-8')
    #     data=getData[1:][:-1]
    #     # print(getData)

    #     # readings = data.split(",")
    #     print(getData)

    #     # sensor_data.append(readings)
    #     # print(sensor_data)

    #     line = line+1
    #     x = np.vstack((x,data))

    # readLine = "Power; Power1; Power2; Power3;"

    x = np.array(['Power 0B', 'Power 1Y', 'Power 2G', 'Power 3W', 'Time', 'Trial Number'])
    start = time.time()
    time.sleep(5)
    ser.write(b'1\n')
    read = True
    trial = 0
    while True:
        try:
            if keyboard.is_pressed("q"):
                ser.write(b'5\n')
                read = not read
                if (read):
                    trial += 1
                time.sleep(0.2)
                
            if (read):
                # ret, frame = cap.read() 
                # Converts to HSV color space, CV reads colors as BGR
                # frame is converted to hsv
                # hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
                
                # output the frameqqqqqqq
                # label = 'Drive ' + str(drive) + ' Fluct ' + str(fluctuation) + ' Trial ' + str(trial)
                # cv2.rectangle(frame, (0, 0), (int(frame_width), 50), (0, 0, 0), -1)
                
                # output.write(frame) 
                ser_bytes = ser.readline()
                # print(ser_bytes[0:][:-3])
                # decoded_bytes = ser_bytes[1:len(ser_bytes)-2].decode()
                decoded_bytes = str(ser_bytes)[2:][:-5]
                # print(decoded_bytes[2:][:-5])qqqqqqq
                data = decoded_bytes.split(",")
                data = np.array(data)
                data = np.append(data, str(trial))
                # cv2.putText(frame, str(data[0]),(int(frame_width - 450), int(30)), cv2.FONT_HERSHEY_SIMPLEX, 1,(255,255,255),2)
                # output.write(frame) 
                print(data)
                x = np.vstack((x,data))
                pd.DataFrame(x).to_csv(new_file, header=None, index=None)
        except KeyboardInterrupt:
            # cv2.imshow('name',frame)
            # print(frame.size)
            # cv2.waitKey(0)
            break
        #     prompt = input("Continue? y/n")
        #     if (prompt =='y'):
        #         print("Continuing...")
        #     else:
        #         break
        #     # break

    # print(x)
    # x.tofile('data.csv', sep = ',')

    # pd.DataFrame(x).to_csv("testpd.csv", header=None, index=None)
    # Close the window / Release webcam
    # cap.release()
    
    # After we release our webcam, we also release the output
    # output.release() 
    
    # De-allocate any associated memory usage 
    # cv2.destroyAllWindows()
    time.sleep(3)
    print("power done")
    
    
    # print(time.time()-start, " seconds")

        # with open("test_data.csv","a") as f:
        #     writer = csv.writer(f,delimiter=",")
        #     # writer.writerow([time.time(),decoded_bytes])
        #     writer.writerow([data])
        # except:
        #     print("Keyboard Interrupt")
        #     break


    # data = np.vstack((headers,x))
    # print(data)

    # os.chdir('C:/Users/mrdev/Documents/EmbryoJournal/' + new_dir_name)

# data.tofile('data.csv', sep = ',')
# powerLog()
if __name__ == '__main__':
    

    # folder = 'Drive' + str(drive) + 'Fluct' + str(fluctuation)

    # # new_dir_name = input('New folder name: ')
    # new_dir_name = folder
    # # new_dir_name = "test"
    # new_dir = pathlib.Path('C:/Users/mrdev/Documents/EmbryoJournal', new_dir_name)
    # new_dir.mkdir(parents=True, exist_ok=True)
    # csv_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'powerData.csv'
    # video_label = '/drive' + str(drive) + 'fluct' + str(fluctuation) + 'video.avi'
    # new_file = str(new_dir) + csv_label
    # video_name = str(new_dir) + video_label
    # p1 = Process(target = camLog(drive, fluctuation))
    
    # p2 = Process(target = powerLog(drive, fluctuation))
    input('Did you check camera alignment, drive, fluctuation?')
    try:
        p1 = Process(target = camLog)
        p1.daemon = True
        p2 = Process(target = powerLog)
    
        p2.start()
        p1.start()
        p2.join()
        p1.join()
    except:
        print('Done with Drive: ' + str(drive) + ' Fluctuation: ' + str(fluctuation))

    
