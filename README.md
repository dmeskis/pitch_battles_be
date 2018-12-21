# README

## Endpoints

This API uses JSON Web Tokens (JWT) to authenticate user requests. Every request below EXCEPT for:  
1. POST /api/v1/users
2. POST /login  

require a header to be sent with a users JWT.

The format for the header is as follows:  
```
'AUTHORIZATION': 'bearer <JWT KEY>'
```
It will look like the following
```
'AUTHORIZATION': 'bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE1NDUzNjE4MDV9.srji4gnQkcqpIV0ZJ96-JzquhHuMUDrgkFvJcFzws00'
```
### Games

* `GET /api/v1/games/:id` returns a single game by ID  

Example response:
```
{
  "data": {
         "id": "1",
         "type": "game",
         "attributes", {
                        "total_duration": "15000",
                        "level_one_duration": "2000",
                        "level_two_duration": "3000",
                        "level_three_duration": "5000",
                        "level_four_duration": "5000",
                        "remaining_lives": "2"
                        }
          }
}
   ```

* `POST /api/v1/games` creates and saves a game to the database
  * required body parameters: `{email, total_duration, remaining_lives}`
  * optional body parameters: `{level_one_duration, level_two_duration, level_three_duration, level_four_duration}`  
  
Example request:

```
{
  total_duration: 15000,
  level_one_duration: 3000,
  level_two_duration: 3000,
  level_three_duration: 6000,
  level_four_duration: 3000,
  remaining_life: 2,
  user_id: 1
}
```
Example response:
```
{
  "data": {
         "id": "1",
         "type": "game",
         "attributes", {
                        "total_duration": "15000",
                        "level_one_duration": "2000",
                        "level_two_duration": "3000",
                        "level_three_duration": "5000",
                        "level_four_duration": "5000",
                        "remaining_lives": "2"
                        }
          }
}
```
* `GET /api/v1/users/:id/games` returns all users games  

Example response:
```
{
 "data"=>
        {
          "id"=>"955",
           "type"=>"user",
           "attributes"=>
                        {
                          "email"=>"tashaoconnell@hahn.org",
                           "first_name"=>"Ludivina",
                           "last_name"=>"Klocko",
                           "games"=>
                                    {
                                      "data"=>
                                               [
                                                {
                                                  "id"=>"404",
                                                  "type"=>"game",
                                                  "attributes"=>
                                                                 {
                                                                   "total_duration"=>15625,
                                                                    "level_one_duration"=>54614,
                                                                    "level_two_duration"=>31979,
                                                                    "level_three_duration"=>45556,
                                                                    "level_four_duration"=>83746,
                                                                    "remaining_life"=>0
                                                                   }
                                                 },
                                                 {
                                                  "id"=>"405",
                                                  "type"=>"game",
                                                  "attributes"=>
                                                                   {
                                                                   "total_duration"=>22371,
                                                                    "level_one_duration"=>65052,
                                                                    "level_two_duration"=>66644,
                                                                    "level_three_duration"=>35020,
                                                                    "level_four_duration"=>67001,
                                                                    "remaining_life"=>3
                                                                    }
                                                  }
                                                 ]
                                       }
                           }
           }
}
```
### Users

* `POST /api/v1/users` creates a user
  * required body parameters: `{email, first_name, last_name, role, password, password_confirmation}`  
  
Example request:

```
{              
  email: "example@mail.com",
  first_name: "billy",
  last_name: "bob",
  role: 0,
  password: "password",
  password_confirmation: "password"
}
```
Example response:
``` 
{
 “success”: “Account successfully created!”
}
```

* `POST /login` logs in a user
  * required body parameters: `{email, password}`  
  
Example request:

```
{              
  email: "example@mail.com",
  password: "password"
}
```
Example response:
``` 
{
  "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE1NDUzNjE4MDV9.srji4gnQkcqpIV0ZJ96-JzquhHuMUDrgkFvJcFzws00",
  "message": "Login Successful"
}
```


* `GET /api/v1/users/:id` returns a specific users data  

Example response:
```
{
  "data": {
           "id": "1",
           "type": "user",
           "attributes": {
                          “email”: “example@mail.com”,
                          “first_name”: “billy”,
                          “last_name”: “bob”,
                          “role”: 0
                          }
          }
}
```

* `PATCH /api/v1/users/:id` updates a user's attributes
  * required body parameters: `{current_password}`
  * optional body parameters: `{email, first_name, last_name, new_password}`  
  
Example request:

```
{              
  email: "example@mail.com",
  first_name: "john",
  last_name: "legend",
  password: "new_password",
  current_password: "password"
}
``` 
Example response:
``` 
{
 “success”: “Account successfully updated”
}
```

### Badges

* `GET /api/v1/users/:id/badges` returns all of a users badges  

Example response:
```
{
 "data"=>
        {
         "id"=>"237",
         "type"=>"user",
         "attributes"=>
                      {
                       "email"=>"beau@conn.io",
                       "first_name"=>"Kristian",
                       "last_name"=>"Volkman",
                       "badges"=>{
                                   "data"=>[
                                           {
                                           "id"=>"27", 
                                           "type"=>"badge", 
                                           "attributes"=>{
                                                           "name"=>"Master", 
                                                           "description"=>"That's gotta sting."}
                                                           }
                                           ]
                                   }
                       }
         }
}
```
