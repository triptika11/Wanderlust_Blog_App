// db.js
import mongoose from 'mongoose';
import dotenv from 'dotenv';

// Load environment variables from .env (used locally, ignored in K8s)
dotenv.config();

// Get MONGO_URI from environment
const MONGO_URI = process.env.MONGO_URI;

// Function to connect to MongoDB
export default async function connectDB() {
  try {
    if (!MONGO_URI) {
      throw new Error('❌ MONGO_URI is undefined. Check your environment variables.');
    }

    await mongoose.connect(MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });

    console.log(`✅ Database connected: ${MONGO_URI}`);
  } catch (err) {
    console.error('❌ MongoDB connection error:', err.message);
    process.exit(1); // Exit process if DB connection fails
  }

  // Optional: listen for disconnects or errors
  mongoose.connection.on('disconnected', () => {
    console.warn('⚠️ MongoDB disconnected.');
  });

  mongoose.connection.on('error', (err) => {
    console.error('❌ MongoDB error:', err.message);
  });
}

