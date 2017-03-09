# ProjectGroup9

Installing pods for MBCircularProgressBar

https://cocoapods.org/
1. open the terminal
> sudo gem install cocoapods
//install the cocoapods for the comment "pod"
> cd ProjectGroup9
//change the directory to the file of project
> pod init
//create a new text file called Podfile

2. open the Podfile
edit the file like this:
uncomment the:
platform :ios, '9.0'
use_frameworks!
add:
pod "MBCircularProgressBar"
under the comment pod for brreathify

3. back to terminal
> pod install

4. open the Breathify.xcworkspace and now you can import MBCircularProgessbar
