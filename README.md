![Pitch Battles API Logo](https://i.imgur.com/PsSM70j.png)

# Pitch Battles API [![CircleCI](https://circleci.com/gh/dmeskis/pitch_battles_be.svg?style=svg)](https://circleci.com/gh/dmeskis/pitch_battles_be)

Pitch Battles API is the back-end application handling data and authorization for [Pitch Battles](https://github.com/relasine/pitch-battles-frontend).

### Table of Contents  
- [Authorization](#authorization)
- [Endpoints](#endpoints)
  * [Games](#games)  
        - [`POST /api/v1/games`](#-post-apiv1games-creates-and-saves-a-game-to-the-database)  
        - [`GET /api/v1/games/:id`](#-get-apiv1gamesid-returns-a-single-game-by-id)  
        - [`GET /api/v1/users/:id/games`](#-get-apiv1usersidgames-returns-all-users-games)
  * [Users](#users)  
        - [`POST /api/v1/users`](#-post-apiv1users-creates-a-user)  
        - [`POST /login`](#-post-login-logs-in-a-user)  
        - [`GET /api/v1/dashboard`](#-get-apiv1dashboard-returns-the-logged-in-users-data-bearer-of-jwt)  
        - [`GET /api/v1/users/:id`](#-get-apiv1usersid-returns-a-specific-users-data)  
        - [`PATCH /api/v1/users`](#-patch-apiv1users-updates-a-users-attributes)  
  * [Password Reset](#password-reset)  
        - [`POST /password/forgot`](#-post-passwordforgot-sends-an-email-to-the-user-with-a-reset-password-token)  
        - [`POST /password/reset`](#-post-passwordreset-resets-the-users-password)
  * [Badges](#badges)  
        - [`GET /api/v1/users/:id/badges`](#-get-apiv1usersidbadges-returns-all-of-a-users-badges)
  * [Classes](#classes)  
        - [`POST /api/v1/classes`](#-post-apiv1classes-creates-a-class)  
        - [`POST /api/v1/users/:id/classes`](#-post-apiv1usersidclasses-adds-a-user-to-a-class)  
        - [`DELETE /api/v1/classes/:id`](#-delete-apiv1classesid-deletes-a-class)  
        - [`DELETE /api/v1/users/:id/classes/:klass_id`](#-delete-apiv1usersidclassesklass_id-deletes-a-user-from-a-class)
        
## Authorization

This API uses JSON Web Tokens (JWT) to authenticate user requests. Every request below **EXCEPT** for:  
1. POST /api/v1/users
2. POST /login  

**REQUIRES** a header to be sent with a users JWT.

The format for the header is as follows:  
```
'AUTHORIZATION': 'bearer <JWT KEY>'
```

An example header:
```
'AUTHORIZATION': 'bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE1NDUzNjE4MDV9.srji4gnQkcqpIV0ZJ96-JzquhHuMUDrgkFvJcFzws00'
```

For more info on JWT, pease visit [https://jwt.io/introduction/](https://jwt.io/introduction/)

## Endpoints

### Games

###### * `POST /api/v1/games` creates and saves a game to the database
  * required body parameters: `{perfect_scores, times}` 
  
Example request:

```
{
    "perfect_scores": { "one": true, "two": false, "three": false, "four": false, "all": false },
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

###### * `GET /api/v1/games/:id` returns a single game by ID  

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
   
###### * `GET /api/v1/users/:id/games` returns all users games  

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

###### * `POST /api/v1/users` creates a user
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

###### * `POST /login` logs in a user
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

###### * `GET /api/v1/dashboard` returns the logged in user's data (bearer of JWT)

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
 
###### * `GET /api/v1/users/:id` returns a specific user's data  

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

###### * `PATCH /api/v1/users` updates a user's attributes
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

### Password Reset

###### * `POST /password/forgot` sends an email to the user with a reset password token
  * required body parameters: `{email}`
  
Example request:

```
{              
 "email": "example@mail.com
}
```

Example response:

```
{
 "success": 'Please check your email to reset your password.'
}
```

###### * `POST /password/reset` resets the users password
    * required body parameters: `{token, password}`
    
Example request:

```
{
 "password": "newpassword", 
 "token": "0f8f5b078e9510f32660"
}
```

Example response:

```
{
 "success": "Password successfully reset!"
}
```

### Badges

###### * `GET /api/v1/users/:id/badges` returns all of a users badges  

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

###### * `GET /api/v1/class_dashboard` gets class dashboard information for current user

Example response: 

```
{
    "data": {
        "id": "5",
        "type": "class_dashboard",
        "attributes": {
            "name": "6th Grade Orchestra",
            "class_key": "K5s5qCQfHTYYldIhDcmGQg",
            "teacher": {
                "data": {
                    "id": "6",
                    "type": "bare_user",
                    "attributes": {
                        "email": "relasine@gmail.com",
                        "first_name": "Kevin",
                        "last_name": "Simpson",
                        "avatar": 1,
                        "role": "teacher",
                        "level_one_fastest_time": 0,
                        "level_two_fastest_time": 0,
                        "level_three_fastest_time": 0,
                        "level_four_fastest_time": 0,
                        "total_games_played": 0
                    }
                }
            },
            "level_one_fastest_time": {
                "score": 9401,
                "user": {
                    "data": [
                        {
                            "id": "1",
                            "type": "bare_user",
                            "attributes": {
                                "email": "simpsonkevinjohn@gmail.com",
                                "first_name": "Chet",
                                "last_name": "Manly",
                                "avatar": 11,
                                "role": "student",
                                "level_one_fastest_time": 9401,
                                "level_two_fastest_time": 15412,
                                "level_three_fastest_time": 21217,
                                "level_four_fastest_time": 27623,
                                "total_games_played": 23
                            }
                        }
                    ]
                }
            },
            "level_two_fastest_time": {
                "score": 15412,
                "user": {
                    "data": [
                        {
                            "id": "1",
                            "type": "bare_user",
                            "attributes": {
                                "email": "simpsonkevinjohn@gmail.com",
                                "first_name": "Chet",
                                "last_name": "Manly",
                                "avatar": 11,
                                "role": "student",
                                "level_one_fastest_time": 9401,
                                "level_two_fastest_time": 15412,
                                "level_three_fastest_time": 21217,
                                "level_four_fastest_time": 27623,
                                "total_games_played": 23
                            }
                        }
                    ]
                }
            },
            "level_three_fastest_time": {
                "score": 21217,
                "user": {
                    "data": [
                        {
                            "id": "1",
                            "type": "bare_user",
                            "attributes": {
                                "email": "simpsonkevinjohn@gmail.com",
                                "first_name": "Chet",
                                "last_name": "Manly",
                                "avatar": 11,
                                "role": "student",
                                "level_one_fastest_time": 9401,
                                "level_two_fastest_time": 15412,
                                "level_three_fastest_time": 21217,
                                "level_four_fastest_time": 27623,
                                "total_games_played": 23
                            }
                        }
                    ]
                }
            },
            "level_four_fastest_time": {
                "score": 27623,
                "user": {
                    "data": [
                        {
                            "id": "1",
                            "type": "bare_user",
                            "attributes": {
                                "email": "simpsonkevinjohn@gmail.com",
                                "first_name": "Chet",
                                "last_name": "Manly",
                                "avatar": 11,
                                "role": "student",
                                "level_one_fastest_time": 9401,
                                "level_two_fastest_time": 15412,
                                "level_three_fastest_time": 21217,
                                "level_four_fastest_time": 27623,
                                "total_games_played": 23
                            }
                        }
                    ]
                }
            },
            "overall_fastest_time": {
                "score": 33333,
                "user": {
                    "data": [
                        {
                            "id": "3",
                            "type": "bare_user",
                            "attributes": {
                                "email": "dmeskis@gmail.com",
                                "first_name": "Dylan",
                                "last_name": "Meskis",
                                "avatar": 11,
                                "role": "student",
                                "level_one_fastest_time": 111535,
                                "level_two_fastest_time": 115555,
                                "level_three_fastest_time": 1234134,
                                "level_four_fastest_time": 0,
                                "total_games_played": 7
                            }
                        }
                    ]
                }
            },
            "most_games": {
                "games_played": 23,
                "user": [
                    {
                        "id": 1,
                        "email": "simpsonkevinjohn@gmail.com",
                        "first_name": "Chet",
                        "last_name": "Manly",
                        "role": "student",
                        "password_digest": "$2a$10$Klnw1KzrpnXcFlFuJSK7v.RPe.BXnDtAtRh6OdhT9QgOu5tG3O7zi",
                        "avatar": 11,
                        "created_at": "2018-12-29T20:38:01.264Z",
                        "updated_at": "2019-01-02T18:29:54.776Z",
                        "level_one_fastest_time": 9401,
                        "level_two_fastest_time": 15412,
                        "level_three_fastest_time": 21217,
                        "level_four_fastest_time": 27623,
                        "total_fastest_time": 73653,
                        "total_games_played": 23,
                        "reset_password_token": null,
                        "reset_password_sent_at": "2019-01-02T03:39:05.224Z",
                        "klass_id": 5
                    }
                ]
            },
            "most_badges": {
                "badges": 12,
                "user": []
            }
        }
    }
}
```

###### * `POST /api/v1/classes` creates a class

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

###### * `POST /api/v1/users/:id/classes` adds a user to a class

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

###### * `DELETE /api/v1/classes/:id` deletes a class
  * User **MUST** be the teacher who created the class to delete a class


Example response:

``` 
{
  "success"=>"Successfully deleted Mr. Monk's Class."
}
```

###### * `DELETE /api/v1/users/:id/classes/:klass_id` deletes a user from a class
  * User making the request **MUST** be a teacher or a student attempting to remove themselves from a class.
  
Example response: 

```
{
 "success": "Successfully removed Billy Joel from Mr. Poen's Class."
}
```

### Leaderboards

###### * `GET /api/v1/leaderboards` returns top 100 scores for each level specified by type
 * must specify which level you wish to retrieve the highscores for in the body of the request
 * valid fields: {'level_one', 'level_two', 'level_three', 'level_four', 'overall'}
 
Example request:

```
{
 "type": "level_one"
}
```

Example response: 

```
{
    "data": [
        {
            "id": "7",
            "type": "user",
            "attributes": {
                "first_name": "Sterling",
                "last_name": "Archer",
                "highscore": 8801
            }
        },
        {
            "id": "1",
            "type": "user",
            "attributes": {
                "first_name": "Chet",
                "last_name": "Manly",
                "highscore": 9401
            }
        },
        {
            "id": "5",
            "type": "user",
            "attributes": {
                "first_name": "Cyril",
                "last_name": "Figgis",
                "highscore": 11401
            }
        },
        {
            "id": "3",
            "type": "user",
            "attributes": {
                "first_name": "Dylan",
                "last_name": "Meskis",
                "highscore": 111535
            }
        }
    ]
}
```

