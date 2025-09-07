using Microsoft.AspNetCore.Mvc;
using BACKSTAGE_ENTITY_NAME.Models;

namespace BACKSTAGE_ENTITY_NAME.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ExcursionsController : ControllerBase
{
    private readonly ILogger<ExcursionsController> _logger;
    private static readonly List<Excursion> _excursions = new()
    {
        new Excursion
        {
            Id = 1,
            Name = "Mountain Hiking Adventure",
            Description = "A thrilling hike through the scenic mountain trails with breathtaking views",
            Location = "Rocky Mountains",
            Price = 75.00m,
            Duration = 6,
            MaxParticipants = 12,
            CreatedAt = DateTime.UtcNow.AddDays(-10),
            UpdatedAt = DateTime.UtcNow.AddDays(-10)
        },
        new Excursion
        {
            Id = 2,
            Name = "City Food Tour",
            Description = "Explore the best local cuisine and hidden food gems in the city",
            Location = "Downtown",
            Price = 45.00m,
            Duration = 3,
            MaxParticipants = 8,
            CreatedAt = DateTime.UtcNow.AddDays(-5),
            UpdatedAt = DateTime.UtcNow.AddDays(-5)
        }
    };
    private static int _nextId = 3;

    public ExcursionsController(ILogger<ExcursionsController> logger)
    {
        _logger = logger;
    }

    [HttpGet]
    public ActionResult<IEnumerable<Excursion>> GetAllExcursions()
    {
        _logger.LogInformation("Getting all excursions");
        return Ok(_excursions);
    }

    [HttpGet("{id}")]
    public ActionResult<Excursion> GetExcursionById(int id)
    {
        _logger.LogInformation("Getting excursion with id: {Id}", id);

        var excursion = _excursions.FirstOrDefault(e => e.Id == id);
        if (excursion == null)
        {
            _logger.LogWarning("Excursion with id {Id} not found", id);
            return NotFound($"Excursion with id {id} not found");
        }

        return Ok(excursion);
    }

    [HttpPost]
    public ActionResult<Excursion> CreateExcursion([FromBody] CreateExcursionRequest request)
    {
        _logger.LogInformation("Creating new excursion: {Name}", request.Name);

        if (string.IsNullOrWhiteSpace(request.Name))
        {
            return BadRequest("Name is required");
        }

        if (string.IsNullOrWhiteSpace(request.Location))
        {
            return BadRequest("Location is required");
        }

        if (request.Price <= 0)
        {
            return BadRequest("Price must be greater than 0");
        }

        if (request.Duration <= 0)
        {
            return BadRequest("Duration must be greater than 0");
        }

        if (request.MaxParticipants <= 0)
        {
            return BadRequest("MaxParticipants must be greater than 0");
        }

        var newExcursion = new Excursion
        {
            Id = _nextId++,
            Name = request.Name,
            Description = request.Description,
            Location = request.Location,
            Price = request.Price,
            Duration = request.Duration,
            MaxParticipants = request.MaxParticipants,
            CreatedAt = DateTime.UtcNow,
            UpdatedAt = DateTime.UtcNow
        };

        _excursions.Add(newExcursion);

        _logger.LogInformation("Created excursion with id: {Id}", newExcursion.Id);
        return CreatedAtAction(nameof(GetExcursionById), new { id = newExcursion.Id }, newExcursion);
    }

    [HttpPut("{id}")]
    public ActionResult<Excursion> UpdateExcursion(int id, [FromBody] UpdateExcursionRequest request)
    {
        _logger.LogInformation("Updating excursion with id: {Id}", id);

        var excursion = _excursions.FirstOrDefault(e => e.Id == id);
        if (excursion == null)
        {
            _logger.LogWarning("Excursion with id {Id} not found for update", id);
            return NotFound($"Excursion with id {id} not found");
        }

        if (string.IsNullOrWhiteSpace(request.Name))
        {
            return BadRequest("Name is required");
        }

        if (string.IsNullOrWhiteSpace(request.Location))
        {
            return BadRequest("Location is required");
        }

        if (request.Price <= 0)
        {
            return BadRequest("Price must be greater than 0");
        }

        if (request.Duration <= 0)
        {
            return BadRequest("Duration must be greater than 0");
        }

        if (request.MaxParticipants <= 0)
        {
            return BadRequest("MaxParticipants must be greater than 0");
        }

        excursion.Name = request.Name;
        excursion.Description = request.Description;
        excursion.Location = request.Location;
        excursion.Price = request.Price;
        excursion.Duration = request.Duration;
        excursion.MaxParticipants = request.MaxParticipants;
        excursion.UpdatedAt = DateTime.UtcNow;

        _logger.LogInformation("Updated excursion with id: {Id}", id);
        return Ok(excursion);
    }

    [HttpDelete("{id}")]
    public ActionResult DeleteExcursion(int id)
    {
        _logger.LogInformation("Deleting excursion with id: {Id}", id);

        var excursion = _excursions.FirstOrDefault(e => e.Id == id);
        if (excursion == null)
        {
            _logger.LogWarning("Excursion with id {Id} not found for deletion", id);
            return NotFound($"Excursion with id {id} not found");
        }

        _excursions.Remove(excursion);

        _logger.LogInformation("Deleted excursion with id: {Id}", id);
        return NoContent();
    }
}