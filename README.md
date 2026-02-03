# Gym Workout Tracker

A full-stack web application for tracking gym workouts with user authentication and workout logging capabilities.

## Features

- **User Authentication**: Secure user registration and login with JWT tokens
- **Workout Logging**: Log workouts with details like exercise name, sets, reps, weight, duration, and notes
- **Workout History**: View all your logged workouts with dates
- **CRUD Operations**: Create, read, update, and delete workout entries
- **Responsive Design**: Clean and modern UI that works on all devices

## Technology Stack

### Backend
- Node.js
- Express.js
- SQLite (database)
- JWT (authentication)
- bcryptjs (password hashing)

### Frontend
- HTML5
- CSS3
- Vanilla JavaScript
- RESTful API integration

## Installation

1. Clone the repository:
```bash
git clone https://github.com/Splashdamage115/gym-workout-tracker.git
cd gym-workout-tracker
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
```bash
cp .env.example .env
# Edit .env and set your JWT_SECRET
```

4. Start the server:
```bash
npm start
```

For development with auto-reload:
```bash
npm run dev
```

5. Open your browser and navigate to:
```
http://localhost:3000
```

## API Endpoints

### Authentication

#### Register
- **POST** `/api/auth/register`
- Body: `{ "username": "string", "email": "string", "password": "string" }`

#### Login
- **POST** `/api/auth/login`
- Body: `{ "username": "string", "password": "string" }`
- Returns: JWT token

### Workouts (All require authentication)

#### Create Workout
- **POST** `/api/workouts`
- Headers: `Authorization: Bearer <token>`
- Body: 
```json
{
  "exercise_name": "string",
  "sets": number,
  "reps": number,
  "weight": number,
  "duration": number,
  "notes": "string",
  "workout_date": "ISO date string"
}
```

#### Get All Workouts
- **GET** `/api/workouts`
- Headers: `Authorization: Bearer <token>`
- Query params: `limit` (default: 50), `offset` (default: 0)

#### Get Single Workout
- **GET** `/api/workouts/:id`
- Headers: `Authorization: Bearer <token>`

#### Update Workout
- **PUT** `/api/workouts/:id`
- Headers: `Authorization: Bearer <token>`
- Body: Any workout fields to update

#### Delete Workout
- **DELETE** `/api/workouts/:id`
- Headers: `Authorization: Bearer <token>`

## Usage

1. **Register an Account**: Click "Register here" on the login page and create a new account
2. **Login**: Use your credentials to login
3. **Log a Workout**: Fill in the workout form with exercise details and click "Log Workout"
4. **View Workouts**: Your logged workouts appear below the form in chronological order
5. **Delete Workouts**: Click the "Delete" button on any workout card to remove it

## Project Structure

```
gym-workout-tracker/
├── public/              # Frontend files
│   ├── index.html      # Main HTML file
│   ├── styles.css      # Styling
│   └── app.js          # Frontend JavaScript
├── routes/             # API routes
│   ├── auth.js         # Authentication routes
│   └── workouts.js     # Workout routes
├── middleware/         # Express middleware
│   └── auth.js         # JWT authentication middleware
├── database.js         # Database setup and configuration
├── server.js           # Main server file
├── package.json        # Dependencies
└── .env               # Environment variables

```

## Security Features

- Passwords are hashed using bcrypt
- JWT tokens for secure authentication
- Protected API endpoints
- SQL injection prevention through parameterized queries
- CORS enabled for cross-origin requests

## License

ISC