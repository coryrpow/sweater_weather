# sweater_weather

## Project Description


You are a back-end developer working on a team that is building an application to plan road trips. This app will allow users to see the current weather as well as the forecasted weather at the destination.

Your team is working in a service-oriented architecture. The front-end will communicate with your back-end through an API. Your job is to expose that API that satisfies the front-end team’s requirements.

## Learning Goals

- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

## Requirements

This repo utilized multiple APIs and requires that the developer using this repo obtain their own keys and permissions from them accordingly.

[Mapquest API](https://developer.mapquest.com/documentation)
[Weather API](https://www.weatherapi.com)

To run this test suite, please obtain API keys to the above APIs and add them to the Rails Credentials file using the `EDITOR="code --wait" rails credentials:edit` command.

Once those have been added, you can run the whole test suite with: bundle exec rspec

## Installation Instructions

 - Fork Repository
 - `git clone <repo_name>`
 - `cd <repo_name>`
 - `bundle install`   
 - `rails db:{drop,create,migrate,seed}`
 - `rails server` 

## API Documentation

Response title

get "response"

example response:


