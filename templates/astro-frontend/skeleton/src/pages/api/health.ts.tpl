// API endpoint for health check
export async function GET() {
  return new Response(
    JSON.stringify({
      status: 'OK',
      service: '${{values.name}}',
      timestamp: new Date().toISOString(),
      version: '1.0.0'
    }),
    {
      status: 200,
      headers: {
        'Content-Type': 'application/json'
      }
    }
  );
}