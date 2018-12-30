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
        "attributes": {
            "total_duration": 1000,
            "level_one_duration": 9002,
            "level_two_duration": 1000,
            "level_three_duration": 1000,
            "level_four_duration": 1000,
            "level_one_perfect": true,
            "level_two_perfect": false,
            "level_three_perfect": false,
            "level_four_perfect": false,
            "all_perfect": false
        }
    }
}
   ```

* `POST /api/v1/games` creates and saves a game to the database
  * required body parameters: `{perfectScores, "times"}` 
  
Example request:

```
{
    "perfectScores": { "one": true, "two": false, "three": false, "four": false, "all": false },
    "times": {"one": 111535, "two": 115555, "three": 1234134, "four": null, "all": null}
}
```
Example response:
```
{
    "data": {
        "id": "17",
        "type": "game",
        "attributes": {
            "total_duration": null,
            "level_one_duration": 111535,
            "level_two_duration": 115555,
            "level_three_duration": 1234134,
            "level_four_duration": null,
            "level_one_perfect": true,
            "level_two_perfect": false,
            "level_three_perfect": false,
            "level_four_perfect": false,
            "all_perfect": false
        }
    }
}
```
* `GET /api/v1/users/:id/games` returns all users games  

Example response:
```
{
    "data": {
        "id": "3",
        "type": "user",
        "attributes": {
            "email": "dmeskis@gmail.com",
            "first_name": "bob",
            "last_name": "meskis",
            "games": {
                "data": [
                    {
                        "id": "11",
                        "type": "game",
                        "attributes": {
                            "total_duration": 33333,
                            "level_one_duration": 11111,
                            "level_two_duration": 22222,
                            "level_three_duration": null,
                            "level_four_duration": null,
                            "level_one_perfect": true,
                            "level_two_perfect": true,
                            "level_three_perfect": true,
                            "level_four_perfect": true,
                            "all_perfect": true
                        }
                    },
                    {
                        "id": "12",
                        "type": "game",
                        "attributes": {
                            "total_duration": 33333,
                            "level_one_duration": 11111,
                            "level_two_duration": 22222,
                            "level_three_duration": null,
                            "level_four_duration": null,
                            "level_one_perfect": true,
                            "level_two_perfect": false,
                            "level_three_perfect": false,
                            "level_four_perfect": false,
                            "all_perfect": false
                        }
                    }
                ]
            }
        }
    }
}
```
### Users

* `GET /api/v1/dashboard` returns the logged in user's data (owner of JWT)

Example response:
```
{
    "data": {
        "id": "3",
        "type": "user",
        "attributes": {
            "email": "dmeskis@gmail.com",
            "first_name": "bob",
            "last_name": "meskis",
            "avatar": 1,
            "level_one_fastest_time": 111535,
            "level_two_fastest_time": 115555,
            "level_three_fastest_time": 1234134,
            "level_four_fastest_time": 0,
            "total_games_played": 6,
            "games": {
                "data": [
                    {
                        "id": "11",
                        "type": "game",
                        "attributes": {
                            "total_duration": 33333,
                            "level_one_duration": 11111,
                            "level_two_duration": 22222,
                            "level_three_duration": null,
                            "level_four_duration": null,
                            "level_one_perfect": true,
                            "level_two_perfect": true,
                            "level_three_perfect": true,
                            "level_four_perfect": true,
                            "all_perfect": true
                        }
                    }
                ]
            },
            "badges": {
                "data": [
                    {
                        "id": "1",
                        "type": "badge",
                        "attributes": {
                            "name": "play 5 games",
                            "description": "Play five games."
                        }
                    }
                ]
            },
            "classes": {
                "data": []
            }
        }
    }
}
 ```

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
    "access_token":       "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE1NDYxMzY3MTN9.ycGG6AF_2bnqDpuZHauBH3e2DIqq8gxjJYeHGpiVAo0",
    "message": "Login Successful",
    "user": {
        "id": 3,
        "email": "dmeskis@gmail.com",
        "first_name": "dylan",
        "last_name": "meskis",
        "avatar": 1
    }
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
            "email": "simpsonkevinjohn@gmail.com",
            "first_name": "Chet",
            "last_name": "Manly",
            "avatar": 7,
            "level_one_fastest_time": 11233,
            "level_two_fastest_time": 16612,
            "level_three_fastest_time": 22819,
            "level_four_fastest_time": 31625,
            "total_games_played": 8,
            "games": {
                "data": [
                    {
                        "id": "1",
                        "type": "game",
                        "attributes": {
                            "total_duration": 1000,
                            "level_one_duration": 9002,
                            "level_two_duration": 1000,
                            "level_three_duration": 1000,
                            "level_four_duration": 1000,
                            "level_one_perfect": true,
                            "level_two_perfect": false,
                            "level_three_perfect": false,
                            "level_four_perfect": false,
                            "all_perfect": false
                        }
                    }
                ]
            },
            "badges": {
                "data": [
                    {
                        "id": "1",
                        "type": "badge",
                        "attributes": {
                            "name": "play 5 games",
                            "description": "Play five games."
                        }
                    }
                ]
            },
            "classes": {
                "data": []
            }
        }
    }
}
```

* `PATCH /api/v1/users` updates a user's attributes
  * required body parameters: `{current_password}`
  * optional body parameters: `{email, first_name, last_name, avatar, password}`  
  
Example request:

```
{              
  first_name: "George",
  last_name: "Costanza",
  current_password: "password"
}
``` 
Example response:
``` 
{
    "data": {
        "id": "3",
        "type": "user",
        "attributes": {
            "email": "chancetherapper@gmail.com",
            "first_name": "George",
            "last_name": "Costanza",
            "avatar": 1,
            "games": {
                "data": []
            },
            "badges": {
                "data": []
            },
            "classes": {
                "data": []
            }
        }
    }
}
```

### Badges

* `GET /api/v1/users/:id/badges` returns all of a users badges  

Example response:
```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "simpsonkevinjohn@gmail.com",
            "first_name": "Chet",
            "last_name": "Manly",
            "badges": {
                "data": [
                    {
                        "id": "1",
                        "type": "badge",
                        "attributes": {
                            "name": "play 5 games",
                            "description": "Play five games."
                        }
                    },
                    {
                        "id": "2",
                        "type": "badge",
                        "attributes": {
                            "name": "level one: completed",
                            "description": "Complete level one."
                        }
                    }
                ]
            }
        }
    }
}
```

### Classes

* `POST /api/v1/classes` creates a class

Example request:

```
{
 name: "My class"
}
```
Example response:
``` 
{
  "data"=>{
            "id"=>"1",
            "type"=>"klass", 
            "attributes"=>{
                            "name"=>"My class", 
                            "class_key"=>"HHDkjl6lspdMqHghsIu8WQ"
                          }
          }
}
```

* `POST /api/v1/users/:id/classes` adds a user to a class

Example request:

```
{
 class_key: klass.class_key
}
```
Example response:
``` 
{
  "success"=>"Successfully added Granville Willms to Test Class."
}
```

* `DELETE /api/v1/classes/:id` deletes a class
  * User must be logged in and be the teacher who created the class to delete a class


Example response:
``` 
{
  "success"=>"Successfully deleted Mr. Monk's Class."
}
```

