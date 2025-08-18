# Development

This document outlines the development guidelines and workflows for **$${parameters.name}**.

## Development Environment

### Setup

Follow the [Getting Started](getting-started.md) guide to set up your development environment.

### Code Style

This project follows our organization's coding standards:

- Use consistent formatting and linting tools
- Follow language-specific best practices
- Write meaningful commit messages
- Add documentation for new features

### Workflow

1. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes:**
   - Write code following the project's style guidelines
   - Add or update tests as needed
   - Update documentation if necessary

3. **Test your changes:**
   Run the project's test suite to ensure your changes don't break existing functionality.

4. **Commit your changes:**
   ```bash
   git add .
   git commit -m "feat: add new feature description"
   ```

5. **Push and create a pull request:**
   ```bash
   git push origin feature/your-feature-name
   ```

## Testing

### Running Tests

```bash
# Run all tests
npm test  # or the appropriate command for your project

# Run tests in watch mode
npm run test:watch

# Run specific test files
npm test -- path/to/test/file
```

### Writing Tests

- Write unit tests for new functionality
- Include integration tests for complex features
- Maintain good test coverage
- Follow the existing test patterns in the codebase

## Code Quality

### Linting

Run the linter to check code style:

```bash
npm run lint  # or the appropriate command for your project
```

### Type Checking

If your project uses TypeScript or similar:

```bash
npm run type-check
```

## Debugging

### Local Debugging

- Use your IDE's debugging capabilities
- Add console logs for troubleshooting
- Use the appropriate debugging tools for your runtime

### Environment Variables

Make sure your `.env` file is properly configured for development:

```env
NODE_ENV=development
DEBUG=true
LOG_LEVEL=debug
```

## Common Development Tasks

### Adding a New Feature

1. Create a feature branch
2. Implement the feature with tests
3. Update documentation
4. Submit a pull request

### Fixing a Bug

1. Create a bugfix branch
2. Write a test that reproduces the bug
3. Fix the bug
4. Verify the test passes
5. Submit a pull request

### Updating Dependencies

1. Update package files
2. Test thoroughly
3. Update documentation if needed
4. Submit a pull request

## Best Practices

- Keep commits small and focused
- Write descriptive commit messages
- Review your own code before submitting PRs
- Test thoroughly on different environments
- Keep documentation up to date

## Getting Help

- **Code reviews:** Tag appropriate team members for review
- **Technical questions:** Contact the project owner: $${parameters.owner}
- **Platform issues:** Contact the platform team