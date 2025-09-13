-- Database initialization script for Fix My Phone
-- This script runs when the PostgreSQL container starts

-- Create the database if it doesn't exist
SELECT 'CREATE DATABASE fixmyphone' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'fixmyphone')\gexec

-- Set up database permissions
GRANT ALL PRIVILEGES ON DATABASE fixmyphone TO fixmyphone_user;

-- Connect to the fixmyphone database
\c fixmyphone;

-- Enable UUID extension for generating UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Grant necessary permissions to the user
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO fixmyphone_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO fixmyphone_user;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO fixmyphone_user;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO fixmyphone_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO fixmyphone_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO fixmyphone_user;
