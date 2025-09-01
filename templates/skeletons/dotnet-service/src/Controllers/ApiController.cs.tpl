using Microsoft.AspNetCore.Mvc;
using $${parameters.name}.Models;

namespace $${parameters.name}.Controllers;

[ApiController]
[Route("api/[controller]")]
public class HelloController : ControllerBase
{
    private readonly ILogger<HelloController> _logger;

    public HelloController(ILogger<HelloController> logger)
    {
        _logger = logger;
    }

    [HttpGet]
    public ActionResult<HelloResponse> Get()
    {
        _logger.LogInformation("Hello endpoint called");
        
        return Ok(new HelloResponse
        {
            Message = "Hello from $${parameters.name}!",
            Timestamp = DateTime.UtcNow
        });
    }
}

[ApiController]
[Route("api/[controller]")]
public class StatusController : ControllerBase
{
    private readonly ILogger<StatusController> _logger;
    private static readonly DateTime StartTime = DateTime.UtcNow;

    public StatusController(ILogger<StatusController> logger)
    {
        _logger = logger;
    }

    [HttpGet]
    public ActionResult<StatusResponse> Get()
    {
        _logger.LogInformation("Status endpoint called");
        
        return Ok(new StatusResponse
        {
            Service = "$${parameters.name}",
            Status = "running",
            Uptime = DateTime.UtcNow - StartTime,
            Environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Development"
        });
    }
}