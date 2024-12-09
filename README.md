# pokemon_db

A Pokemon Database written in Flutter using https://pokeapi.co/

# Modularised using Clean Architecture.

Presentation
* UI (widgets, pages)
* Bloc

Domain
* Business logic (usecases)
* Models

Repository
* Handles and converts data from API and local storage

Local
* Gets and stores data in local storage for caching
* SQLite

Data
* Gets data from API
* Dio

# Comprehensive unit testing in all modules.

<img width="588" src="https://github.com/user-attachments/assets/58c2993c-8cc0-44d8-acc5-84a7ada7a727">


Integration tests to validate interaction between all components

<img width="561" src="https://github.com/user-attachments/assets/d02ef58c-9ccc-4fff-969d-8bb3a6fea6ed">


# Light and Dark modes

<img width="300" src="https://github.com/user-attachments/assets/9d1e1a33-a769-4418-b22f-d266fe3a1170"> <img width="300" src="https://github.com/user-attachments/assets/2c7accb3-91b3-4779-a37c-8adf1fc3761d"> 



# Using shimmer for loading states
![shimmer](https://github.com/user-attachments/assets/e814d287-136a-4253-aaf8-ca555a75d43c)

# Caching images for smooth loading with CachedNetworkImage
![caching_images](https://github.com/user-attachments/assets/98731128-a63c-4301-b7c2-26c437f1393e)

Here you can also see a custom list is used to smoothly hide the top bar on scroll, then scroll up a little to see it again.


# Using Stream to fetch quickly from cache and showing a loading bar while waiting for API data
![stream](https://github.com/user-attachments/assets/3df5ba85-699f-4e86-9fd7-eddd5ac897e5)

# Animations 
![pokedex_animation](https://github.com/user-attachments/assets/7b948b56-d492-448f-9b90-7cd46ec3c94a) ![pokemon_animation](https://github.com/user-attachments/assets/35473a50-cb3d-4c90-aaad-5bfb86334549)

# Pull down to refresh
![refresh_pokedex](https://github.com/user-attachments/assets/0809fafc-2fcc-40f1-ac3d-65de8a643b2a) ![refresh_pokemon](https://github.com/user-attachments/assets/2a387eda-7304-4d97-a431-a64559d8a036)



