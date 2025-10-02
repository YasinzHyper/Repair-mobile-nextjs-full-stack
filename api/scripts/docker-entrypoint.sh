#!/bin/sh
set -e

echo "🚀 Starting Fix My Phone API..."

# Function to check if PostgreSQL is ready
wait_for_postgres() {
    echo "⏳ Waiting for PostgreSQL database connection..."
    
    while ! npx prisma db push --accept-data-loss --force-reset 2>/dev/null; do
        echo "Database is unavailable - sleeping for 2 seconds"
        sleep 2
    done
    
    echo "✅ Database is ready!"
}

# Function to setup database
setup_database() {
    echo "🔄 Setting up database..."
    
    # Generate Prisma client
    echo "🔄 Generating Prisma client..."
    npx prisma generate
    
    # Push database schema (development mode)
    echo "🔄 Pushing database schema..."
    npx prisma db push --accept-data-loss
    
    echo "✅ Database setup completed!"
}

# Wait for database
wait_for_postgres

# Setup database
setup_database

echo "🎉 Starting the application..."
exec "$@"