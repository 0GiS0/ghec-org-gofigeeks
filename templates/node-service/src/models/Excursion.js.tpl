class Excursion {
  constructor(id, name, description, location, price, duration, maxParticipants) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.location = location;
    this.price = price;
    this.duration = duration; // Duration in hours
    this.maxParticipants = maxParticipants;
    this.createdAt = new Date();
    this.updatedAt = new Date();
  }

  static fromRequest(data) {
    return new Excursion(
      null, // ID will be assigned by the repository
      data.name,
      data.description,
      data.location,
      data.price,
      data.duration,
      data.maxParticipants
    );
  }

  updateFromRequest(data) {
    this.name = data.name;
    this.description = data.description;
    this.location = data.location;
    this.price = data.price;
    this.duration = data.duration;
    this.maxParticipants = data.maxParticipants;
    this.updatedAt = new Date();
  }

  static validateCreateRequest(data) {
    const errors = [];

    if (!data.name || data.name.trim().length === 0) {
      errors.push('Name is required');
    }

    if (!data.location || data.location.trim().length === 0) {
      errors.push('Location is required');
    }

    if (!data.price || data.price <= 0) {
      errors.push('Price must be greater than 0');
    }

    if (!data.duration || data.duration <= 0) {
      errors.push('Duration must be greater than 0');
    }

    if (!data.maxParticipants || data.maxParticipants <= 0) {
      errors.push('MaxParticipants must be greater than 0');
    }

    return errors;
  }
}

module.exports = Excursion;