namespace ${{values.name}}.Models;

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

public class Excursion
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public int Duration { get; set; } // Duration in hours
    public int MaxParticipants { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}

public class CreateExcursionRequest
{
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public int Duration { get; set; }
    public int MaxParticipants { get; set; }
}

public class UpdateExcursionRequest
{
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public int Duration { get; set; }
    public int MaxParticipants { get; set; }
}