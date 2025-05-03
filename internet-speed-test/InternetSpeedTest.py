# Python program to test
# internet speed
import tkinter 
from tkinter import *
import speedtest
import tkinter.messagebox

option=''
def downloadSpeed():
	global option
	option='Download Speed'
	showSpeed()

def uploadSpeed():
	global option
	option='Upload Speed'
	showSpeed()

def ping():
	global option
	option='Ping'
	showSpeed()

def showSpeed():
	global option
	st = speedtest.Speedtest()
	if option == 'Download Speed':
		speed=(st.download())

	elif option == 'Upload Speed':

		speed=(st.upload())

	elif option == 'Ping':

		servernames =[]

		st.get_servers(servernames)

		speed=(st.results.ping)
	speedWithUnits=''
	if(speed<1000):
		speedWithUnits=str(round(speed, 3))+" bps"
	elif(speed<1000000):
		speedWithUnits=str(round(speed/1000, 3))+" Kbps"
	elif(speed<1000000000):
		speedWithUnits=str(round(speed/1000000, 3))+" Mbps"
	else:
		speedWithUnits=str(round(speed/1000000000, 3))+" Gbps"
	
	#print( "Hi! Your" +option+" Speed is:"+speedWithUnits)
	tkinter.messagebox.showinfo("DataFlair Internet Speed Tester",  "Hi! Your " +option+" Speed is:"+speedWithUnits)


#Creating the main window 
wn = tkinter.Tk() 
wn.title("DataFlair Internet Speed Tester")
wn.geometry('700x300')
wn.config(bg='azure')
  
Label(wn, text='DataFlair Internet Speed Tester',bg='azure',
      fg='black', font=('Courier', 15)).place(x=40, y=10)

Label(wn, text='Choose any of the below options',bg='azure',
      fg='black', font=('Courier', 12)).place(x=20, y=40) 

#Button to convert Audio to PDF form
Button(wn, text="Check Download Speed", bg='ivory3',font=('Courier', 15),width=20,
       command=downloadSpeed).place(x=230, y=80)

#Button to Check Upload Speed
Button(wn, text="Check Upload Speed", bg='ivory3',font=('Courier', 15),width=20,
       command=uploadSpeed).place(x=230, y=150)
	   
#Button to convert Audio to PDF form
Button(wn, text="Check Ping", bg='ivory3',font=('Courier', 15),width=20,
       command=ping).place(x=230, y=220)

#Runs the window till it is closed
wn.mainloop()
