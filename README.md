# covid19
Covid19 - Application for contact tracing system and information

Installation steps:

- Make sure you have cocoapods installed and up to date
  - cocoapods instalation command:  "sudo gem install cocoapods"
  - cocoapods update command:       "sudo gem install cocoapods"
  
- Navigate to the project directory (location of covid19.xcodepro)
- Run pods instalation command: "pod install"
- Wait for the installation to finish
- Open covid19.xcworkspace file

In order to make the application work you will need: 
- Google nearby api key: https://developers.google.com/nearby/messages/ios/get-started#step_6_get_an_api_key
- Setup project in firebase console
- Chose firestore database
- In authentication activate email and phone methods
- Firebase configuration file: https://firebase.google.com/docs/ios/setup#add-config-file

After acquiring the above information please add them to the application
- Add Google Nearby API key under Constants/Keys.swift (there is warning that points you to this location)
- Insert firebase configuration file into your project, usualy same level as Info.plist
- Change the URLSchemes in Target -> URL Types to match the value from you firebase configuration file with key "REVERSED_CLIENT_ID"

After starting the application and everything is ready the "DBImport" will import data to your firestore database.
Make sure to remove this line after the data is saved in firestore beacause it will replace the data every time is runned.

The data is not correct and serves only for demonstration purposes.
