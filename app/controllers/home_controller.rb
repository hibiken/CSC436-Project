class HomeController < ApplicationController

  ROOT_URL = 'https://csc436-project.herokuapp.com'
  def show
    @api_details = [
      { endpoint: '/api/users',
        method: 'POST',
        example: "#{ROOT_URL}/api/users",
        json: %Q<
        { "user": { 
          "first_name": "Ken", 
          "last_name": "Hibino",
          "email": "ken@example.com",
          "password" : "userspassword",
          "password_confirmation": "userspassword"
          }
        }
        >,
        description: 'This endpoint for user to sign up/create an account'
    },
      { endpoint: '/api/sessions',
        method: 'POST',
        example: "#{ROOT_URL}/api/sessions",
        json: %Q<
        REQUEST BODY

        { "session": { 
          "email": "ken@example.com", 
          "password": "userspassword"
          }
        }

        RESPONSE

        {
          "user": {
            "id": 3,
            "first_name": "example",
            "last_name": "user",
            "full_name": "example user",
            "email": "example@user.com",
            "member_since": "2016-03-03T17:02:16.966Z"
          },
          "meta": {
            "auth_token": "f8eaacc2620e8f9fe64a51f925373895"
          }
        }
        >,
        description: 'This endpoint for user to sign up/create an account'
    },
    {
      endpoint: '/api/users',
      method: 'GET',
      example: "#{ROOT_URL}/api/users",
      json: %Q<
      { users: [
        {
          id: 1,
          first_name: "Ken",
          last_name: "Hibino",
          full_name: "Ken Hibino",
          email: "kenhibino@example.com",
          member_since: "2016-03-01T16:14:54.396Z"
        },
        {
          id: 2,
          first_name: "Kentaro",
          last_name: "Hibino",
          full_name: "Kentaro Hibino",
          email: "kenhibino7@gmail.com",
          member_since: "2016-03-01T16:26:00.541Z"
        }
      ]
    }
      >,
      description: "Fetch all user records"
    },
    { endpoint: '/api/users/:id',
      method: 'GET',
      example: "#{ROOT_URL}/api/users/1",
      json: %Q<
      {
        user: {
          id: 1,
          first_name: "Ken",
          last_name: "Hibino",
          full_name: "Ken Hibino",
          email: "kenhibino@example.com",
          member_since: "2016-03-01T16:14:54.396Z"
        }
      }
      >,
        description: 'Fetch one user record specified with id'
    },
    { endpoint: '/api/users/:id',
      method: 'PUT/PATCH',
      example: "#{ROOT_URL}/api/users/1",
      json: %Q<
      { "user": { 
        "first_name": "Ken", 
        "last_name": "Hibino",
        "email": "ken@example.com",
        "password" : "userspassword",
        "password_confirmation": "userspassword"
        }
      }
      >,
        description: 'Updates user\'s record specified with id'
    },
    {
      endpoint: '/api/posts',
      method: 'GET',
      example: "#{ROOT_URL}/api/posts",
      json: %Q<
      {
        posts: [
          {
            id: 1,
            title: "Testing API",
            content: "some content",
            user_id: 1,
            created_at: "2016-03-01T16:17:31.869Z",
            updated_at: "2016-03-01T16:17:31.869Z"
          },
          {
            id: 2,
            title: "some title",
            content: "some cool content",
            user_id: 2,
            created_at: "2016-03-01T16:26:55.556Z",
            updated_at: "2016-03-01T16:26:55.556Z"
          }
        ]
      }
      >,
      description: "Fetch all posts records"
    },
    { endpoint: '/api/users/:user_id/posts',
      method: 'POST',
      example: "#{ROOT_URL}/api/users/1/posts",
      json: %Q<
      { "post": { 
          "title": "Cool title for my post", 
          "content": "some cool content...."
         }
      }
      >,
      description: "Signed in user create a new post"
    },
    { endpoint: '/api/users/:user_id/posts/:id',
      method: 'GET',
      example: "#{ROOT_URL}/api/users/1/posts/1",
      json: %Q<
      { "post": { 
          "title": "Cool title for my post", 
          "content": "some cool content...."
         }
      }
      >,
      description: "Fetch one post record specified with id, required signed in user(Authentication field in the header)"
    },

    ]
  end
end
