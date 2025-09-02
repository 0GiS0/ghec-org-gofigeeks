// API endpoint for individual excursion operations

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
// Note: In a real application, this would be shared with the main excursions endpoint
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

// GET /api/excursions/[id] - Get excursion by ID
export async function GET({ params }: { params: { id: string } }) {
  const id = parseInt(params.id);
  
  if (isNaN(id)) {
    return new Response(
      JSON.stringify({
        error: 'Bad request',
        message: 'Invalid excursion ID'
      }),
      {
        status: 400,
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );
  }

  const excursion = excursions.find(e => e.id === id);
  
  if (!excursion) {
    return new Response(
      JSON.stringify({
        error: 'Not found',
        message: `Excursion with id ${id} not found`
      }),
      {
        status: 404,
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );
  }

  return new Response(
    JSON.stringify(excursion),
    {
      status: 200,
      headers: {
        'Content-Type': 'application/json'
      }
    }
  );
}

// PUT /api/excursions/[id] - Update excursion
export async function PUT({ params, request }: { params: { id: string }, request: Request }) {
  try {
    const id = parseInt(params.id);
    
    if (isNaN(id)) {
      return new Response(
        JSON.stringify({
          error: 'Bad request',
          message: 'Invalid excursion ID'
        }),
        {
          status: 400,
          headers: {
            'Content-Type': 'application/json'
          }
        }
      );
    }

    const excursionIndex = excursions.findIndex(e => e.id === id);
    
    if (excursionIndex === -1) {
      return new Response(
        JSON.stringify({
          error: 'Not found',
          message: `Excursion with id ${id} not found`
        }),
        {
          status: 404,
          headers: {
            'Content-Type': 'application/json'
          }
        }
      );
    }

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

    const excursion = excursions[excursionIndex];
    excursion.name = data.name;
    excursion.description = data.description || '';
    excursion.location = data.location;
    excursion.price = data.price;
    excursion.duration = data.duration;
    excursion.maxParticipants = data.maxParticipants;
    excursion.updatedAt = new Date().toISOString();

    return new Response(
      JSON.stringify(excursion),
      {
        status: 200,
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );
  } catch (error) {
    return new Response(
      JSON.stringify({
        error: 'Internal server error',
        message: 'Failed to update excursion'
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

// DELETE /api/excursions/[id] - Delete excursion
export async function DELETE({ params }: { params: { id: string } }) {
  const id = parseInt(params.id);
  
  if (isNaN(id)) {
    return new Response(
      JSON.stringify({
        error: 'Bad request',
        message: 'Invalid excursion ID'
      }),
      {
        status: 400,
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );
  }

  const excursionIndex = excursions.findIndex(e => e.id === id);
  
  if (excursionIndex === -1) {
    return new Response(
      JSON.stringify({
        error: 'Not found',
        message: `Excursion with id ${id} not found`
      }),
      {
        status: 404,
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );
  }

  excursions.splice(excursionIndex, 1);

  return new Response(null, {
    status: 204
  });
}