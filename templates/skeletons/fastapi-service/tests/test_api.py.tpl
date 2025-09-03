import pytest
from fastapi.testclient import TestClient
from app.main import app

# Test configuration
SERVICE_NAME = "${{values.name}}"

client = TestClient(app)


class TestAPI:
    def test_health_endpoint(self):
        """Test health check endpoint."""
        response = client.get("/health")
        assert response.status_code == 200
        data = response.json()
        assert data["status"] == "OK"
        assert data["service"] == SERVICE_NAME
        assert "timestamp" in data
        assert "version" in data

    def test_hello_endpoint(self):
        """Test hello endpoint."""
        response = client.get("/api/hello")
        assert response.status_code == 200
        data = response.json()
        assert data["message"] == f"Hello from {SERVICE_NAME}!"
        assert "timestamp" in data

    def test_status_endpoint(self):
        """Test status endpoint."""
        response = client.get("/api/status")
        assert response.status_code == 200
        data = response.json()
        assert data["service"] == SERVICE_NAME
        assert data["status"] == "running"
        assert "uptime" in data
        assert "environment" in data

    def test_root_endpoint(self):
        """Test root endpoint."""
        response = client.get("/")
        assert response.status_code == 200
        data = response.json()
        assert data["service"] == SERVICE_NAME
        assert data["message"] == "Welcome to the Excursions API"
        assert "endpoints" in data
        assert "excursion_endpoints" in data
        assert data["endpoints"]["excursions"] == "/api/excursions"

    def test_docs_endpoint(self):
        """Test OpenAPI docs endpoint."""
        response = client.get("/docs")
        assert response.status_code == 200

    def test_openapi_json(self):
        """Test OpenAPI schema endpoint."""
        response = client.get("/openapi.json")
        assert response.status_code == 200
        data = response.json()
        assert data["info"]["title"] == SERVICE_NAME


class TestExcursionsAPI:
    def test_get_all_excursions(self):
        """Test getting all excursions."""
        response = client.get("/api/excursions/")
        assert response.status_code == 200
        data = response.json()
        assert isinstance(data, list)
        assert len(data) >= 2  # Should have at least 2 default excursions

        # Check structure of first excursion
        first_excursion = data[0]
        assert "id" in first_excursion
        assert "name" in first_excursion
        assert "description" in first_excursion
        assert "location" in first_excursion
        assert "price" in first_excursion
        assert "duration" in first_excursion
        assert "max_participants" in first_excursion
        assert "created_at" in first_excursion
        assert "updated_at" in first_excursion

    def test_get_excursion_by_id(self):
        """Test getting a specific excursion by ID."""
        response = client.get("/api/excursions/1")
        assert response.status_code == 200
        data = response.json()
        assert data["id"] == 1
        assert "name" in data
        assert "location" in data

    def test_get_excursion_by_invalid_id(self):
        """Test getting an excursion with invalid ID."""
        response = client.get("/api/excursions/999")
        assert response.status_code == 404
        data = response.json()
        assert "detail" in data

    def test_create_excursion(self):
        """Test creating a new excursion."""
        new_excursion = {
            "name": "Beach Walking Tour",
            "description": "A relaxing walk along beautiful beaches",
            "location": "Coastal Area",
            "price": 35.00,
            "duration": 2,
            "max_participants": 15,
        }

        response = client.post("/api/excursions/", json=new_excursion)
        assert response.status_code == 201
        data = response.json()
        assert "id" in data
        assert data["name"] == "Beach Walking Tour"
        assert data["location"] == "Coastal Area"
        assert data["price"] == 35.00
        assert "created_at" in data
        assert "updated_at" in data

    def test_create_excursion_validation_error(self):
        """Test creating an excursion with invalid data."""
        invalid_excursion = {
            "name": "",  # Empty name should fail validation
            "description": "Test description",
            "location": "",  # Empty location should fail validation
            "price": -10.00,  # Negative price should fail validation
            "duration": 0,  # Zero duration should fail validation
            "max_participants": 0,  # Zero participants should fail validation
        }

        response = client.post("/api/excursions/", json=invalid_excursion)
        assert response.status_code == 422  # Validation error
        data = response.json()
        assert "detail" in data

    def test_update_excursion(self):
        """Test updating an existing excursion."""
        updated_data = {
            "name": "Updated Mountain Adventure",
            "description": "Updated description for mountain hiking",
            "location": "Updated Rocky Mountains",
            "price": 85.00,
            "duration": 7,
            "max_participants": 10,
        }

        response = client.put("/api/excursions/1", json=updated_data)
        assert response.status_code == 200
        data = response.json()
        assert data["id"] == 1
        assert data["name"] == "Updated Mountain Adventure"
        assert data["price"] == 85.00
        assert "updated_at" in data

    def test_update_nonexistent_excursion(self):
        """Test updating a non-existent excursion."""
        updated_data = {
            "name": "Updated Name",
            "description": "Updated description",
            "location": "Updated location",
            "price": 50.00,
            "duration": 3,
            "max_participants": 8,
        }

        response = client.put("/api/excursions/999", json=updated_data)
        assert response.status_code == 404
        data = response.json()
        assert "detail" in data

    def test_delete_excursion(self):
        """Test deleting an excursion."""
        # First create an excursion to delete
        new_excursion = {
            "name": "Test Excursion for Deletion",
            "description": "This will be deleted",
            "location": "Test Location",
            "price": 25.00,
            "duration": 1,
            "max_participants": 5,
        }

        create_response = client.post("/api/excursions/", json=new_excursion)
        assert create_response.status_code == 201
        excursion_id = create_response.json()["id"]

        # Now delete it
        delete_response = client.delete(f"/api/excursions/{excursion_id}")
        assert delete_response.status_code == 204

        # Verify it's gone
        get_response = client.get(f"/api/excursions/{excursion_id}")
        assert get_response.status_code == 404

    def test_delete_nonexistent_excursion(self):
        """Test deleting a non-existent excursion."""
        response = client.delete("/api/excursions/999")
        assert response.status_code == 404
        data = response.json()
        assert "detail" in data
