using Microsoft.AspNetCore.Mvc;
using ${parameters.name}.Models;

namespace ${parameters.name}.Controllers;

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
            Service = "${parameters.name}",
            Timestamp = DateTime.UtcNow,
            Version = "1.0.0"
        });
    }
}