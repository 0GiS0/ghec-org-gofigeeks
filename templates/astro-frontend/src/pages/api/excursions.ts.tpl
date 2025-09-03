// API endpoint for excursions management

interface Excursion {
  id: number;
  name: string;
  description: string;
  location: string;
  price: number;
  duration: number;
  maxParticipants: number;
  createdAt: string;
  updatedAt: string;
}

// In-memory storage for demonstration purposes
let excursions: Excursion[] = [
  {
    id: 1,
    name: "Mountain Hiking Adventure",
    description: "A thrilling hike through the scenic mountain trails with breathtaking views",
    location: "Rocky Mountains",
    price: 75.00,
    duration: 6,
    maxParticipants: 12,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString()
  },
  {
    id: 2,
    name: "City Food Tour",
    description: "Explore the best local cuisine and hidden food gems in the city",
    location: "Downtown",
    price: 45.00,
    duration: 3,
    maxParticipants: 8,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString()
  }
];

let nextId = 3;

function validateExcursion(data: any): string[] {
  const errors: string[] = [];
  
  if (!data.name || data.name.trim().length === 0) {
    errors.push('Name is required');
  }
  
  if (!data.location || data.location.trim().length === 0) {
    errors.push('Location is required');
  }
  
  if (!data.price || data.price <= 0) {
    errors.push('Price must be greater than 0');
  }
  
  if (!data.duration || data.duration <= 0) {
    errors.push('Duration must be greater than 0');
  }
  
  if (!data.maxParticipants || data.maxParticipants <= 0) {
    errors.push('MaxParticipants must be greater than 0');
  }
  
  return errors;
}

// GET /api/excursions - Get all excursions
export async function GET() {
  return new Response(
    JSON.stringify(excursions),
    {
      status: 200,
      headers: {
        'Content-Type': 'application/json'
      }
    }
  );
}

// POST /api/excursions - Create new excursion
export async function POST({ request }: { request: Request }) {
  try {
    const data = await request.json();
    
    const validationErrors = validateExcursion(data);
    if (validationErrors.length > 0) {
      return new Response(
        JSON.stringify({
          error: 'Validation failed',
          message: 'Request validation failed',
          details: validationErrors
        }),
        {
          status: 400,
          headers: {
            'Content-Type': 'application/json'
          }
        }
      );
    }

    const newExcursion: Excursion = {
      id: nextId++,
      name: data.name,
      description: data.description || '',
      location: data.location,
      price: data.price,
      duration: data.duration,
      maxParticipants: data.maxParticipants,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    };

    excursions.push(newExcursion);

    return new Response(
      JSON.stringify(newExcursion),
      {
        status: 201,
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );
  } catch (error) {
    return new Response(
      JSON.stringify({
        error: 'Internal server error',
        message: 'Failed to create excursion'
      }),
      {
        status: 500,
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );
  }
}