using Microsoft.AspNetCore.Mvc;
using ${{values.name}}.Models;

namespace ${{values.name}}.Controllers;

[ApiController]
[Route("[controller]")]
public class HealthController : ControllerBase
{
    private readonly ILogger<HealthController> _logger;

    public HealthController(ILogger<HealthController> logger)
    {
        _logger = logger;
    }

    [HttpGet]
    public ActionResult<HealthResponse> Get()
    {
        _logger.LogInformation("Health check endpoint called");
        
        return Ok(new HealthResponse
        {
            Status = "OK",
            Service = "${{values.name}}",
            Timestamp = DateTime.UtcNow,
            Version = "1.0.0"
        });
    }
}