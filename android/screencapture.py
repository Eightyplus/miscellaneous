from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice
import commands
import sys
import os

# starting the application and test
print "Starting the monkeyrunner script"

if not os.path.exists("screenshots"):
    print "creating the screenshots directory"
    os.makedirs("screenshots")

# connection to the current device, and return a MonkeyDevice object
device = MonkeyRunner.waitForConnection()

width = int(device.getProperty("display.width"))
height = int(device.getProperty("display.height"))


apk_path = device.shell('pm path <APP_IDENTIFIER>')
if apk_path.startswith('package:'):
    print "application installed."
else:
    print "not installed, install APK"
    device.installPackage('<APK_FILE>')

print "starting application...."
device.startActivity(component='<APP_IDENTIFIER>/<PATH_TO_ACTIVITY>')

device.wake()
MonkeyRunner.sleep(5)

#print "taking screenshot"
result = device.takeSnapshot()
result.writeToFile('./screenshots/screenshot1.png','png')

print "starting login"
device.touch(width-200,height-50, MonkeyDevice.DOWN_AND_UP)

MonkeyRunner.sleep(1)
device.touch(width/2, height/2+100, MonkeyDevice.DOWN_AND_UP)

MonkeyRunner.sleep(1)
device.type("qwerty")

MonkeyRunner.sleep(1)
device.touch(width/3, height + 70, MonkeyDevice.DOWN_AND_UP)

MonkeyRunner.sleep(1)
device.touch(width-100, height-400, MonkeyDevice.DOWN_AND_UP)

MonkeyRunner.sleep(1)
device.touch(width/2, height/2, MonkeyDevice.DOWN_AND_UP)

#screenshot
#print "taking screenshot"
#result = device.takeSnapshot()
#result.writeToFile('./screenshots/screenshot2.png','png')
#print "screenshot taken and stored on device"

#sending an event which simulate a click on the menu button
#device.press('KEYCODE_MENU', MonkeyDevice.DOWN_AND_UP)

MonkeyRunner.sleep(1)
device.touch(width/2, height-10, MonkeyDevice.DOWN_AND_UP)

MonkeyRunner.sleep(1)
#print "taking screenshot"
result = device.takeSnapshot()
result.writeToFile('./screenshots/screenshot3.png','png')
print "screenshot taken and stored on device"

MonkeyRunner.sleep(1)
device.touch(width-100, 50, MonkeyDevice.DOWN_AND_UP)

MonkeyRunner.sleep(1)

result = device.takeSnapshot()
result.writeToFile('./screenshots/screenshot4.png','png')
print "screenshot taken and stored on device"


print "Finishing the test"
