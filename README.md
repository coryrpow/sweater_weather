# Sweater Weather
Created by: Cory Powell | [LinkedIn](https://www.linkedin.com/in/coryrpow/)
## Directory
- [Project Description](project-description)
- [Dates](dates)
- [Built Using](built-using)
- [Testing](testing)
- [Installation Instructions](installation-instructions)
- [Requirements](requirements)
- [Learning Goals](learning-goals)
- [API Documentation](api-documentation)
  - [GET forecast](retrieve-weather-forecast-for-a-city)
  - [POST users](user-registration)
  - [POST login](login)
  - [POST Road Trip](road-trip)

  
## Project Description
> This application serves as the back-end of an app that:
> - Displays a weather forecast for a city on the landing page
> - Registers users in the database and creates an api_key unique to each registered user
> - Allows existing users to log back in
> - Grants users the ability to plan road trips where they see the current weather, as well as the forecasted weather at the destination
>
> This application makes all of that possible by exposing multiple API endpoints and formatting the needed data to meet the needs of the front end.

## Dates
- January 12, 2024 - January 17, 2024

## Built Using
- [Ruby 3.2.2](https://github.com/ruby/ruby)
- [Rails 7.1.2](https://github.com/rails/rails)

## Testing
- [RSpec 3.12](https://github.com/rspec/rspec-rails)
- [Capybara](https://github.com/teamcapybara/capybara)
- [Webmock](https://github.com/bblimke/webmock)
- [VCR](https://github.com/vcr/vcr)

## Installation Instructions
 - Fork Repository
 - `git clone <repo_name>`
 - `cd <repo_name>`
 - `bundle install`   
 - `rails db:{drop,create,migrate,seed}`
 - `rails server` 


## Requirements
This repo utilizes multiple APIs and requires that the developer using this repo obtain their own keys and permissions from them accordingly.

[Mapquest API](https://developer.mapquest.com/documentation)
[Weather API](https://www.weatherapi.com)
[Yelp API](https://docs.developer.yelp.com/docs/getting-started)

To run this test suite, obtain API keys to the above APIs and add them to the Rails Credentials file using the `EDITOR="code --wait" rails credentials:edit` command.

Once those have been added, you can run the whole test suite with: `bundle exec rspec`

## Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

## API Documentation

### Retrieve weather forecast for a city

`GET /api/v0/forecast?location=Denver,CO`

**Example response:**
```
 "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "last_updated": "2024-01-16 21:30",
                "temperature": 21.0,
                "feels_like": 14.0,
                "humidity": 49,
                "uvi": 1.0,
                "visibility": 9.0,
                "condition": "Partly cloudy",
                "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
            },
            "daily_weather": [
                {
                    "date": "2024-01-16",
                    "sunrise": "07:19 AM",
                    "sunset": "05:01 PM",
                    "max_temp": 31.2,
                    "min_temp": -4.2,
                    "condition": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                },
                ... continued ...
           
            ],
            "hourly_weather": [
                {
                    "time": "2024-01-16 00:00",
                    "temperature": -3.8,
                    "conditions": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                ... continued ...
        }
 }

```
___
### User Registration

`POST "/api/v0/users"`

Note: This response mimics a theoretical front end sending you JSON body of a user registering for the site. An example would look like this:
```
{
        "email": "coolguy@cool.com",
        "password": "cellardoor",
        "password_confirmation": "cellardoor"
      }
```
#### In order to see how this mock JSON body example would work in Postman:
- Open Postman and click the `+` button in the upper right hand side
- In the text box next to the `GET` with the field `Enter URL or past text` enter in the url <your localhost>/api/v0/users
- Click on the drop down button to the right of the `GET ` and select `POST`
- Select the `Body` tab, below the url
- Click the dropdown button to the right of `none` and select `raw`
- Enter the example body above in to this raw field
- You are now ready to click the Blue `Send` button and see the response


**Example response:**
```
{
    "data": {
        "id": "2",
        "type": "user",
        "attributes": {
            "email": "whatever@example.com",
            "password": "password",
            "password_confirmation": "password",
            "api_key": "06159fb68baae31feafd"
        }
    }
}
```

** OR (if you already created a user and it has been saved to the database)
```
{
    "error": "This email already has an account with us.",
    "status": 422
}
```
___
### Login

`POST "/api/v0/sessions"`

Note: This response mimics a theoretical front end user that has already created an account, sending you JSON body. An example would look like this:
```
{
  "email": "whatever@example.com",
  "password": "password"
}
```
#### In order to see how this mock JSON body example would work in Postman:
- Open Postman and click the `+` button in the upper right hand side
- In the text box next to the `GET` with the field `Enter URL or past text` enter in the url <your localhost>/api/v0/sessions
- Click on the drop down button to the right of the `GET ` and select `POST`
- Select the `Body` tab, below the url
- Click the dropdown button to the right of `none` and select `raw`
- Enter the example body above in to this raw field
- You are now ready to click the Blue `Send` button and see the response


**Example response:**
```
{
    "data": {
        "id": "2",
        "type": "user",
        "attributes": {
            "email": "whatever@example.com",
            "password": null,
            "password_confirmation": null,
            "api_key": "06159fb68baae31feafd"
        }
    }
}
```
___
### Road Trip

`POST "/api/v0/road_trip"`

Note: This response mimics a theoretical front end user that has already created an account and thus, already has an api_key unique to their account, sending you JSON body of an origin city, a destination city, and their api_key. This example response will NOT work if an existing user, with an existing api_key has not been created. Check the `db/seeds.rb` file for a singular example user to utlize. An example would look like this:
```
{
  "origin": "Cincinatti,OH",
  "destination": "Chicago,IL",
  "api_key": "69b815c468ed589d1ec5"
}
```
#### In order to see how this mock JSON body example would work in Postman:
- Open Postman and click the `+` button in the upper right hand side
- In the text box next to the `GET` with the field `Enter URL or past text` enter in the url <your localhost>/api/v0/road_trip
- Click on the drop down button to the right of the `GET ` and select `POST`
- Select the `Body` tab, below the url
- Click the dropdown button to the right of `none` and select `raw`
- Enter the example body above in to this raw field
- You are now ready to click the Blue `Send` button and see the response


**Example response:**
```
{
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinatti,OH",
            "end_city": "Chicago,IL",
            "travel_time": "04:20:56",
            "weather_at_eta": [
                {
                    "datetime": "2024-01-17 02:00",
                    "temperature": 4.2,
                    "condition": "Clear"
                }
            ]
        }
    }
}
```
___