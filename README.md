# Abico Warehouse App

<p align="center">
    <img src="https://img.shields.io/badge/Platform-Android%20|%20iOS?logo=flutter" alt="Platform"/>
</p>

## Finished Tasks
 - [ ] DB update.
 - [x] Screen display hemjeenees hamaaraad oorchlogdoh.


## System Requirements

 - ### Dart SDK Version 2.17.0 or greater.
 - ### Flutter SDK Version (2.7.0) or greater than (3.0.0)


## Project Structure

```
.
├── android                         - contains files and folders required for running the application on an Android operating system.
├── assets                          - contains all images and fonts of your application.
├── ios                             - contains files required by the application to run the dart code on iOS platforms.
├── linux                           - contains files required by the application to run the dart code on linux platforms.
├── macos                           - contains files required by the application to run the dart code on macos platforms.
├── windows                         - contains files required by the application to run the dart code on windows platforms.
├── web                             - contains files required by the application to run the dart code on web platforms.
└── lib                             - Most important folder in the project, used to write most of the Dart code. 
    ├── main.dart                   - starting point of the application
    ├── components
    │    ├── component_interface    - Interface For building Components 
    │    └── componnents            - Components
    ├── data
    │    ├── blocs                  - Request Bussiness Logic
    │    ├── repository             - Request Bussiness Logic Repository
    │    ├── service                - Request Bussiness Logic Request Service
    │    ├── db provider            - DB Provider
    ├── models
    │    ├── dto                    - request DTO 
    │    ├── entity                 - request Entity
    │    └── screen args            - Screen navigation Arguments
    ├── exceptions                  - Request Exceptions
    ├── screens                     - This Projects contained screens
    │       ├── category move 
    │       ├── category sales  
    │       ├── dashboard
    │       │      └── tabs
    │       │            ├── category
    │       │            └── settings 
    │       ├── login
    │       ├── badge
    └── utils                       - This Projects utility files
    
```

- ### Хөгжүүлэлтийн орчиндоо зориулан энэ хүү plugin уудыг тухайн editor дээрээ суулгах

  -  ### Dart
  -  ### Flutter 


- ### Flutter Package татах

         flutter pub get

- ### IOS Pod File татах

         cd ios && pod install 


- ### Flutter run прожект асаах

         flutter run  

- ### Хэрвээ gradle version зөрж байвал  

         cd android && .gradlew wrapper 


# To Do Tasks

1.  Aguulahiin hudulguun  belen bga delgetsiin saijiruulah
2. Toollogiin Burtgel     Belen bga delgetsiig saijiruulah
3. Baraanii burtgel       Belen bga delgetsiig saijiruulah
4. Bar Code unshih        Belen bga delgetsiig saijiruulah
5. Hr delgets             Hr Reqquest iig shalgah