# ${{values.name}}

${{values.description}}

## 🚀 Quick Start

### Prerequisites

- Node.js 18 or higher
- npm or yarn

### Development

1. **Install dependencies:**

   ```bash
   npm install
   ```

2. **Start development server:**

   ```bash
   npm run dev
   ```

3. **Run tests:**

   ```bash
   npm test
   ```

4. **Check code quality:**
   ```bash
   npm run lint
   ```

### API Endpoints

- `GET /health` - Health check endpoint
- `GET /api/hello` - Hello world endpoint
- `GET /api/status` - Service status endpoint

### Environment Variables

Create a `.env` file in the root directory:

```env
PORT=3000
NODE_ENV=development
```

### Docker Development

This project includes a dev container configuration. Open in VS Code and use "Dev Containers: Reopen in Container".

### Production Deployment

```bash
npm start
```

## 📚 Documentation (MkDocs)

Project documentation lives in `docs/` and is published using MkDocs Material.

### Install documentation dependencies

```bash
pip install -r requirements-docs.txt
```

### Serve locally

```bash
npm run docs:serve
```

Open: http://localhost:8000

### Build static site

```bash
npm run docs:build
```

Output is generated in `site/`.

### Suggested structure

```
docs/
  index.md
  guide/quickstart.md
  architecture/overview.md
  architecture/adr/
  api/index.md
  operations/local.md
  operations/observability.md
  reference/index.md
```

Keep this content up to date as part of your Definition of Done.

## 📝 Architecture

This is a simple Express.js service with:

- Express.js web framework
- CORS and Helmet for security
- Environment variable configuration
- Health check endpoints
- Error handling middleware
- Jest for testing
- ESLint for code quality

## 🧪 Testing

Run the test suite:

```bash
npm test
```

Watch mode for development:

```bash
npm run test:watch
```

## 📦 Dependencies

- **express**: Web framework
- **cors**: Cross-origin resource sharing
- **helmet**: Security middleware
- **dotenv**: Environment variable management

## 🛠️ Development Dependencies

- **nodemon**: Development server with hot reload
- **jest**: Testing framework
- **eslint**: Code linting
- **supertest**: HTTP testing library
