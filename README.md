# Handshake Backend

This is the backend API for the Handshake application built with Ruby on Rails.

## Setup

1. Install dependencies:
```bash
bundle install
```

2. Setup the database:
```bash
rails db:create db:migrate db:seed
```

3. Start the server:
```bash
rails server
```

## API Documentation

API documentation is available in the `postman` directory. Import the `handshake-api.postman_collection.json` file into Postman to get started.

## Project Structure

```
handshake-backend/
├── app/                    # Application code
│   ├── controllers/       # HTTP request handlers
│   ├── models/           # Database models
│   └── services/         # Business logic
├── config/               # Configuration files
├── db/                   # Database files
├── postman/             # API documentation
└── test/                # Test files
```

## Development

- Ruby version: 3.2.2
- Rails version: 8.0.2
- Database: SQLite3
