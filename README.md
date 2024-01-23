# chatting_app

This Project is implemented with:
 - Firebase Authentication (Sign user in and register users with email, password, uid, name and profile pic/ Forgot password sending reset link to email/ validation and exception handling)
 - Cloud Firestore (Storing users collection with the information added from register, user's added friends collections/ user's chatted firends and last message collection/ chat rooms collections and messages)
 - Firebase storage (Uploading profile pictures and regeneration of profile urls to store in user's profile collections of cloud firestore)
 - Hive local persistent storage to store the current user object for the qr code embedding
 - File pciker utils to choose phohos from device gallery
 - Provider statemanagement

A chatting app flutter project implemented with firebase. 💬  The users will be able to send messages to added friends with end to end online chat system. In order to use the app users have to register the account with profile pic, name, email etc, if they don't have an account yet🙋 Otherwise they can login to the app through the login screen with theri email and password✔️ There is also the forgot password page where users and type their email and firebase will send the reset password link to the email. The authentication process and validation is implemented with firebase authentication 💯
Once the authentication process, there will be there screens with the persistent bottom navigation bar for- 
 - Chat page
 - Contact page 
 - QR page
On the appbar session, there will a drawer with the profile view of the current user and will be able to change the profile pic as desire 👤 There is also the light mode ans dark mode switcher and down below user will be able to logout through the logout button. Once the user is registered in the register page, the user information is stored in a collection of cloud firestore and fetched again with user "uid" on the profile drawer.

On the QR page the user profile is embedded in the QR code. The user profile is also fetched by uid on the initial of the QR page and stored in local hive persistent storage to embed in QR code. The qr scanner will be popped withe the floating action button and other user profile will be popped up if the other user qr is scanned and if added friend, both of the user profile will be saved in each of the users collection in cloud firestore respectively🎯

On the Contact page the user's added firends will be shown with the list view fectched from thw firebase collection with Streams. Once tap on a friend will lead to chat page where sending messages will take action📱 After sending messages it will create a chat room in cloud firestore with the data of messages. It will also added to the chatted user collection too.📌

On the chat page will display the chatted users with last message and on tap will navigate to chat page again to continue the chats.

App download link - https://lynnchatapp.my.canva.site/

![Untitled design (21) (1)](https://github.com/LyNNxMooon/Chatting-App/assets/112456534/b02a1fe4-1300-430c-9ffb-72717ad543c8)
![Untitled design (22) (1)](https://github.com/LyNNxMooon/Chatting-App/assets/112456534/3bb4b0d8-afda-4be2-af46-0382a30b2d12)
![Untitled design (23) (1)](https://github.com/LyNNxMooon/Chatting-App/assets/112456534/a1db3e65-fb10-487d-b144-3e393794d9a4)
