# Communication Contract

### Requesting Data

Requesting data is done through an HTTP request. The path of the request is used
to specify an action with the request:

POST Requests:
- `/auth`: Body must be a JSON object with a "username" and "password" field.

#### Example Request

```
await fetch("http://localhost:3001/auth", {
    method: "POST",
    body: JSON.stringify({
       username: <username>,
       password: <password>
    }),
    headers: {"Content-Type: "application/json"}
});
```

### Receiving Data

The server will send back a JSON object containing 
```
"userInfo" : [Object], //'undefined' on fail; otherwise username, firstname, lastname, email
"userID": integer, //-1 on fail, otherwise 0-n
"message": string
```

#### Example Receive

```
await fetch('http://localhost:3001/auth',
    {
        method: 'POST',
        body: JSON.stringify({
            username: _username,
            password: _password
        }),
        headers: {
            'Content-type':
                'application/json; charset=UTF-8',
        },
    })
    .then(
        (response) => {
            const loginResult = response.json();
            console.log(json);
            if (loginResult.userID == -1) {
                console.info("Login failed!")
                console.error(loginResult.message)
            }
            else {
                request.session.loggedin = true;
                request.session.user = [loginResult.userInfo];
                request.session.username = loginResult.userInfo.username;
                console.info("Login success! Welcome "+loginResult.userInfo.username);
            }
        }
    )
```

### Debug/direct access routes
GET Requests:
- `/`: No request body, session information (cookies) are read out to the console.
- `/login`: Displays a test page with a login form that will call /auth when submitted.
- `/logout`: No request body, session information (cookies) are modified.
- `/reset-database`: Resets the database using the defined stored procedure.

### UML Sequence Diagram

<img src="./static/umlSequence.jpg" alt="UML sequence diagram">
