# Busin Server

Busin is a business communication app that enables teams to collaborate in real-time. This repository contains the
server-side code for the Busin app.

## Table of Contents

- [Installation](#installation)
- [Technologies Used](#technologies-used)
- [Features](#features)
- [Contributing](#contributing)
- [License](#license)

## Installation

To install the Busin server, follow these steps:

1. Clone the repository.
2. Create a mySQL database.
3. Create a nodemon.json with the following content:
```json
{
"env":{
   "MYSQL_USER": "",
   "MYSQL_PASSWORD": "",
   "MYSQL_DATABASE": "",
   "MYSQL_HOST": "",
   "MYSQL_PORT": "",
   "JWT_KEY":"" 
  }
}

```

4. Run `npm install` to install the dependencies.
5. Run `npm start` to start the server.
6. The server will be running on `http://localhost:3001` by default.

## Technologies Used

The following technologies were used to develop the Busin server:

- Node.js
- mySQL
- Socket.io

## Features

The Busin server provides the following features:

- Real-time communication using Socket.io
- User authentication and authorization
- Database management using mySQL

## Contributing

If you'd like to contribute to the Busin server, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and commit them to your branch.
4. Push your branch to your forked repository.
5. Open a pull request with a description of your changes.

## License

The Busin server is licensed under the GNU license. See `LICENSE` for more information.
