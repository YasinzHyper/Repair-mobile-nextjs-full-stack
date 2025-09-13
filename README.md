<div align="center">
  <img src="https://res.cloudinary.com/dg8dkpulv/image/upload/v1701016109/fixmyphone3_crop_qksmvn.png" alt="logo" width="200" height="auto" />
  <h1>Fix My Phone</h1>
  <p>
    A comprehensive full-stack mobile device repair management platform built with Next.js and Express.js
  </p>
  
  <p>
    <a href="https://fix-my-phone-ujjalzaman.vercel.app/">🌐 Live Demo</a>
    •
    <a href="https://youtu.be/IRuWuqt7yOs">🎬 Video Demo</a>
    •
    <a href="https://ujjalzaman-b6c8a.web.app/">👤 Portfolio</a>
  </p>
</div>

---

## 🚀 Quick Start with Docker

Get the entire application running in **under 3 minutes** with Docker:

### Prerequisites
- [Docker](https://www.docker.com/get-started) & Docker Compose
- [Git](https://git-scm.com/)

### 1️⃣ Clone and Setup
```bash
git clone https://github.com/Ujjalzaman/Repair-mobile-nextjs-full-stack.git
cd Repair-mobile-nextjs-full-stack
```

```bash
cp .env.example .env
```

### 2️⃣ Configure Services (Optional)
Edit `.env` file with your credentials

### 3️⃣ Launch Application
```bash
# Start everything (production mode)
docker-compose up --build

# OR start in development mode with hot reload
docker-compose -f docker-compose.dev.yml up --build
```

### 🌐 Access Your Application
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:5051  
- **Database**: localhost:5432

### 🛠️ Useful Commands
```bash
# View logs
docker-compose logs -f

# Stop everything
docker-compose down

# Database management
docker-compose exec api npx prisma studio

# Health check
curl http://localhost:5051/api/v1/health
```

---

## 📋 Table of Contents

- [About the Project](#-about-the-project)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Screenshots](#-screenshots)
- [Manual Installation](#-manual-installation)
- [Architecture](#-architecture)
- [Contributing](#-contributing)
- [Contact](#-contact)

---

## 🎯 About the Project

Fix My Phone is a comprehensive solution for managing mobile device repairs. It provides tools for customers to request services, track repairs, and make payments, while giving admins powerful tools to manage service requests, appointments, technicians, and customer accounts.

### Key Benefits
- ✅ **Complete Mobile Repair Workflow**
- ✅ **Real-time Service Tracking**
- ✅ **Secure Payment Processing**
- ✅ **Admin Dashboard & Analytics**
- ✅ **Multi-role User Management**
- ✅ **Docker Containerized Deployment**

---

## ✨ Features

### 👥 Customer Features
- **Service Requests** - Submit repair requests with device details
- **Appointment Booking** - Schedule repair appointments
- **Order Tracking** - Real-time repair status updates
- **Payment Processing** - Secure online payments via Stripe
- **Order History** - View past repairs and invoices
- **Profile Management** - Update personal information
- **Notifications** - Receive repair status updates

### 🔧 Admin Features
- **Service Management** - View and manage repair requests
- **Appointment Scheduling** - Manage appointment schedules
- **Technician Management** - Assign technicians and manage workloads
- **Payment Verification** - Process and verify payments
- **Customer Management** - Manage customer accounts
- **Analytics & Reporting** - Performance metrics and reports
- **Communication Tools** - Update customers on repair progress

### 👑 Super Admin Features
- **User Role Management** - Create and manage admin accounts
- **System Administration** - Full access to all functionality
- **Advanced Analytics** - Comprehensive system reports

---

## 🛠️ Tech Stack

### Frontend
- **Framework**: Next.js 13+ with TypeScript
- **UI Library**: Ant Design
- **State Management**: Redux Toolkit
- **Forms**: React Hook Form
- **Charts**: Chart.js
- **Styling**: CSS Modules
- **HTTP Client**: Axios

### Backend
- **Framework**: Express.js with TypeScript
- **Database**: PostgreSQL with Prisma ORM
- **Authentication**: JWT Tokens
- **File Upload**: Multer + Cloudinary
- **Payments**: Stripe API
- **Validation**: Zod
- **Security**: bcrypt, CORS

### DevOps & Deployment
- **Containerization**: Docker & Docker Compose
- **Database**: PostgreSQL 15
- **Reverse Proxy**: Nginx (production)
- **Cloud Storage**: Cloudinary
- **Payment Gateway**: Stripe

---

## 📸 Screenshots

<div align="center">
  <img src="https://res.cloudinary.com/dg8dkpulv/image/upload/v1701016100/home_page_1_gjbopl.png" alt="Homepage" width="400" />
  <img src="https://res.cloudinary.com/dg8dkpulv/image/upload/v1701016094/appointment_wi8vvc.png" alt="Appointment" width="400" />
  <img src="https://res.cloudinary.com/dg8dkpulv/image/upload/v1701016090/Dashboard_oaeh2j.png" alt="Dashboard" width="400" />
  <img src="https://res.cloudinary.com/dg8dkpulv/image/upload/v1701016107/screencapture-fix-my-phone-ujjalzaman-vercel-app-blog-2023-11-25-22_02_02_h61aph.png" alt="Blog" width="400" />
</div>

---

## 💻 Manual Installation

If you prefer to run without Docker:

### Prerequisites
- Node.js 20+
- PostgreSQL 12+
- npm or yarn

### Backend Setup
```bash
cd api
npm install

# Create .env file
cat > .env << EOF
DATABASE_URL=postgresql://username:password@localhost:5432/fixmyphone
NODE_ENV=development
PORT=5051
JWT_SECRET=your-secret-key
JWT_EXPIRED_IN=30d
JWT_REFRESH_SECRET=your-refresh-secret
JWT_SECRET_SALT_ROUND=12
CLOUD_NAME=your-cloudinary-name
API_KEY=your-cloudinary-key
API_SECRET=your-cloudinary-secret
STRIPE_SECRET_KEY=sk_test_your-key
EOF

# Setup database
npx prisma migrate dev
npx prisma generate

# Start development server
npm run dev
```

### Frontend Setup
```bash
cd client
npm install

# Create .env.local file
cat > .env.local << EOF
NEXT_PUBLIC_API_BASE_URL=http://localhost:5051/api/v1
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_your-key
EOF

# Start development server
npm run dev
```

---

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Next.js App  │    │   Express API   │    │  PostgreSQL DB  │
│   (Frontend)    │◄──►│   (Backend)     │◄──►│   (Database)    │
│   Port: 3000    │    │   Port: 5051    │    │   Port: 5432    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
    ┌────▼────┐             ┌────▼────┐             ┌────▼────┐
    │  Ant    │             │ Prisma  │             │ Docker  │
    │ Design  │             │   ORM   │             │ Volume  │
    └─────────┘             └─────────┘             └─────────┘
         │                       │
    ┌────▼────┐             ┌────▼────┐
    │ Stripe  │             │Cloudinary│
    │ Payment │             │ Storage │
    └─────────┘             └─────────┘
```

### Project Structure
```
.
├── api/                    # Backend Express.js app
│   ├── src/
│   │   ├── app/
│   │   │   ├── modules/    # Feature modules
│   │   │   ├── middlewares/# Auth & validation
│   │   │   └── routes/     # API routes
│   │   ├── config/         # Configuration
│   │   └── shared/         # Utilities
│   └── prisma/             # Database schema
├── client/                 # Frontend Next.js app
│   └── src/
│       ├── app/            # Next.js 13+ app directory
│       ├── components/     # React components
│       ├── redux/          # State management
│       └── helpers/        # Utilities
├── nginx/                  # Reverse proxy config
├── database/               # DB initialization
├── docker-compose.yml      # Production setup
├── docker-compose.dev.yml  # Development setup
└── .env.example            # Environment template
```

---

## 🤝 Contributing

Contributions are welcome! Here's how to get started:

1. **Fork the repository**
2. **Clone your fork**
   ```bash
   git clone https://github.com/your-username/Repair-mobile-nextjs-full-stack.git
   ```
3. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
4. **Make your changes**
5. **Test thoroughly** (both Docker and manual setups)
6. **Commit your changes**
   ```bash
   git commit -m 'Add amazing feature'
   ```
7. **Push to your branch**
   ```bash
   git push origin feature/amazing-feature
   ```
8. **Open a Pull Request**

### Development Guidelines
- Follow TypeScript best practices
- Write meaningful commit messages
- Test your changes with Docker
- Update documentation if needed

---

## 📞 Contact

**Ujjal Zaman**
- 🌐 Portfolio: [ujjalzaman-b6c8a.web.app](https://ujjalzaman-b6c8a.web.app/)
- 💼 LinkedIn: [linkedin.com/in/ujjal-zaman](https://www.linkedin.com/in/ujjal-zaman)
- 📧 Email: ujjalzaman@gmail.com

---

<div align="center">
  <p>⭐ Star this repository if you found it helpful!</p>
  <p>Built with ❤️ by <a href="https://ujjalzaman-b6c8a.web.app/">Ujjal Zaman</a></p>
</div>
