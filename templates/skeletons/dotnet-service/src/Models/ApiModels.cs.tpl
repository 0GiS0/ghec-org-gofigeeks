namespace $${parameters.name}.Models;

public class HealthResponse
{
    public string Status { get; set; } = string.Empty;
    public string Service { get; set; } = string.Empty;
    public DateTime Timestamp { get; set; }
    public string Version { get; set; } = string.Empty;
}

public class HelloResponse
{
    public string Message { get; set; } = string.Empty;
    public DateTime Timestamp { get; set; }
}

public class StatusResponse
{
    public string Service { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
    public TimeSpan Uptime { get; set; }
    public string Environment { get; set; } = string.Empty;
}