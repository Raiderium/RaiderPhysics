module raider.physics.shape;

import raider.math.all;
import raider.physics.bod;
import raider.physics.collider;
import raider.physics.space;
import raider.tools.reference;

/*
 * Collision geometry.
 * 
 * A shape must not outlive its body.
 */
final class Shape
{private
	aabb3f aabb;
	P!Body bod;
	R!Collider collider;

public:
	double friction;    /// Coloumb coefficient of friction for this shape.
	double restitution; /// Restitution, or 'bounciness' of collisions for this shape.

	this(P!Body bod, R!Collider collider = null)
	{
		this.collider = collider;

		friction = 1.0;
		restitution = 0.0;
	}

	~this()
	{
		reset;
	}

	@property vec3 position() { return vec3(); }
	@property void position(vec3 value) { }
	@property mat3 orientation() { mat3 r; return r; }
	@property void orientation(mat3 value) { }

	private void reset()
	{

	}

	void setConvexHull(vec3[] points)
	{
		reset;
	}

	void setTriangleSoup(vec3[] verts, uint[] tris)
	{
		reset;
	}

	void setDisplacementMap(float[] values, uint width)
	{
		reset;
	}

	void setCube(vec3 dim)
	{
		reset;
	}

	void setSphere(double radius)
	{
		reset;
	}
}