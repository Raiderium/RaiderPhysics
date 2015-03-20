module raider.physics.surface;

/**
 * Properties of a physical surface.
 */
class Surface
{
	double friction;    /// Coloumb coefficient of friction
	double restitution; /// Restitution, or 'bounciness' of collisions for this shape.

	this()
	{
		friction = 1.0;
		restitution = 0.0;
	}
}

