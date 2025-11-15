# Communication Contract

### Requesting Data

To request user data via logging in, an HTTP POST request with the path `/auth`
must be send to the service with a JSON object with the username and password
of the user in the body of the request.

#### Example Request

```
const URL = "http://localhost:3001";    // assuming service is local and on
                                           port 3001 (default)
const requestBody = {
    username: <username string>,
    password: <password string>
};

var response = fetch(URL + "/auth", {
    method: "POST",
    body: JSON.stringify(requestBody),
    headers: {"Content-Type: "application/json"}
});
```

### Receiving Data

Data is received by the response of the authentication HTTP request. The data
is a JSON object in the body of the response which contains the user info in
the service database, the user ID, and a message to go with the response.

On failure, user info is undefined, user ID is -1.

On improper request, a string stating a missing username or password is reveived.

#### Example Receive

```
var response = fetch(URL + "/auth", {<request header>});
var data = response.json();

var userInfo = data.userInfo;
var userID = data.userID;
var responseMessage = data.message;
```

### Debug/direct access routes
GET Requests:
- `/`: No request body, session information (cookies) are read out to the console.
- `/login`: Displays a test page with a login form that will call /auth when submitted.
- `/logout`: No request body, session information (cookies) are modified.
- `/reset-database`: Resets the database using the defined stored procedure.

### UML Sequence Diagram

<img src="static/umlSequence.jpg" alt="UML sequence diagram">
