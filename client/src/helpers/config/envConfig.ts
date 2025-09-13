const url: string = process.env.NODE_ENV === "development" 
    ? process.env.NEXT_PUBLIC_API_BASE_URL || "http://localhost:5051/api/v1" 
    : process.env.NEXT_PUBLIC_API_BASE_URL || 'https://fix-my-phone-backend.vercel.app/api/v1';

export const getBaseUrl = (): string => {
    return url;
}