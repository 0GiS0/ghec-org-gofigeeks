using Microsoft.AspNetCore.Mvc;
using ${{values.name | replace("-", "_")}}.Models;

namespace ${{values.name | replace("-", "_")}}.Controllers;

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
            Service = "${{values.name}}",
            Status = "running",
            Uptime = DateTime.UtcNow - StartTime,
            Environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Development"
        });
    }
}