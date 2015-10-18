# Friends of the Library
Friends of the Library (FOL) is an app for small nonprofit organizations to accept donations, connect with their audience and improve their marketing with data. Volunteers can track contacts, view donation data, make edits, and perform data entry all on one page.

## Features

* RESTful API, versioned, on subdomain, and built on Ruby on Rails with user authenticiation.
* Single page React JS admin interface for data visualization and database management.
* Stripe payment processing for donations
* Address standardization with SmartyStreets API
* Mobile friendly responsive design on client side

## Demo

View the [demo production site](www.libraryfriendsdemo.com), running on Heroku.
* input ```4242424242424242``` as card number and ```999``` as security code to test payments.
* use email: ```demo@demo.com``` and password: ```demopassword``` to login to the admin area (button in footer)

## Developing Locally

1. ```curl get.pow.cx | sh```
2. ```ln -s /path/to/fol```
3. ```bundle install```
4. ```npm install```
5. ```rake db:create```
6. Sign up for test keys from [Stripe](https://stripe.com/) and [SmartyStreets](https://smartystreets.com/) and add to .env
7. ```rake db:migrate```
8. ```rake db:seed```
8. Go to ```fol.dev``` in your browser.

## Deploying to Heroku

1. Set ENV variables with ```heroku config:set VARIABLE=VALUE```
2. ```heroku buildpack:set https://github.com/heroku/heroku-buildpack-multi.git```
3. [Add Subdomain](https://devcenter.heroku.com/articles/custom-domains)
