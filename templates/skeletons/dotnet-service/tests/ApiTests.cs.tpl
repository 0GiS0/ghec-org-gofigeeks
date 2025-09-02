using Microsoft.AspNetCore.Mvc.Testing;
using System.Net;
using System.Text.Json;
using Xunit;

namespace ${{values.name | replace("-", "_")}}.Tests;

public class ApiTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;
    private readonly HttpClient _client;

    public ApiTests(WebApplicationFactory<Program> factory)
    {
        _factory = factory;
        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task Get_Root_ReturnsOkWithServiceInfo()
    {
        // Act
        var response = await _client.GetAsync("/");

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        
        var content = await response.Content.ReadAsStringAsync();
        var json = JsonDocument.Parse(content);
        
        Assert.True(json.RootElement.TryGetProperty("Service", out var serviceProperty));
        Assert.True(json.RootElement.TryGetProperty("Message", out var messageProperty));
        Assert.True(json.RootElement.TryGetProperty("Docs", out var docsProperty));
        Assert.True(json.RootElement.TryGetProperty("Health", out var healthProperty));
        
        Assert.Equal("/docs", docsProperty.GetString());
        Assert.Equal("/health", healthProperty.GetString());
    }

    [Fact]
    public async Task Get_Health_ReturnsHealthy()
    {
        // Act
        var response = await _client.GetAsync("/health");

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        
        var content = await response.Content.ReadAsStringAsync();
        Assert.Equal("Healthy", content);
    }

    [Fact]
    public async Task Get_ApiHello_ReturnsHelloResponse()
    {
        // Act
        var response = await _client.GetAsync("/api/hello");

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        
        var content = await response.Content.ReadAsStringAsync();
        var json = JsonDocument.Parse(content);
        
        Assert.True(json.RootElement.TryGetProperty("message", out var messageProperty));
        Assert.True(json.RootElement.TryGetProperty("timestamp", out var timestampProperty));
        Assert.True(json.RootElement.TryGetProperty("service", out var serviceProperty));
    }

    [Fact]
    public async Task Get_ApiStatus_ReturnsStatus()
    {
        // Act
        var response = await _client.GetAsync("/api/status");

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        
        var content = await response.Content.ReadAsStringAsync();
        var json = JsonDocument.Parse(content);
        
        Assert.True(json.RootElement.TryGetProperty("status", out var statusProperty));
        Assert.True(json.RootElement.TryGetProperty("timestamp", out var timestampProperty));
        Assert.True(json.RootElement.TryGetProperty("version", out var versionProperty));
        
        Assert.Equal("OK", statusProperty.GetString());
    }
}