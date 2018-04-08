# Ramaze Application

Welcome to your new Ramaze application. This README serves as a starting point
for writing an application using the code you just generated.

Once you've started working on your application you'll probably want to update
this README so that its contents reflect your application's state and purpose.

## Requirements

In order to run this application you'll need to have Ramaze 2.0.0 or newer and
Rake. Optionally you can install Bundler and use it for Gem management, this
can be done as following:

    $ gem install bundler
    $ bundle install

## Rake Tasks

This application comes with a few predefined Rake tasks that make it easy to
get started. You can list these tasks by running `rake -T` or `rake -D` (this
shows longer descriptions for tasks if there are any).

For example, to start a Ramaze console using Pry you'd run the following
command:

    $ rake ramaze:pry

## Resources

In case you need help you can refer to the following resources:

* Ramaze website: <http://ramaze.net/>
* Github repository: <https://github.com/ramaze/ramaze>
* IRC channel: \#ramaze on Freenode

## Wymagania dot. projektu

1. Komponenty warstwy serwerowej i klienta - MVC (widoki, logika aplikacji, sterowanie)
2. Konfiguracja podstawowych mechanizmów serwera (uprawnienia, logowanie deklaratywne, https)
3. Deklaratywny dostęp do bazy danych, prezentacja danych (tabele w widokach aplikacji) i własna baza
4. Modyfikacja danych w bazie (CRUD) za pomocą DAO lub ORM
5. Generowanie dokumentów .pdf, grafiki .jpg, .png na podstawie danych z bazy np. raport, zestawienie, wykres
6. Zastosowanie JavaScript w formularzach (walidacje formuły itp., logika)
7. Zastosowanie AJAX / JSON (asynchroniczne przesyłanie danych z / do serwera)
8. Zastosowanie CSS (szablony i reguły, zmiana motywu, personalizacja) - wlasne lub np. Bootstrap
