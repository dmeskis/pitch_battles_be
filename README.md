# README

## Endpoints

### Games

* `GET /api/v1/game/:id` returns a single game by ID
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
                          “role”: “student”,
                          “badges”: {
                                     “level_1_badge”: “true”,
                                     “level_2_badge”: “false”,
                                      etc. etc.
                                    }
                          }
          }
}
```

* `PATCH /api/v1/users/:id` updates a user's attributes
  * required body parameters: `{current_password}`
  * optional body parameters: `{email, first_name, last_name, new_password}`
Example response:
``` 
{
 “success”: “Account successfully updated”
}
```

* `POST /api/v1/users` creates a user
  * required body parameters: `{email, first_name, last_name, role, password, password_confirmation}`
Example response:
``` 
{
 “success”: “Account successfully created!”
}
```
