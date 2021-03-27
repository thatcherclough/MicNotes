# MicNotes
MicNotes is an iOS app allows you add notes to the apple notes app from your Apple Watch.

## How it works
MicNotes allows you to add notes to the apple notes app from your Apple Watch. It uses a custom Siri Shortcut to do this. Here is how it works:
1) A note is created on the Apple Watch using the MicNotes Apple Watch App.
2) This note is then sent to the iPhone, and storred in UserDefaults. 
3) When the custom Siri Shortcut (avaliable [here](https://www.icloud.com/shortcuts/6a1b52c859a44647b553412356ec491c)) is triggered, it takes all of the notes storred in UserDefaults and adds them to the notes app. 

Using autiomations, this shortcut can be triggered everytime the notes app is opened. 

## Installation
Given the hacky nature of this app, MicNotes is not on the App Store. In order to install MicNotes, you must do so manually using Xcode. Furthermore, a developer account is needed in order for the UserDefalts groups to work.

## License
[MIT](https://choosealicense.com/licenses/mit/)

Copyright 2021 © Thatcher Clough.
