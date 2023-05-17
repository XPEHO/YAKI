## yaki_mobile ##

 Yaki mobile content the flutter project :

  - assets content all images we need to run the project and a translate file
  - In the lib file you will discovers three files, main, app and app_router and three folder, data, domain and presentation:

  - All the view is display in ./lib/presentation/ui

  - A style folder is available to use the graphic chart of this project. ./lib/styles

  - In this project we use riverpod for the state-management :
    we use two differents forlder to manage state:
    notifiers folder (./lib/presentation/state/notifier) and providers folder (./lib/presentation/state/provider)

  - We also use dio and retrofit for http request, interceptors...
    you can find the dio file in ./lib/presentation/state/dio

  - For all the data you can find a folder in ./lib/data then you have three files :

  - models : you will find all the model class
  - source : you will find all the http request do with retrofit
  - repositories : you will find all the repositories

  - Test folder like the name said will containt all the test of our application