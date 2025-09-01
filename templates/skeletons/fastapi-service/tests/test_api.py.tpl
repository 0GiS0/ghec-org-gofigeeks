import pytest
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

class TestAPI:
    def test_health_endpoint(self):
        """Test health check endpoint."""
        response = client.get("/health")
        assert response.status_code == 200
        data = response.json()
        assert data["status"] == "OK"
        assert data["service"] == "${parameters.name}"
        assert "timestamp" in data
        assert "version" in data

    def test_hello_endpoint(self):
        """Test hello endpoint."""
        response = client.get("/api/hello")
        assert response.status_code == 200
        data = response.json()
        assert data["message"] == "Hello from ${parameters.name}!"
        assert "timestamp" in data

    def test_status_endpoint(self):
        """Test status endpoint."""
        response = client.get("/api/status")
        assert response.status_code == 200
        data = response.json()
        assert data["service"] == "${parameters.name}"
        assert data["status"] == "running"
        assert "uptime" in data
        assert "environment" in data

    def test_root_endpoint(self):
        """Test root endpoint."""
        response = client.get("/")
        assert response.status_code == 200
        data = response.json()
        assert data["service"] == "${parameters.name}"
        assert "docs" in data
        assert "health" in data

    def test_docs_endpoint(self):
        """Test OpenAPI docs endpoint."""
        response = client.get("/docs")
        assert response.status_code == 200

    def test_openapi_json(self):
        """Test OpenAPI schema endpoint."""
        response = client.get("/openapi.json")
        assert response.status_code == 200
        data = response.json()
        assert data["info"]["title"] == "${parameters.name}"